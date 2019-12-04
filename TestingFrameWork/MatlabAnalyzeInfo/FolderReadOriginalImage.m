function img = FolderReadOriginalImage(folder_setting)
    src_img_path = [folder_setting.src_folder folder_setting.src_img_name];
    img = imread(src_img_path);
end