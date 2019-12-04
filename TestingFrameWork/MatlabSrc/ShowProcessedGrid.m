function ShowProcessedGrid(grid_info)
    hold on
    for j=1:length(grid_info)
        pos = [grid_info{j}.grid_start_x,...
               grid_info{j}.grid_start_y, ...
               grid_info{j}.grid_end_x-grid_info{j}.grid_start_x+1,...
               grid_info{j}.grid_end_y-grid_info{j}.grid_start_y+1];
        rec = rectangle;
        rec.EdgeColor = 'blue';
        rec.LineStyle = '--';
        rec.Position = pos;
        
        t1 = text;
        t1.Position = [grid_info{j}.grid_start_x+5, ...
                      grid_info{j}.grid_start_y+5];
        t1.String = sprintf('Grid idx: %d', grid_info{j}.process_seq);
        t1.Color = 'blue';
        t1.FontSize = 6;

        str = sprintf('%.2f| %d', grid_info{j}.grid_phase_diff, grid_info{j}.grid_confidence);
        t2 = text(grid_info{j}.grid_start_x+5, grid_info{j}.grid_start_y+15, str);
        t2.Color = 'blue';
        t2.FontSize = 6;
    end    
    hold off
end