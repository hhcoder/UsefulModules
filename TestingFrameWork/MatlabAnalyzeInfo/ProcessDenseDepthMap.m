function result = ProcessDenseDepthMap(folder_setting)

    img = FolderReadOriginalImage(folder_setting);
    
    GenerateYForGuidedFilter(folder_setting, img);
   
    dmap = FolderReadSparseDepthMap(folder_setting);
    
    GenerateDMapForGuidedFilter(folder_setting, dmap);
    
    y_path = GetYPath(folder_setting);
    dmap_path = GetDMapPath(folder_setting);
    dense_output_path = '../../ProcessedResults/tmp/dense_depth_map.raw';
    
    RunGuidedFilterExecutable(y_path, dmap_path, dense_output_path);
   
    d = RawDataRead(dense_output_path, 756, 1008);
    result.dense_depth_map = imrotate(d, 90);

    figure,
    subplot(2,1,1), imshow(dmap), title('sparse depth map');
    subplot(2,1,2), imshow(result.dense_depth_map), title('dense depth map result');
end

function dmap_path = GetDMapPath(folder_setting)
    dmap_fname = 'depth_map.raw';
    dmap_path = [folder_setting.debug_folder dmap_fname];
end

function y_path = GetYPath(folder_setting)
    y_fname = 'orig_y.raw';
    y_path = [folder_setting.debug_folder y_fname];
end

function GenerateDMapForGuidedFilter(folder_setting, dmap)
    dmap = imrotate(dmap, 270);
    dmap_path = GetDMapPath(folder_setting);
    YWrite(dmap, size(dmap), dmap_path);    
end

function GenerateYForGuidedFilter(folder_setting, img)
    target_size = [round(size(img,1)./4) round(size(img,2)./4)];
    y_path = GetYPath(folder_setting);

    YWrite(img, target_size, y_path);
end

function RunGuidedFilterExecutable(y_path, dmap_path, output_path)
      
    exe_setting = LoadExecutableSetting('windows');
    executable_name = 'DenseDepthMap.exe';
    guided_executable_path = [exe_setting.src_build_folder 'DenseDepthMap\Debug\' executable_name];
    copy_exe_str = ['COPY ' guided_executable_path ' ' exe_setting.dst_exe_folder];
    dos(copy_exe_str);
    
    exe_path = [exe_setting.dst_exe_folder executable_name];
    
    exe_str = [exe_path ' ' dmap_path ' ' y_path ' 756' ' 1008' ' ' output_path];
    
    dos(exe_str);
end

