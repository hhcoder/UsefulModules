function ret = LoadDisplayOption()
    % original image
    ret.show_original_image = 'on';
    
    % high resolution pd
    ret.show_high_res_pd = 'on';
    ret.show_high_res_conf = 'on';
    
    % raw frame
    ret.show_left_raw = 'on';
    ret.show_left_surf = 'on';

    % integrated frame
    ret.integrated_frame_show_left_right = 'on';
    ret.integrated_frame_show_diff = 'on';
    
    % filtered frame
    ret.show_filtered_left = 'on';
    ret.show_filtered_right = 'on';
    
    % Pd pyramid
    ret.show_pd_pyramid = 'on';
    
    % Conf pyramid
    ret.show_conf_pyramid = 'on';
    
    % TODO: Think a better way to show SAD
    % Top Layer Sad 
    ret.show_top_layer_sad = 'off';
    
    % binary depth map
    ret.display_final_depth_map = 'on';

    % depth map on image
    ret.depth_map_on_image = 'on';
    
    % mask on image
    ret.display_mask_result = 'on';
    ret.mask_with_clustering = 'on';
end