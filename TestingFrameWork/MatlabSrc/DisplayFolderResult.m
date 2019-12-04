function [phase_match_values, confidence_values, defocus_values, lens_pos] = DisplayFolderResult(dpd_results, output_folder)
    
    [phase_match_values, confidence_values, defocus_values, lens_pos] = ResultConvertToFigureFormat(dpd_results);

    DisplayPhaseDifference(lens_pos, phase_match_values, output_folder, 'folder_result_phase_match');
    
    DisplayConfidence(lens_pos, confidence_values, output_folder, 'folder_result_confidence_value');
    
    DisplayDefocusValue(lens_pos, defocus_values, output_folder, 'folder_result_defocus_value');

end

function [phase_match_values, confidence_values, defocus_values, lens_pos] = ResultConvertToFigureFormat(dpd_result)

    num_of_raws = length(dpd_result);

    phase_match_values = zeros(num_of_raws, 1);
    confidence_values = zeros(num_of_raws, 1);
    defocus_values = zeros(num_of_raws, 1);
    lens_pos = zeros(num_of_raws, 1);

    for i=1:num_of_raws
        phase_match_values(i) = dpd_result{i}.ProcInfo.phase_diff;
        confidence_values(i) = dpd_result{i}.ProcInfo.conf_level;
        defocus_values(i) = dpd_result{i}.ProcInfo.defocus_um;
        lens_pos(i) = dpd_result{i}.lens_pos;
    end

end

