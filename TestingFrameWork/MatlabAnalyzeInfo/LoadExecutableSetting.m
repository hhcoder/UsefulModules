function ret = LoadExecutableSetting(flavor, config)
    switch flavor
        case 'windows'
            ret = LoadWindowsExecutable(config);
        otherwise
            assert('Error selecting executable flavor');
    end
end

function ret = LoadWindowsExecutable(config)
    ret.executable_name = 'DualPdSystemCmdLine.exe';

    ret.src_build_folder = '..\..\Development\build\vs\';
    ret.src_executable = [ret.src_build_folder 'DualPdSystemCmdLine\' config '\' ret.executable_name];
    
    ret.dst_exe_folder = '..\..\ProcessedResults\exe\';
            
    copy_exe_str = ['COPY ' ret.src_executable ' ' ret.dst_exe_folder];
    
    dos(copy_exe_str);

    ret.dos_executable = [ret.dst_exe_folder ret.executable_name];
end