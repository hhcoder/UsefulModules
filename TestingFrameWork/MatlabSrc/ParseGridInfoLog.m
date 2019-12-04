function grid_info = ParseGridInfoLog(common_grid_path)

    fid = fopen(common_grid_path);
    txt = textscan(fid, '%s %f', 'delimiter', ' ');
    fclose(fid);

    process_seq_indices = TxtCountFieldInstances(txt, 'process_seq');
    num_of_grids = length(process_seq_indices);
    grid_info = cell(num_of_grids, 1);
    
    for i=1:length(process_seq_indices)
        process_seq = TxtFindValueByField(txt, 'process_seq', process_seq_indices(i));
        grid_idx = TxtFindValueByField(txt, 'grid_idx', process_seq_indices(i));
        grid_start_x = TxtFindValueByField(txt, 'grid_start_x', process_seq_indices(i));
        grid_end_x = TxtFindValueByField(txt, 'grid_end_x', process_seq_indices(i));
        grid_start_y = TxtFindValueByField(txt, 'grid_start_y', process_seq_indices(i));
        grid_end_y = TxtFindValueByField(txt, 'grid_end_y', process_seq_indices(i));
        grid_phase_diff = TxtFindValueByField(txt, 'grid_phase_diff', process_seq_indices(i));
        grid_confidence = TxtFindValueByField(txt, 'grid_confidence', process_seq_indices(i));

        grid_info{i} = struct( ...
            'process_seq', process_seq,...
            'grid_idx', grid_idx,...
            'grid_start_x', grid_start_x,...
            'grid_end_x', grid_end_x,...
            'grid_start_y', grid_start_y,...
            'grid_end_y', grid_end_y,...
            'grid_phase_diff', grid_phase_diff,...
            'grid_confidence', grid_confidence);
    end

end