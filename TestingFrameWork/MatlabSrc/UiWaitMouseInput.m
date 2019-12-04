function [x_loc, y_loc] = UiWaitMouseInput(image)
    [x_mouse_loc, y_mouse_loc] = ginput(1);
    ShowClickedRegion(x_mouse_loc(1), y_mouse_loc(1));
    x_loc = x_mouse_loc(1) ./ size(image, 2);
    y_loc = y_mouse_loc(1) ./size(image, 1);
end

function ShowClickedRegion(x, y)
    hold on
    pos = [x-50, y-50, 100, 100];
    rec = rectangle;
    rec.EdgeColor = 'green';
    rec.Position = pos;
    rec.LineWidth=1;
    hold off
end