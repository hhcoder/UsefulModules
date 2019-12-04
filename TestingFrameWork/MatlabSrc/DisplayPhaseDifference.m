function DisplayPhaseDifference(lens_pos, phase_match_values, output_folder, fname)
    figure,
    plot(lens_pos, phase_match_values, 'ro--');
    title('Phase shift results at different lens locations');
    xlabel('Lens position');
    ylabel('Phase Shift');
    hold on
    l=line;
    l.XData=[lens_pos(1) lens_pos(end)];
    l.YData=[0 0];
    l.LineStyle='--';
    l.Color='blue';
    hold off
    hold on
    phase_to_lens_ratio = CalculatePhaseShiftToLensLocRatio(phase_match_values, lens_pos);
    legend(sprintf('Ratio=%f', phase_to_lens_ratio));
    hold off
    FigSave(output_folder, fname);
end

function ratio = CalculatePhaseShiftToLensLocRatio(x, y)
    X = [x ones(length(x),1)];
    Y = y;
    V = pinv(X)*Y;
    ratio = V(1);
end