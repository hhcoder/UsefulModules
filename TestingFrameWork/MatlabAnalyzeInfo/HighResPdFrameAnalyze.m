function high_pd = HighResPdFrameAnalyze(folder_setting, display_option)

    src_pd = Func_high_res_pd();
    high_pd = src_pd.value ./ max(max(src_pd.value));
    high_pd = imrotate(high_pd, 90);
    
    imwrite(high_pd, [folder_setting.dst_folder FNameRemoveExtension(folder_setting.src_raw_name) '_high_res_pd.jpg']);

    if isfield(display_option, 'show_high_res_pd') && ...
       strcmp(display_option.show_high_res_pd, 'on')
   
       figure,
       imshow(high_pd);
       title(sprintf('High resolution PD: %d x %d', size(high_pd,2), size(high_pd,1)));
    end
end