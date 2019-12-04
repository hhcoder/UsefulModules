function cfg_file_name = FNameOutputConfigFileName(folder_setting)
    file_name = FNameInputRawWithoutExtension(folder_setting.src_raw_name, '.raw');
    cfg_file_name = [file_name '.txt'];
end
