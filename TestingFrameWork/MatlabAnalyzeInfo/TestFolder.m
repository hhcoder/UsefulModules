function TestFolder(src_folder, dst_folder, max_search_range)
   
    src_raw_names = dir([src_folder '*.raw']);
    src_bmp_names = dir([src_folder '*.bmp']);
    src_yuv_names = dir([src_folder '*.yuv']);
    
    if length(src_raw_names)~=length(src_bmp_names)
        assert('Error! Number of BMP files does not match with RAW files!');
    end
    
    FileOpClearFolder(dst_folder);

    for i=1:length(src_raw_names)
        setting.src_folder = src_folder;
        setting.src_img_name = src_bmp_names(i).name;
        setting.src_raw_name = src_raw_names(i).name;
        setting.preview_yuv_name = src_yuv_names(i).name;
        setting.dst_folder = dst_folder;
        setting.max_search_range = max_search_range;
        setting.debug_folder = '../../ProcessedResults/tmp/';
        
        ProcessImage(setting);
        
        close('all');
    end
end