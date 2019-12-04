#include "../dual_pd_api/public/dualpd_system_c.h"

#include "./cmdline_cfg_parser.h"
#include "./cmdline_image_reader.h"
#include "./cmdline_profiler.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <memory.h>

#define DBG_PRINT_FUNCTION_ENTRY   (printf("%s: Entry\n", __FUNCTION__));
#define DBG_PRINT_FUNCTION_EXIT    (printf("%s: Exit\n", __FUNCTION__));

#define CMDLINE_SUCCESS         (1)
#define CMDLINE_FAIL            (0)

int WriteRawBuf(const char* result_str, const void* dst_buf, const int32_t width, const int32_t height, const size_t dst_size)
{
	char out_fname[256];
	sprintf(out_fname, "%s_%dx%d%s", result_str, width, height, ".raw");
	FILE* fp = fopen(out_fname, "wb");
	if (NULL == fp)
		return CMDLINE_FAIL;
	fwrite(dst_buf, sizeof(uint8_t), dst_size, fp);

	fclose(fp);

	return CMDLINE_SUCCESS;
}

int main(int argc, char* argv[])
{
	if (argc < 2)
	{
		printf("Error in argv line input\n");
		printf("Syntax: exe config.txt\n");
		return -1;
	}

	printf("\n======================\n  Start DualPD Depth Map testing \n======================\n");

	ConfigParser* cfg_parser = ConfigParserCreate(argv[1]);
	if (NULL==cfg_parser)
		return -1;

	int32_t ver_main;
	int32_t ver_major;
	int32_t ver_minor;
	DpdSystemVersionInfo(&ver_main, &ver_major, &ver_minor);

	printf("\n Dual Pd System Version Info: %d.%d.%d \n", ver_main, ver_major, ver_minor);

	dpdsys_handle_t s = DpdSystemCreate();
	if (NULL == s)
	{
		printf("\n Error in DpdSystemCreate! \n");
		return -1;
	}

	const char* raw_str = ConfigParserGetProperty(cfg_parser, "Source2PdRawDataPath");
	const char* raw_width = ConfigParserGetProperty(cfg_parser, "Source2pdRawWidth");
	const char* raw_height = ConfigParserGetProperty(cfg_parser, "Source2pdRawHeight");
	const char* raw_format = ConfigParserGetProperty(cfg_parser, "Source2pdRawFormat");

	ImageReader* img_reader = ImageReaderCreate(raw_str, raw_format, raw_width, raw_height);
	if (NULL == img_reader)
	{
		printf("\n Error opening %s! \n", raw_str);
		printf("Exit now...\n");
		return -1;
	}

	const char* yuv_path = ConfigParserGetProperty(cfg_parser, "SourceYuvDataPath");
	const char* yuv_width_str = ConfigParserGetProperty(cfg_parser, "SourceYuvWidth");
	const char* yuv_height_str = ConfigParserGetProperty(cfg_parser, "SourceYuvHeight");
	YuvReader* yuv_reader = YuvReaderCreate(yuv_path, yuv_width_str, yuv_height_str);
	if (NULL == yuv_reader)
	{
		printf("\n Error opening %s! \n", yuv_path);
		printf("Exit now...\n");
		return -1;
	}

	const char* max_disparity_str = ConfigParserGetProperty(cfg_parser, "SourceMaxDisparityValue");
	if (NULL == max_disparity_str)
	{
		printf("\n Error in Config file, missing SourceMaxDisparityValue\n");
		return -1;
	}

	dpdsys_init_t in_init;
	
	in_init.dualpd_width = img_reader->width;
	in_init.dualpd_height = img_reader->height;
	in_init.dualpd_stride = img_reader->width;
	in_init.dualpd_unpacked = 1;
	in_init.dualpd_bits_per_pixel = 10;
	in_init.dualpd_lr_pattern = 1;
	in_init.dualpd_max_disparity = atoi(max_disparity_str);
	const char* lens_macro_loc_str = ConfigParserGetProperty(cfg_parser, "SourceLensMacroLoc");
	if (NULL != lens_macro_loc_str)
		in_init.lens_macro_loc = atoi(lens_macro_loc_str);
	else
		in_init.lens_macro_loc = 0;

	const char* lens_infinity_loc_str = ConfigParserGetProperty(cfg_parser, "SourceLensInfinityLoc");
	if (NULL != lens_infinity_loc_str)
		in_init.lens_infinite_loc = atoi(lens_infinity_loc_str);
	else
		in_init.lens_infinite_loc = 900;

	uint32_t ret;

	ret = DpdSystemInitialize(s, &in_init);

	if (DpdSystemIsFail(ret))
	{
		printf("\n Error: DpdSystemInitialize \n");
		return -1;
	}

	dpdsys_sparse_map_init_t sparse_setting;
	ret = DpdSparseDepthMapInitialize(s, &sparse_setting);
	if (DpdSystemIsFail(ret))
	{
		printf("\n Failure in Dpddm_Config! \n");
		printf("\n Error code: %d \n", ret);
		printf("Exit now...\n");
		return -1;
	}

	dpdsys_dense_map_init_t dense_setting;
	dense_setting.yuv_width = yuv_reader->y_width;
	dense_setting.yuv_height = yuv_reader->y_height;
	dense_setting.y_stride = yuv_reader->y_width;
	dense_setting.uv_stride = yuv_reader->y_width;
	dense_setting.sparse_width = sparse_setting.width;
	dense_setting.sparse_height = sparse_setting.height;

	ret = DpdDenseDepthMapInitialize(s, &dense_setting);
	if (DpdSystemIsFail(ret))
	{
		printf("\n Failure in DpdDenseDepthMapInitialize! \n");
		printf("\n Error code: %d \n", ret);
		printf("Exit now...\n");
		return -1;
	}

	dpdsys_bokeh_init_t bokeh_setting;
	bokeh_setting.yuv_width = yuv_reader->y_width;
	bokeh_setting.yuv_height = yuv_reader->y_height;
	bokeh_setting.y_stride = yuv_reader->y_width;
	bokeh_setting.uv_stride = yuv_reader->y_width;
	bokeh_setting.dense_width = dense_setting.dst_dense_width;
	bokeh_setting.dens_height = dense_setting.dst_dense_height;

	ret = DpdBokehInitialize(s, &bokeh_setting);

	void* dst_sparse_dmap_buf = malloc(sparse_setting.size_in_bytes);
	if (NULL == dst_sparse_dmap_buf)
		return -1;

	void* dst_sparse_cmap_buf = malloc(sparse_setting.size_in_bytes);
	if (NULL == dst_sparse_cmap_buf)
		return -1;

	void* dst_dense_dmap_buf = malloc(dense_setting.dst_dense_size_in_bytes);

	uint32_t loop_count = 1;
	
	const char* loop_str = ConfigParserGetProperty(cfg_parser, "CmdlineOptionLoopCount");
	if (loop_str != NULL)
		loop_count = atoi(loop_str);

	Profiler* profiler = ProfilerCreate(loop_count);

	const char* lens_curr_loc_str = ConfigParserGetProperty(cfg_parser, "SourceLensCurrentLoc");
	uint32_t curr_lens_loc = 450;
	if (NULL != lens_curr_loc_str)
		curr_lens_loc = atoi(lens_curr_loc_str);

	for (uint32_t i = 0; i < loop_count; i++)
	{
		ProfilerStartSession(profiler);

		dpdsys_src_t proc;
		proc.src_buf = img_reader->buf;
		proc.curr_lens_loc = curr_lens_loc;

		ret = DpdSystemCoreStart(s, &proc);

		if (DpdSystemIsFail(ret))
		{
			printf("\n Failure in DpdSystemCoreStart!\n");
			printf("\n Error code: %d \n", ret);
			printf("Exit now...\n");
			return -1;
		}

		dpdsys_sparse_depth_result_t sparse_result;
		sparse_result.dst_depth_map = dst_sparse_dmap_buf;
		sparse_result.dst_confidence_map = dst_sparse_cmap_buf;

		ret = DpdSparseDepthMapGetResult(s, &sparse_result);
		if (DpdSystemIsFail(ret))
		{
			printf("\n Failure in DpdSparseDepthMapGetResult!\n");
			printf("\n Error code: %d \n", ret);
			printf("Exit now...\n");
			return -1;
		}

		dpdsys_dense_map_result_t dense_result;
		dense_result.src_y_buf = yuv_reader->y_buf;
		dense_result.src_uv_buf = yuv_reader->uv_buf;
		dense_result.src_sparse_depth_map = sparse_result.dst_depth_map;
		dense_result.src_sparse_conf_map = sparse_result.dst_confidence_map;
		dense_result.dst_dense_depth_map = dst_dense_dmap_buf;
		ret = DpdDensDepthMapGetResult(s, &dense_result);
		if (DpdSystemIsFail(ret))
		{
			printf("\n Failure in DpdDensDepthMapGetResult!\n");
			printf("\n Error code: %d \n", ret);
			printf("Exit now...\n");
			return -1;
		}

		dpdsys_bokeh_result_t bokeh_result;
		bokeh_result.yuv_src_dst = yuv_reader->y_buf;
		bokeh_result.src_dense_depth_map = dense_result.dst_dense_depth_map;
		ret = DpdBokehGetResult(s, &bokeh_result);
		if (DpdSystemIsFail(ret))
		{
			printf("\n Failure in DpdBokehGetResult!\n");
			printf("\n Error code: %d \n", ret);
			printf("Exit now...\n");
			return -1;
		}
		
		ProfilerEndSession(profiler);
	}

	float avg_time_ms = ProfilerGetAverageTime(profiler);

	printf("\n Average running time (%d iterations): %.2f MS\n", loop_count, avg_time_ms);

	ProfilerDestroy(profiler);

	const char* sparse_dmap_out_path = ConfigParserGetProperty(cfg_parser, "ResultDepthMapPath");
	if (NULL != sparse_dmap_out_path)
	{
		printf("\n Result writes to %s, [WxH]=[%dx%d]\n", sparse_dmap_out_path, sparse_setting.width, sparse_setting.height);
		WriteRawBuf(sparse_dmap_out_path, dst_sparse_dmap_buf, sparse_setting.width, sparse_setting.height, sparse_setting.size_in_bytes);
	}

	const char* sparse_conf_out_path = ConfigParserGetProperty(cfg_parser, "ResultConfidenceMapPath");
	if (NULL != sparse_conf_out_path)
	{
		printf("\n Confidence Map writes to %s, [WxH]=[%dx%d]\n", sparse_conf_out_path, sparse_setting.width, sparse_setting.height);
		WriteRawBuf(sparse_conf_out_path, dst_sparse_cmap_buf, sparse_setting.width, sparse_setting.height, sparse_setting.size_in_bytes);
	}

	const char* dense_map_out_path = ConfigParserGetProperty(cfg_parser, "ResultDenseMapPath");
	if (NULL != dense_map_out_path)
	{
		printf("\n Dense Map Result writes to %s, [WxH]=[%dx%d]\n", dense_map_out_path, dense_setting.dst_dense_width, dense_setting.dst_dense_height);
		WriteRawBuf(dense_map_out_path, dst_dense_dmap_buf, dense_setting.dst_dense_width, dense_setting.dst_dense_height, dense_setting.dst_dense_size_in_bytes);
	}

	const char* bokeh_out_path = ConfigParserGetProperty(cfg_parser, "ResultBokehPath");
	if (NULL != bokeh_out_path)
	{
		printf("\n Bokeh result writes to %s, [WxH] = [%dx%d]\n", bokeh_out_path, bokeh_setting.yuv_width, bokeh_setting.yuv_height);
		const size_t yuv_size = bokeh_setting.yuv_width*bokeh_setting.yuv_height + bokeh_setting.yuv_width*bokeh_setting.yuv_height/2;
		WriteRawBuf(bokeh_out_path, yuv_reader->y_buf, bokeh_setting.yuv_width, bokeh_setting.yuv_height, yuv_size);
	}

	ret = DpdSystemTerminate(s);
	if (DpdSystemIsFail(ret))
	{
		printf("\n Failure in DpdSystemTerminate!\n");
		printf("\n Error code: %d \n", ret);
		printf("Exit now...\n");
		return -1;
	}

	if(NULL!=dst_sparse_dmap_buf)
		free(dst_sparse_dmap_buf);
	if (NULL != dst_sparse_cmap_buf)
		free(dst_sparse_cmap_buf);

	ImageReaderDestroy(img_reader);
	YuvReaderDestroy(yuv_reader);
	ConfigParserDestroy(cfg_parser);	

	ret = DpdSystemDestroy(s);
	if (DpdSystemIsFail(ret))
	{
		printf("\n Failure in DpdSystemDestroy!\n");
		printf("\n Error code: %d\n", ret);
		return -1;
	}

	printf("\n======================\n  End DualPD Depth Map testing \n======================\n");

	return 0;
}