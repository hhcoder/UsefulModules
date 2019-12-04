function ExecutableRun(executable_setting, folder_setting, config_file_path)

    executable_path = executable_setting.dos_executable;

    exe_str = [executable_path ' ' config_file_path];
    
    dos(exe_str);
end