function [X, Y, Z, texture] = ResultDepthImageAnalyze(folder_setting, depth_map, conf_map, display_option)

    if isfield(display_option, 'depth_map_on_image') &&...
       strcmp(display_option.depth_map_on_image, 'on') &&...
        isfield(folder_setting, 'src_img_name') ...
   
        image_path = [folder_setting.src_folder folder_setting.src_img_name];
        src_image = imread(image_path);
        src_image = imrotate(src_image, 90);
        
        sampling_rate = 20;

        [X, Y, Z, texture] = Render3DMap(src_image, sampling_rate, depth_map);

        h = figure();
        surf(X, Y, Z, texture); 
        title('Depth Map On Image');
        saveas(h, [folder_setting.dst_folder FNameRemoveExtension(folder_setting.src_raw_name) '_depth_map_image.fig']);
    else
        X=NaN;
        Y=NaN;
        Z=NaN;
        texture=NaN;
    end
end