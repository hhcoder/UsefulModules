function [rect_f, c] = UiImageSelectRect(img)
    h = figure();
    [width, height] = size(img);
    imshow(img);
    [x_loc, y_loc] = ginput(2);
    rect = [x_loc(1) y_loc(1) x_loc(2)-x_loc(1) y_loc(2)-y_loc(1)];
    c = imcrop(img, rect);
    close(h);
    rect_f = rect ./ [height width height width];
end
