function config_file_path = CmdLineGetConfigFilePathFromRaw(output_folder, raw_file_name)
    config_file_path = [output_folder FileNameReplaceWith(raw_file_name, '.raw', '_config.txt')];
end

