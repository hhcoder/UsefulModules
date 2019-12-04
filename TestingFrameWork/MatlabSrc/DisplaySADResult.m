function DisplaySADResult(sad_info, output_folder, raw_fname)
    for j=1:length(sad_info)
        grid_fname_base = FileNameReplaceWith(raw_fname, '.raw', '_sad');
        out_name = sprintf('%s%.2d', grid_fname_base, j);
        
        DisplayGridSad(...
            sad_info{j}.grid_SAD,...
            sad_info{j}.sum_SAD,...
            out_name,...
            output_folder);

%        min_fname_base = FileNameReplaceWith(raw_fname, '.raw', 'min_loc');
%         DisplayInterpLoc(...
%             dbg_info{j},...
%             sprintf('%s%.2d', min_fname_base, j),...
%             output_folder);
    end
end

function DisplayGridSad(sad_info, sad_sum, fig_name, output_folder)
    figure('Name', fig_name);
    subplot(1,2,1);
    surf(sad_info);
    subplot(1,2,2);
    plot(sad_sum);
    FigSave(output_folder, fig_name);
end

% function DisplayInterpLoc(info, fig_name, output_folder)
%     figure('Name', fig_name);
%     
%     % Plot the 3 locations
%     plot(info.min_loc, info.min_coef, 'o');
% 
%     % Plot the DPD Lib predicted result
%     hold on
%     final_xloc = info.min_loc(2)+info.linear_fine_shift;
%     line([final_xloc final_xloc], [min(info.min_coef) max(info.min_coef)], 'Color', 'k');
%     hold off
% 
%     % Plot the Spline interpolation result
%     hold on
%     xin = info.min_loc(1):0.1:info.min_loc(3);
%     yout = interp1(info.min_loc, info.min_coef, xin, 'spline');
%     plot(xin, yout, '--');
%     hold off
% 
%     legend('SAD Coef', 'Lib result', 'Spline Interp');
% 
%     FigSave(output_folder, fig_name);
% end