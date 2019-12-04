function CmdLineGenerateConfigFile(raw_folder, raw_file_name, calib_file_path, other_config, output_folder, config_file_path)
    fid = fopen(config_file_path, 'w');

    ConfigFileDumpField(fid, 'InputConfigFilePath', config_file_path);
    ConfigFileDumpField(fid, 'InputRawFolder', raw_folder);
    ConfigFileDumpField(fid, 'InputRawFileName', raw_file_name);
    ConfigFileDumpField(fid, 'InputRawDPDFilePath', [raw_folder raw_file_name]);
    ConfigFileDumpField(fid, 'InputRawWidth', other_config.raw_width);
    ConfigFileDumpField(fid, 'InputRawHeight', other_config.raw_height);
    ConfigFileDumpField(fid, 'InputSensorType', other_config.input_sensor_type);
    ConfigFileDumpField(fid, 'InputRawCalibrationBinary', calib_file_path);
    ConfigFileDumpField(fid, 'OutputFolder', output_folder);
    ConfigFileDumpFieldFloat(fid, 'InputPoiXRatio', other_config.poi_x_ratio);
    ConfigFileDumpFieldFloat(fid, 'InputPoiYRatio', other_config.poi_y_ratio);    
    
    OutputResultInfoPath = [output_folder FileNameReplaceWith(raw_file_name, '.raw', '_result.txt')];
    ConfigFileDumpField(fid, 'OutputResultInfoPath', OutputResultInfoPath);
    
    OutputGridInfoPath =  [output_folder FileNameReplaceWith(raw_file_name, '.raw', '_grid.txt')];
    ConfigFileDumpField(fid, 'OutputGridInfoPath', OutputGridInfoPath);
    
    OutputCalibInfoPath =  [output_folder FileNameReplaceWith(raw_file_name, '.raw', '_calib.txt')];
    ConfigFileDumpField(fid, 'OutputCalibInfoPath', OutputCalibInfoPath);
    
    OutputClassifyInfoPath = [output_folder FileNameReplaceWith(raw_file_name, '.raw', '_classify.txt')];
    ConfigFileDumpField(fid, 'OutputClassifyInfoPath', OutputClassifyInfoPath);
    
    if isfield(other_config, 'sad_info_debug') && other_config.sad_info_debug
        OutputSADResultPath = [output_folder FileNameReplaceWith(raw_file_name, '.raw', '_sad.txt')];
        ConfigFileDumpField(fid, 'OutputSADResultPath', OutputSADResultPath);
    end
    
    fclose(fid);
end