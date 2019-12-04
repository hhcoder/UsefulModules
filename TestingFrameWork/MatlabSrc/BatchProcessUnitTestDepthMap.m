function BatchProcessUnitTestDepthMap

    %% Folder Path and CmdLine Execution
    clear;
    close all;
    
    src_config_loc = '..\..\SourceImages\UnitTest\TestCommand.txt';
    src_folder = '..\..\SourceImages\UnitTest\';
    dst_folder = '..\..\ProcessedResults\UnitTest\';
    curr_folder = '.\';

    src_exe_folder = '..\..\Development\build\vs\UnitTest\Debug\';
    src_exe_name = 'DualPDDepthMapUnitTest.exe';

    src_exe_path = [src_exe_folder src_exe_name];

    cp_cmd = sprintf('COPY %s %s', src_exe_path, curr_folder);

    dos(cp_cmd);
    
    clear_result_path = dst_folder;
    
    clear_cmd = sprintf('@ECHO Y | DEL %s\*.*', clear_result_path);
    
    dos(clear_cmd);

    proc_exe_path = [curr_folder src_exe_name];

    proc_cmd = sprintf('%s %s', proc_exe_path, src_config_loc);

    dos(proc_cmd);

    %% Raw Test
    raw_image_name = 'test_img_reader.raw'; %from config

    raw_image_path = [dst_folder raw_image_name];

    raw_width = 4032; %from config
    raw_height = 756; %from config
    [left_raw, right_raw] = RawImageSplit(raw_image_path, raw_width, raw_height);

    figure,
    subplot(2,1,1), imshow(left_raw), title('Left Raw');
    subplot(2,1,2), imshow(right_raw), title('Right Raw');

    %% Integrate Test
    column_binning = 8; %from config
    left_integrated_frame_name = 'left_integrated_frame.raw'; %from config
    left_integrated_frame_path = [dst_folder left_integrated_frame_name];

    right_integrated_frame_name = 'right_integrated_frame.raw'; %from config
    right_integrated_frame_path = [dst_folder right_integrated_frame_name];

    integrated_width = raw_width / 2;
    integrated_height = ceil(raw_height/column_binning);

    left_integrated_frame = RawImageRead(left_integrated_frame_path, integrated_width, integrated_height);
    left_integrated_frame = left_integrated_frame./1024;
    right_integrated_frame = RawImageRead(right_integrated_frame_path, integrated_width, integrated_height);
    right_integrated_frame = right_integrated_frame./1024;

    figure,
    subplot(2,1,1), imshow(left_integrated_frame), title('Left Integrated');
    subplot(2,1,2), imshow(right_integrated_frame), title('Right Integrated');
    
    %% IIR Test
    iir_test_width = integrated_width;
    iir_test_height = integrated_height;
    left_iir_frame_name = 'left_iir.raw';
    left_iir_frame_path = [dst_folder left_iir_frame_name];
    left_iir_frame = RawImageRead(left_iir_frame_path, iir_test_width, iir_test_height);
    left_iir_frame_unsigned = abs(left_iir_frame-32767)./128;
    
    figure,
    subplot(2,1,1), imshow(left_integrated_frame), title('Left Integrated');
    subplot(2,1,2), imshow(left_iir_frame_unsigned), title('Left IIRed');
    
    %% Sad Proc Test
    l_range = 20; %from config
    r_range = 20; %from config
    ref_signal_fname = 'sad_ref_signal.txt';
    ref_signal_path = [dst_folder ref_signal_fname];
    ref_signal = ParseNumberSeries(ref_signal_path);
    
    moving_signal_fname = 'sad_moving_signal.txt';
    moving_signal_path = [dst_folder moving_signal_fname];
    moving_signal = ParseNumberSeries(moving_signal_path);
    min_v = min(ref_signal);
    plot_moving_signal = [min_v*ones(1,l_range) moving_signal min_v*ones(1, r_range)];
    
    sad_result_signal_fname = 'sad_signal_result.txt';
    sad_result_signal_path = [dst_folder sad_result_signal_fname];
    sad_result_signal = ParseNumberSeries(sad_result_signal_path);    
    
    figure,
    subplot(4,1,1), plot(ref_signal), title('Ref Signal');
    subplot(4,1,2), plot(plot_moving_signal), title('Moving Signal');
    subplot(4,1,3), plot(sad_result_signal), title('SAD Signal');    

    %%Sad Proc Matching Test
    sad_unit_result_fname = 'sad_unit_result.txt';
    sad_unit_result_path = [dst_folder sad_unit_result_fname];
    sad_tmps = ParseNumberSeries(sad_unit_result_path);    
    
    min_idx = sad_tmps(1);
    min_vals = sad_tmps(2:4);
    
    min_v_disp = mean(sad_result_signal);
    min_vals_plot = [min_v_disp*ones(1,min_idx-1) min_vals min_v_disp*ones(1, length(sad_result_signal)-min_idx+2)];
    subplot(4,1,4), plot(min_vals_plot), title(sprintf('Minidx: %d, MinVals: (%d, %d, %d)', min_idx, min_vals(1), min_vals(2), min_vals(3)));

   
    %% PD Interp Test
    sad_interp_result_fname = 'sad_interp_result.txt';
    sad_interp_result_path = [dst_folder sad_interp_result_fname];
    sad_tmps = ParseNumberSeries(sad_interp_result_path);        
    min_idx = sad_tmps(1);
    min_vals = sad_tmps(2:4);    
    sad_interp_result = sad_tmps(5);
    
    orig_x = [min_idx-1 min_idx min_idx+1];
    orig_y = min_vals;
    
    xq = orig_x(1):0.01:orig_x(3);
    s1 = spline(orig_x,orig_y,xq);
    
    figure,
    plot(orig_x, orig_y, 'o--', 'Color', 'g');
    hold on
    plot(xq, s1, 'b--');
    line([sad_interp_result sad_interp_result ], [max(sad_tmps) min(sad_tmps)], 'Color', 'r');
    legend('Original', 'Cubic', 'Predicted');

    %% Windowing Test
    grid_info_result_fname = 'window_slicing_result.txt';
    grid_infO_result_path = [dst_folder grid_info_result_fname];
    
    [img_info, grid_info] = ParseDepthMapGridInfo(grid_infO_result_path);
    img = ones(img_info.height, img_info.width);
    ShowDepthMapGridInfo(img, grid_info);
    
    %% Pyramid Image Test
    pd_src_fname = 'pd_frame_result.txt';
    pd_src_path = [dst_folder pd_src_fname];
    [pd_info, pd_frame] = ParsePdFrameInfo(pd_src_path);
    
    pd_level_0_fname = 'pyramid_framepd0_251x95.txt';
    [pd_level_0_info, pd_level_0_frame] = ParsePdFrameInfo([dst_folder pd_level_0_fname]);
    
    pd_level_1_fname = 'pyramid_framepd1_125x47.txt';
    [pd_level_1_info, pd_level_1_frame] = ParsePdFrameInfo([dst_folder pd_level_1_fname]);

    pd_level_2_fname = 'pyramid_framepd2_62x23.txt';
    [pd_level_2_info, pd_level_2_frame] = ParsePdFrameInfo([dst_folder pd_level_2_fname]);

    pd_level_3_fname = 'pyramid_framepd3_31x11.txt';
    [pd_level_3_info, pd_level_3_frame] = ParsePdFrameInfo([dst_folder pd_level_3_fname]);
    
    subplot(2,2,1), imshow(pd_level_0_frame);
    subplot(2,2,2), imshow(pd_level_1_frame);
    subplot(2,2,3), imshow(pd_level_2_frame);
    subplot(2,2,4), imshow(pd_level_3_frame);  

end

