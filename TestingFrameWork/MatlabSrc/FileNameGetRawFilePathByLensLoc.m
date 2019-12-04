function predicted_raw_file = FileNameGetRawFilePathByLensLoc(raw_files, dpd_result, initial_raw_idx)
    num_of_raws = length(raw_files);
    lens_pos = zeros(num_of_raws, 1);
    for i=1:num_of_raws
        lens_pos(i) = FileNameGetLensPositionFromRaw(raw_files(i).name);
    end
    
    phase_diff = dpd_result.ProcInfo.phase_diff;
    predicted_lens_shift = phase_diff * 52.00;
    initial_lens_idx = lens_pos(initial_raw_idx);
    
    lens_diff = abs(lens_pos-(initial_lens_idx+predicted_lens_shift));
    loc = find( lens_diff == min(lens_diff) );
    
    predicted_raw_file = raw_files(loc).name;
end
