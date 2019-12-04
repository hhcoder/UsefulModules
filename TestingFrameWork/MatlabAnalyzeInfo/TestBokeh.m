function TestBokeh
    selection = '1709-001-palm-open';
    folder_setting = LoadFolderSetting(selection);
    
    sparse_depth_map = ProcessSparseDepthMap(folder_setting);
    dense_depth_map = ProcessDenseDepthMap(folder_setting);
    bokeh_image = ProcessBokeh(folder_setting, dense_depth_map);
end