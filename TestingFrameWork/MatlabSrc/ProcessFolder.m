function [dpd_results, grid_infos] = ProcessFolder(...
    raw_folder, ...
    calib_file_path, ...
    dim_config, ...
    output_folder, ...
    process_type, ...
    display_option,...
    is_static_scene)

    if nargin < 6
        display_option = 'display';
    end
    
    dir_raw_files = dir([raw_folder '*.raw']);
    
    num_of_raws = length(dir_raw_files);
    
    if num_of_raws < 1
        disp('Error in the raw folder, no .raw files!');
        return
    end

    %debug purpose
    %if num_of_raws > 50
    %    num_of_raws = 50;
    %end

    FileOperationClearFolder(output_folder);

    raw_file_names = cell(num_of_raws, 1);
    for i=1:num_of_raws
        raw_file_names{i} = dir_raw_files(i).name;
    end

    dpd_results = cell(num_of_raws, 1);
    grid_infos = cell(num_of_raws, 1);
    sad_infos = cell(num_of_raws, 1);

    for i=1:num_of_raws
        raw_file_name = raw_file_names{i};
        [dpd_result, grid_info, sad_info] = ...
            ProcessImage(...
                raw_folder, ...
                raw_file_name, ...
                calib_file_path, ...
                dim_config, ...
                output_folder, ...
                process_type,...
                display_option);
        dpd_results{i} = dpd_result;
        grid_infos{i} = grid_info;
        sad_infos{i} = sad_info;
    end

    if num_of_raws > 5 && ~is_static_scene
        DisplayFolderResult(dpd_results, output_folder);
        
        CalculateSlopeValue(dpd_results, 16, 20);
    end
    
    save([output_folder 'process_result']);
end
