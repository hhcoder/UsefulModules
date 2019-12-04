function [raw_folder, calib_file_path, output_folder, display_ratio] = LoadDefaultFolderSettings(select)

    display_ratio = 1.5;

    switch lower(select)
        case 'mannequin face'
            raw_folder = '../../SourceImages/001_MannequinFace/';
            calib_file_path = '../../SourceImages/001_MannequinFace/pdaf_cali_dump.bin';
            output_folder = '../../ProcessedResults/001_MannequinFace/'; 
            
        case 'pen and newspaper'
            raw_folder = '../../SourceImages/002_PenAndNewspaper/';
            calib_file_path = '../../SourceImages/002_PenAndNewspaper/pdaf_cali_dump.bin';
            output_folder = '../../ProcessedResults/002_PenAndNewspaper/'; 
        case 'bottle and teabag'
            raw_folder = '../../SourceImages/003_BoxAndTeaBag/';
            calib_file_path = '../../SourceImages/003_BoxAndTeaBag/pdaf_cali_dump.bin';
            output_folder = '../../ProcessedResults/003_BoxAndTeaBag/';            
    end
        
 end