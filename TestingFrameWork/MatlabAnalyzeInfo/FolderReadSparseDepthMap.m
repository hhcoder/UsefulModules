function dmap = FolderReadSparseDepthMap(folder_setting)    
    dmap = imread([folder_setting.dst_folder FNameRemoveExtension(folder_setting.src_raw_name) '_final_depth_map.jpg']);
end

    