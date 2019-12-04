function LoadMatlabSetting(folder_setting)
    assert(isfield(folder_setting, 'debug_folder'), 'Debug folder must be specified');

    FileOpClearFolder(folder_setting.debug_folder);

    addpath(folder_setting.debug_folder);
end
