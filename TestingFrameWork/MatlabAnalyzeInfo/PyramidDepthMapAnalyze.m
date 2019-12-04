function [pd_pyramid, conf_pyramid] = PyramidDepthMapAnalyze(folder_setting, display_option)

    pd_pyramid = Func_pd_pyramid_master();

    if isfield(display_option, 'show_pd_pyramid') && ...
       strcmp(display_option.show_pd_pyramid, 'on')

        h_pd_img = figure();

        n = ceil(length(pd_pyramid)/2);
        for i=1:length(pd_pyramid)
            subplot(2,n,i);
            v = pd_pyramid{i}.value./max(max(pd_pyramid{i}.value));
            imshow(imrotate(v, 90));
        end
        saveas(h_pd_img, [folder_setting.dst_folder FNameRemoveExtension(folder_setting.src_raw_name) '_pd_pyramid_image.png']);        
    end
    
    conf_pyramid= Func_conf_pyramid_master();

    if isfield(display_option, 'show_conf_pyramid') && ...
       strcmp(display_option.show_conf_pyramid, 'on')
        h_conf_img = figure();

        n = ceil(length(conf_pyramid)/2);
        for i=1:length(conf_pyramid)
            subplot(2,n,i);
            v = conf_pyramid{i}.value./max(max(conf_pyramid{i}.value));
            imshow(imrotate(v, 90));
        end
        saveas(h_conf_img, [folder_setting.dst_folder FNameRemoveExtension(folder_setting.src_raw_name) '_conf_pyramid_image.png']);   
    end

    if isfield(display_option, 'show_top_layer_sad') && ...
       strcmp(display_option.show_top_layer_sad, 'on')
  
        [h_sad_signal] = Func_sad_signal_master();
        saveas(h_sad_signal, [folder_setting.dst_folder FNameRemoveExtension(folder_setting.src_raw_name) '_sad_top_level.png']);
    end
end