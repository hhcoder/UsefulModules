function [merged_y, blurry_y] = BokehAnalyze(folder_setting, display_option)
    blurry_y = Func_blurry_y();
    figure,
    imshow(blurry_y.value./(max(max(blurry_y.value))))
    
    merged_y = Func_merged_y();
    figure,
    imshow(merged_y.value ./ max(max(merged_y.value))); 
end