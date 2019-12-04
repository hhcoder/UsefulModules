function [integ_left, integ_right] = IntegratedFrameAnalyze(folder_setting, display_option)
    l = Func_integ_left();
    r = Func_integ_right();

    integ_left = l.value ./max(max(l.value));
    integ_right = r.value ./max(max(r.value));
    
    if isfield(display_option, 'integrated_frame_show_left_right') && ...
        strcmp(display_option.integrated_frame_show_left_right, 'on')
        figure,
        subplot(1,2,1);
        imshow(integ_left);
        title('left integrated frame');
        subplot(1,2,2);
        imshow(integ_right);
        title('right integrated frame');
    end
    
    imwrite(integ_right, [folder_setting.dst_folder FNameRemoveExtension(folder_setting.src_raw_name) '_integraed_frame_right.jpg']);
    imwrite(integ_left, [folder_setting.dst_folder FNameRemoveExtension(folder_setting.src_raw_name) '_integraed_frame_left.jpg']);
    
    integ_diff = abs(integ_left-integ_right);
    integ_diff = integ_diff./max(max(integ_diff));

    imwrite(integ_diff, [folder_setting.dst_folder FNameRemoveExtension(folder_setting.src_raw_name) '_integrated_frame_diff.jpg']);

    if isfield(display_option, 'integrated_frame_show_diff') && ...
       strcmp(display_option.integrated_frame_show_diff, 'on')
        figure,
        imshow(integ_diff);
        title('Difference of integrated frames');
    end
    
end