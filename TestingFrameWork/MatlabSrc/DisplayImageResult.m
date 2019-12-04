function DisplayImageResult(left_image, right_image, grid_info, result_info, output_folder, raw_fname)
    
    figure('Name', 'DualPD Processed Result');
    
    ShowImage(left_image, right_image);
    ShowProcessedGrid(grid_info);   
%    ShowResultString(result_info);
    ShowFocusedGrid(result_info);

    img_fname = FileNameReplaceWith(raw_fname, '.raw', '_img_result');
    FigSave(output_folder, img_fname);
end

 function ShowImage(left_image, right_image)
    img_disp = (left_image./2 + right_image./2);
    imshow(img_disp);
 end
 

