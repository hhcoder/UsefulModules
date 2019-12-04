function ret = ImageCrop(image, rect_f)
    [height, width] = size(image);
    rect = round(rect_f .* [height width height width]);
    ret = imcrop(image, rect);
end