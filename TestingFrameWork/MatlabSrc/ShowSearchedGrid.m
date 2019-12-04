function ShowSearchedGrid(sad_info)
    hold on
    for j=1:length(sad_info)
        pos = [sad_info{j}.grid_start_x,...
               sad_info{j}.grid_start_y, ...
               sad_info{j}.grid_end_x-sad_info{j}.grid_start_x+1,...
               sad_info{j}.grid_end_y-sad_info{j}.grid_start_y+1];
        rec = rectangle;
        rec.EdgeColor = 'yellow';
        rec.LineStyle = '--';
        rec.Position = pos;

         str = sprintf('I: %d | D: %.2f| C: %4d', j, sad_info{j}.phase_diff, sad_info{j}.confidence);
         t2 = text(sad_info{j}.grid_start_x+25, sad_info{j}.grid_start_y+30, str);
         t2.Color = 'yellow';
         t2.FontSize = 6;
    end
    hold off
end

