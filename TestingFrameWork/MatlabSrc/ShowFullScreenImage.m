function ShowFullScreenImage(image, ratio)
    if nargin < 2
        ratio = 1.0;
    end
    figure,
    imshow(ratio*image);
    set(gcf, 'Position', get(0, 'Screensize'));
end