function [depth_map_8bit, conf_map_8bit] = BinaryDepthMapRead(folder_setting, display_option)
    depth_map_8bit = Func_final_depthmap();
    conf_map_8bit = Func_final_confmap();

    if isfield(display_option, 'display_final_depth_map') && ...
       strcmp(display_option.display_final_depth_map, 'on')
        figure,
        subplot(2,1,1);
        dmap = depth_map_8bit.value ./ 255;
        dmap = imrotate(dmap, 90);
        imshow(dmap);
        title('Final Depth Map');    
        subplot(2,1,2);
        cmap = conf_map_8bit.value ./ 255;
        cmap = imrotate(cmap, 90);
        imshow(cmap);
        title('Final Conf Map');
    end
    
    imwrite(dmap, [folder_setting.dst_folder FNameRemoveExtension(folder_setting.src_raw_name) '_final_depth_map.jpg']);
    imwrite(cmap, [folder_setting.dst_folder FNameRemoveExtension(folder_setting.src_raw_name) '_final_conf_map.jpg']);
end
