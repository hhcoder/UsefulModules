function ShowResultString(result) 
    hold on
    s = sprintf('%s = %g\n', 'phase_diff', result.phase_diff);
    
    t = annotation('textbox');
    t.FontSize = 8;
    t.String = s;
    t.Color = 'green';
    t.Interpreter = 'none';
    t.FontWeight = 'bold';
    t.EdgeColor = 'white';
    t.FitBoxToText = 'on';
    hold off
end