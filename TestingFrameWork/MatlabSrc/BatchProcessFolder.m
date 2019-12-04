function BatchProcessFolder
    clear;
    UtilCloseAll();

    %select = 'pen and newspaper';
    %select = 'lab';
    %select = 'sky';
    %select = 'sky_folder';
    %select = 'office';
    %select = 'ss-office-light';
    select = 'ivanka-low-light';
    
    process_type = 'windows';

    [raw_folder, calib_file_path, output_folder] = ...
        LoadDefaultFolderSettings(select);
    
    dim_config = LoadDefaultDimConfig();

    [dpd_results, grid_infos] = ProcessFolder(raw_folder, calib_file_path, dim_config, output_folder, process_type);
end