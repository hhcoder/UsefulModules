function [dpd_result, grid_info, sad_info] = AnalyzeImageResult(output_folder, raw_file_name)

    config_file_path = CmdLineGetConfigFilePathFromRaw(output_folder, raw_file_name);

    config = ParseConfigFile(config_file_path);

    calib_info = ParseCalibInfoLog(config.OutputCalibInfoPath);

    if isfield(config, 'OutputSADResultPath')
        sad_info = ParseSadInfoLog(config.OutputSADResultPath, config.OutputFolder);
    else
        sad_info = 'no sad info available';
    end
    
    grid_info = ParseGridInfoLog(config.OutputGridInfoPath);
    
    proc_info = ParseResultLog(config.OutputResultInfoPath);
    
    %classify_info = ParseClassifyInfoLog(config.OutputClassifyInfoPath);
    classify_info = 0;
    
    lens_pos = FileNameGetLensPositionFromRaw(raw_file_name);

    [left_image, right_image] = RawImageSplit(...
        config.InputRawDPDFilePath, ...
        config.InputRawWidth, ...
        config.InputRawHeight);

    dpd_result = struct(...
        'LeftImage', left_image, ...
        'RightImage', right_image, ...
        'CalibInfo', calib_info, ...
        'ProcInfo', proc_info,...
        'ClassifyInfo', classify_info, ...
        'lens_pos', lens_pos);
end