function AdbGenerateConfigFile(config_file_path, other_config)
  
    fid = fopen(config_file_path, 'w'); 
    
    ConfigFileDumpField(fid, 'InputConfigFilePath', '/data/dpd_config.txt');
    ConfigFileDumpField(fid, 'InputRawFolder', '/data/');
    ConfigFileDumpField(fid, 'InputRawFileName', 'dpd_raw.raw');
    ConfigFileDumpField(fid, 'InputRawDPDFilePath', '/data/dpd_raw.raw');
    ConfigFileDumpField(fid, 'InputRawWidth', other_config.raw_width);
    ConfigFileDumpField(fid, 'InputRawHeight', other_config.raw_height);
    ConfigFileDumpField(fid, 'InputSensorType', other_config.input_sensor_type);
    ConfigFileDumpField(fid, 'InputRawCalibrationBinary', '/data/dpd_calib.bin');
    ConfigFileDumpField(fid, 'OutputFolder', '/data/');
    ConfigFileDumpFieldFloat(fid, 'InputPoiXRatio', other_config.poi_x_ratio);
    ConfigFileDumpFieldFloat(fid, 'InputPoiYRatio', other_config.poi_y_ratio);    
    
    ConfigFileDumpField(fid, 'OutputResultInfoPath', '/data/dpd/dpd_raw_result.txt');
    ConfigFileDumpField(fid, 'OutputGridInfoPath', '/data/dpd/dpd_raw_grid.txt');
    ConfigFileDumpField(fid, 'OutputCalibInfoPath', '/data/dpd/dpd_raw_calib.txt');
    ConfigFileDumpField(fid, 'OutputClassifyInfoPath', '/data/dpd/dpd_raw_classify.txt');
    
    if isfield(other_config, 'enable_time_profiling') && other_config.enable_time_profiling 
        ConfigFileDumpField(fid, 'DebugEnableTimeProfile', 'enable');
    end
    
    if isfield(other_config, 'sad_info_debug') && other_config.sad_info_debug
        ConfigFileDumpField(fid, 'OutputSADResultPath', '/data/dpd/dpd_raw_sad.txt');
    end
    
    fclose(fid);
end

