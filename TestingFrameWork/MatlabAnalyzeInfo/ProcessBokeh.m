function result = ProcessBokeh(folder_setting, dense_depth_map)
    img = im2double(FolderReadOriginalImage(folder_setting));
    img = imresize(img, 1080/size(img,1));
    
    preview_yuv_fname = 'preview_yuv.yuv';
    preview_yuv_path = [folder_setting.debug_folder preview_yuv_fname];
    YuvWrite(img, preview_yuv_path);
    
    preview_yuv_width = size(img, 1);
    preview_yuv_height = size(img,2);
    
    depth_map = imresize(imrotate(dense_depth_map.dense_depth_map, 270), [size(img,1) size(img,2)]);
    depth_map_width = size(depth_map, 1);
    depth_map_height = size(depth_map, 2);
    depth_map_path = '../../ProcessedResults/tmp/dense_depth_map.raw';
    
    RunBokehExecutable(
        preview_yuv_path, preview_yuv_width, preview_yuv_height, 
        depth_map_path, depth_map_width, depth_map_height);
    
    filtered_img = imfilter(img, fspecial('average', 32));
    
    mask_foreground = depth_map./max(max(depth_map));
    mask_foreground = mask_foreground .^ 2.0;
    mask_background = 1.0 - mask_foreground;
    
    clear_part = ApplyMask(img, mask_foreground);
    
    blurred_part = ApplyMask(filtered_img, mask_background);

    result = blurred_part + clear_part;

    figure,
    subplot(2,2,1), imshow(mask_foreground), title('Mask Foreground');
    subplot(2,2,2), imshow(mask_background), title('Mask Background');
    subplot(2,2,3), imshow(blurred_part), title('Blurred Part');
    subplot(2,2,4), imshow(clear_part), title('Clear Part');
    
    figure,
    imshow(result);
    
end

function part = ApplyMask(img, mask)
    part = img;
    
    part(:,:,1) = part(:,:,1) .* mask;
    part(:,:,2) = part(:,:,2) .* mask;
    part(:,:,3) = part(:,:,3) .* mask;    
end