function img = OriginalImageAnalyze(folder_setting, display_option)

if isfield(folder_setting, 'src_img_name')
    image_path = [folder_setting.src_folder folder_setting.src_img_name];
    
    img = im2double(imread(image_path));
    img = imrotate(img, 90);
      
    if isfield(display_option, 'show_original_image') && strcmp(display_option.show_original_image, 'on')
        figure,
        imshow(img);
        title('Original Image');
    end
    
    imwrite(img, [folder_setting.dst_folder FNameRemoveExtension(folder_setting.src_raw_name) '_original_image.jpg']);
else
    img = NaN;
end

end