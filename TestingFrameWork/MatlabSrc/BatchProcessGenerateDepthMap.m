function BatchProcessGenerateDepthMap
    clear;
    UtilCloseAll();

    select = 'pen and newspaper';
    %select = 'bottle and teabag';
    
    %process_type = 'android';
    process_type = 'windows';
    
    [raw_folder, calib_file_path, output_folder, display_ratio] = ...
        LoadDefaultFolderSettings(select);
    
    raw_files = dir([raw_folder '*.raw']);
    raw_files_len = length(raw_files);

    if raw_files_len<=0
        fprintf('Error! contains no raw images in folder\n');
        return;
    end
    
    if raw_files_len == 1
        initial_raw_idx = 1;
    else
        initial_raw_idx = int(floor(raw_files_len/2));
    end
    raw_file_name = raw_files(initial_raw_idx).name;
    raw_file_path = [raw_folder raw_file_name];
    
    dim_config = LoadDefaultDimConfig();
    
    [left_image] = RawImageSplit(...
        raw_file_path, ...
        dim_config.raw_width, ...
        dim_config.raw_height);
   
    ShowFullScreenImage(left_image, display_ratio);
    
    other_config.select_poi_from_ui = false;
    
    if other_config.select_poi_from_ui
        [x_loc, y_loc] = UiWaitMouseInput(left_image);
    else
        x_loc = dim_config.poi_x_ratio;
        y_loc = dim_config.poi_y_ratio;
    end
      
    dim_config.poi_x_ratio = x_loc;
    dim_config.poi_y_ratio = y_loc;
    
    dim_config.sad_info_debug = true;
    
    other_config.enable_time_profiling = false;
    other_config.display_option = false;

    FileOperationClearFolder(output_folder);
      
    [dpd_result, grid_info, sad_info] = ...
        ProcessDepthMap(...
            raw_folder, ...
            raw_file_name, ...
            calib_file_path, ...
            dim_config, ...
            output_folder, ...
            process_type);
        
%     if other_config.display_option
%         DisplayProcessedImageResult(raw_file_name, dpd_result, grid_info, output_folder);
%     end
    
%    predicted_raw_file = FileNameGetRawFilePathByLensLoc(raw_files, dpd_result, initial_raw_idx);

%    predicted_raw_path = [raw_folder, predicted_raw_file];
    
    [left_image] = RawImageSplit(...
        raw_file_path, ...
        dim_config.raw_width, ...
        dim_config.raw_height);

    imshow(display_ratio*left_image);
    
%    if dim_config.sad_info_debug
%        ShowSearchedGrid(sad_info);
%        DisplaySADResult(sad_info, output_folder, raw_file_name);
%    end
%    ShowProcessedGrid(grid_info);
%    ShowFocusedGrid(dpd_result.ProcInfo);
%    ShowResultString(dpd_result.ProcInfo);
%    DisplayClassifyResult(dpd_result);
end