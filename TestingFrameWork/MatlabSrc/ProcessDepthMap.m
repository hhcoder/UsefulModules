function [dpd_result, grid_info, sad_info] = ProcessDepthMap(...
    raw_folder, ...
    raw_file_name, ...
    calib_file_path, ...
    dim_config, ...
    output_folder, ...
    process_type)
   
    config_file_path = CmdLineGetConfigFilePathFromRaw(output_folder, raw_file_name);

    CmdLineGenerateConfigFile(raw_folder, raw_file_name, calib_file_path, dim_config, output_folder, config_file_path);

    switch lower(process_type)
        case 'android'
            ProcessImageAdb(raw_folder, raw_file_name, calib_file_path, config_file_path, dim_config);
        case 'windows'
            ProcessImageWinCmdLine(config_file_path);
    end
    
     [dpd_result, grid_info, sad_info] = AnalyzeImageResult(output_folder, raw_file_name);
end
