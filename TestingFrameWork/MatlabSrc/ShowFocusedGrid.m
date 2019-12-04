function ShowFocusedGrid(result)
    hold on
    pos = [result.start_x, result.start_y, result.end_x-result.start_x, result.end_y-result.start_y];
    rec = rectangle;
    rec.EdgeColor = 'red';
    rec.Position = pos;
    rec.Curvature = 0.2;
    rec.LineWidth = 3;
%    t = text(pos(1)+20, pos(2)+40, sprintf('%.2f', result.phase_diff));
%    t.Color = 'white';
%    t.FontSize = 8;
    hold off
end
   