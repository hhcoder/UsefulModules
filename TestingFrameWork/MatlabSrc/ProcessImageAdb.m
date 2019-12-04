function ProcessImageAdb(raw_folder, raw_file_name, calib_file_path, config_file_path, other_config)

    FileOperationClearFolder('.\Tmp\');
    
    AdbClear();

    AdbPushExecutables();

    adb_config_path = './Tmp/dpd_config.txt';
    AdbGenerateConfigFile(adb_config_path, other_config);

    raw_file_path = [raw_folder, raw_file_name];
    AdbPushSourceData(raw_file_path, adb_config_path, calib_file_path);
    
    AdbRunExecutable();
    
    AdbPullResult(config_file_path);

end

function AdbClear
    dos('DosBatchClearData.bat');
end

function AdbPushExecutables
    dos('DosBatchPushExecutable.bat')
end
    
function AdbPushSourceData(raw_file_path, config_file_path, calib_file_path)
    push_data_cmd = sprintf('DosBatchPushData.bat %s %s %s', raw_file_path, config_file_path, calib_file_path);
    dos(push_data_cmd);
end
    
function AdbRunExecutable
    dos('DosBatchRunExecutable.bat');
end
    
function AdbPullResult(config_file_path)
    dos('DosBatchPullData.bat');

    config = ParseConfigFile(config_file_path);

    CopyFile('.\Tmp\dpd_raw_result.txt', config.OutputResultInfoPath);
    CopyFile('.\Tmp\dpd_raw_grid.txt', config.OutputGridInfoPath);
    CopyFile('.\Tmp\dpd_raw_calib.txt', config.OutputCalibInfoPath);
    CopyFile('.\Tmp\dpd_raw_classify.txt', config.OutputClassifyInfoPath);
    %CopyFile('.\Tmp\dpd_raw_sad*.txt', config.OutputSADResultPath);
end

function CopyFile(src, dst)
    cmdline = sprintf('COPY %s %s', src, strrep(dst, '/', '\'));
    dos(cmdline);
end
