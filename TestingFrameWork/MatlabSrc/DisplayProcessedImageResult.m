function DisplayProcessedImageResult(raw_file_name, dpd_result, grid_info, output_folder)

    %DisplayCalibResult(dpd_result.CalibInfo, output_folder, raw_file_name);

    %DisplaySADResult(sad_infos{i}, output_folder, raw_file_name);

    %DisplayClassifyResult(dpd_result, output_folder, raw_file_name);

    DisplayImageResult(...
            dpd_result.LeftImage, ...
            dpd_result.RightImage, ...
            grid_info, ...
            dpd_result.ProcInfo, ...
            output_folder, raw_file_name);

    UtilCloseAll();    
end
