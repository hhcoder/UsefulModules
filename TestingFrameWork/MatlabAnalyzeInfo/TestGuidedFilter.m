function TestGuidedFilter(folder_setting)

if nargin < 1
    selection = '1709-001-palm-open';
end

%{
     result = ProcessImage('1710-001-the-guy');

     src_img = rgb2gray(result.original_image);
     
     dmap = result.final_dmap > 0.39;
     %src_img = imresize(src_img, size(dmap));
     
     dmap_guided = GuidedFilter(dmap, src_img);
     
     figure;
     subplot(2,1,1);
     imshow(dmap);
     subplot(2,1,2);
     imshow(dmap_guided);
%}

    folder_setting = LoadFolderSetting(selection);
    %result = ProcessImage(folder_setting);
    
    src_img_path = [folder_setting.src_folder folder_setting.src_img_name];

    y_fname = 'orig_y.raw';
    y_path = [folder_setting.debug_folder y_fname];

    img = imread(src_img_path);
    
    target_size = [round(size(img,1)./4) round(size(img,2)./4)];

    WriteYImage(img, target_size, y_path);
      
    dmap = imread([folder_setting.dst_folder FNameRemoveExtension(folder_setting.src_raw_name) '_final_depth_map.jpg']);
    dmap = imrotate(dmap, 270);
    dmap_fname = 'depth_map.raw';
    dmap_path = [folder_setting.debug_folder dmap_fname];
    WriteYImage(dmap, size(dmap), dmap_path);
    
    exe_setting = LoadExecutableSetting('windows');
    executable_name = 'DenseDepthMap.exe';
    guided_executable_path = [exe_setting.src_build_folder 'DenseDepthMap\Debug\' executable_name];
    copy_exe_str = ['COPY ' guided_executable_path ' ' exe_setting.dst_exe_folder];
    dos(copy_exe_str);
    
    exe_path = [exe_setting.dst_exe_folder executable_name];
    
    dense_path = '../../ProcessedResults/tmp/dense_depth_map.raw';
    exe_str = [exe_path ' ' dmap_path ' ' y_path ' 756' ' 1008' ' ' dense_path];
    
    dos(exe_str);
    
    result = RawDataRead(dense_path, 756, 1008);
    figure,
    subplot(2,1,1), imshow(dmap), title('sparse depth map');
    subplot(2,1,2), imshow(result), title('dense depth map result');

end

function WriteYImage(img, target_size, dst_path)
    result = imresize(img, target_size);

    if length(size(result))==3
        result = rgb2ycbcr(result);
    end

    t = zeros(target_size, 'uint8');
    
    for j=1:target_size(2)
        for i=1:target_size(1)
            t(i, j) = round(result(i, j,1));
        end
    end
    
    file_id = fopen(dst_path, 'w');
    fwrite(file_id, t);
    fclose(file_id);    
end