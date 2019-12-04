function [X, Y, Z, texture] = Render3DMap(src_image, sampling_rate, depth_map)

        im_width = floor(size(src_image, 2)./sampling_rate);
        im_height = floor(size(src_image, 1)./sampling_rate);

        [X, Y] = meshgrid(1:im_width, 1:im_height);
        Z = imresize(depth_map, [im_height im_width]);
        texture = imresize(src_image, [im_height im_width]);
end