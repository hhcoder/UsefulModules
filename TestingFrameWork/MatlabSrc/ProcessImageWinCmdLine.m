function ProcessImageWinCmdLine(config_file_path)

    executable_path = '..\..\Development\build\vs\CmdLine\Debug\DualPdCmdLineTest.exe';
    lib_path = '..\..\Development\build\vs\CoreLib\Debug\DualPDDepthMapCoreLib.lib';
    
    copy_exe_line = sprintf('cp %s ..\..\ProcessResults\', executable_path);
    copy_lib_line = sprintf('cp %s ..\..\ProcessResults\', lib_path);
    
    dos(copy_exe_line);
    
    dos(copy_lib_line);

    cmd_line = sprintf('%s %s', ...
        executable_path,...
        config_file_path);

    fprintf('\n --- START PROCESSING ---\n');

    dos(cmd_line);
    
    fprintf('\n--- END PROCESSING ---\n');
end