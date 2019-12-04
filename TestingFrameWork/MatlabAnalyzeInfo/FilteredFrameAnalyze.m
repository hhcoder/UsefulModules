function [filtered_left, filtered_right] = FilteredFrameAnalyze(folder_setting, display_option)

    q_number_shift = 32768;

    l = Func_filtered_left();
    r = Func_filtered_right();
    
    filtered_left = l.value - q_number_shift;
    filtered_left = filtered_left ./ max(max(filtered_left));
    
    filtered_right = r.value - q_number_shift;
    filtered_right = filtered_right ./ max(max(filtered_right));
    
    imwrite(filtered_right, [folder_setting.dst_folder FNameRemoveExtension(folder_setting.src_raw_name) '_filtered_frame_right.jpg']);
    imwrite(filtered_left, [folder_setting.dst_folder FNameRemoveExtension(folder_setting.src_raw_name) '_filtered_frame_left.jpg']);
    
    if isfield(display_option, 'show_filtered_left') &&...
       strcmp(display_option.show_filtered_left, 'on')
        figure,
        subplot(1,2,1);
        imshow(filtered_left);
        title('Filtered left frame');
        subplot(1,2,2);
        imshow(filtered_right);
        title('Filtered right frame');
    end
    
    if isfield(display_option, 'show_filtered_right') && ...
       strcmp(display_option.show_filtered_right, 'on')   
        figure,
        subplot(1,2,1);
        surf(filtered_left);
        title('Filtered left frame');
        subplot(1,2,2);
        surf(filtered_right);
        title('Filtered right frame');
    end

end