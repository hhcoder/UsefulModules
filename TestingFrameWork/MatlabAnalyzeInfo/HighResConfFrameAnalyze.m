function high_conf = HighResConfFrameAnalyze(folder_setting, display_option)

    src_conf = Func_high_res_conf();
    high_conf = src_conf.value ./ max(max(src_conf.value));
    high_conf = imrotate(high_conf, 90);

    imwrite(high_conf, [folder_setting.dst_folder, FNameRemoveExtension(folder_setting.src_raw_name) '_high_res_conf.jpg']);

    if isfield(display_option, 'show_high_res_conf') && ...
       strcmp(display_option.show_high_res_conf, 'on')
   
       figure,
       imshow(high_conf);
       title(sprintf('High resolution Confidence: %d x %d', size(high_conf,2), size(high_conf,1)));
    end
end    
