function [slope] = CalculateSlopeValue(dpd_results, in_idx1, in_idx2)
    idx1 = min(in_idx1, in_idx2);
    idx2 = max(in_idx1, in_idx2);

    x1 = dpd_results{idx1}.lens_pos;
    x2 = dpd_results{idx2}.lens_pos;
    
    y1 = dpd_results{idx1}.ProcInfo.phase_diff;
    y2 = dpd_results{idx2}.ProcInfo.phase_diff;
    
    slope = (y2-y1) / (x2-x1);
    
    fprintf('Ratio phase to lens position = %f\n', 1./slope);
    fprintf('Ratio lens position to phase = %f\n', slope);
end