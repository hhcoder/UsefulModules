function BatchStaticScene
    clear;
    UtilCloseAll();

    select = 'ivanka2';
    
    process_type = 'windows';

    [raw_folder, calib_file_path, output_folder] = ...
        LoadDefaultFolderSettings(select);
    
    dim_config = LoadDefaultDimConfig();

    is_static_scene = 1;
    [dpd_results, grid_infos] = ProcessFolder(raw_folder, calib_file_path, dim_config, output_folder, process_type, 'display', is_static_scene);

    num_runs = length(grid_infos);
    grid_phase_diff = zeros(num_runs, 1);
    grid_conf = zeros(num_runs, 1);
    for i=1:num_runs
        grid_phase_diff(i) = grid_infos{i}{1}.grid_phase_diff;
        grid_conf(i) = grid_infos{i}{1}.grid_confidence;
    end
    
    figure,
    subplot(2,1,1), plot(grid_phase_diff), title(sprintf('Phase Diff Std=%f', std(grid_phase_diff)));
    subplot(2,1,2), plot(grid_conf), title(sprintf('Confidence Std=%f', std(grid_conf)));

end