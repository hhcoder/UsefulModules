function ret = ProcessImage(folder_setting)

    close all;
    executable_setting = LoadExecutableSetting('windows', 'release');
    dim_setting = LoadDimSetting();
    display_option = LoadDisplayOption();
    LoadMatlabSetting(folder_setting);

    config_file_path = ConfigFileGenerate(folder_setting, dim_setting);
    
    ExecutableRun(executable_setting, folder_setting, config_file_path);
    
    [ret.original_image] = OriginalImageAnalyze(folder_setting, display_option);
       	
    [ret.raw_left, ret.raw_right] = RawFrameAnalyze(folder_setting, dim_setting, display_option);
    
    [ret.integ_left, ret.integ_right] = IntegratedFrameAnalyze(folder_setting, display_option);
    
    [ret.filtered_left, ret.filtered_right] = FilteredFrameAnalyze(folder_setting, display_option);
    
    [ret.high_res_pd] = HighResPdFrameAnalyze(folder_setting, display_option);
    [ret.high_res_conf] = HighResConfFrameAnalyze(folder_setting, display_option);
    
    [ret.pd_pyramid, ret.conf_pyramid] = PyramidDepthMapAnalyze(folder_setting, display_option);
    
    [ret.final_dmap, ret.final_cmap] = BinaryDepthMapRead(folder_setting, display_option);

    [X, Y, Z, texture] = ResultDepthImageAnalyze(folder_setting, ret.final_dmap, ret.final_cmap, display_option);
    
    [ret.orginal_y, ret.sparse_depth, ret.dense_depth] = GuidedFilterAnalyze(folder_setting, display_option);
    
    [ret.bokeh, ret.blurry] = BokehAnalyze(folder_setting, display_option);

	%DisplayDepthMapMask(folder_setting, ret.final_dmap, display_option);
        
end