function ShowDepthMapGridInfo(img, grid_info)
    figure, 
    imshow(img);
    DrawGrid(grid_info);
end

function DrawGrid(grid_info)
    hold on
    len = size(grid_info, 1);
    for i=1:len
        if mod(i, 1)==0
            pos = [grid_info(i,1) grid_info(i,3) grid_info(i,2)-grid_info(i,1) grid_info(i,4)-grid_info(i,3)];
            rec = rectangle;
            rec.EdgeColor = ChooseColor(i);
            rec.LineStyle = '--';
            rec.Position = pos;
        end
    end
    hold off
end

function [c] = ChooseColor(i)
    switch mod(i,5)
        case 0
            c = 'green';
        case 1
            c = 'yellow';
        case 2
            c = 'magenta';
        case 3
            c = 'black';
        case 4
            c = 'blue';
    end
end