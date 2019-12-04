function [raw_left, raw_right] = RawFrameAnalyze(folder_setting, dim_setting, display_option)
    raw_file_path = [folder_setting.src_folder folder_setting.src_raw_name];
    raw_width = dim_setting.raw_width;
    raw_height = dim_setting.raw_height;

    fname = raw_file_path;
    fid = fopen(fname, 'rb');
    A = fread(fid, raw_width*raw_height, 'uint16');
    
    raw_left = ConvertRawToImage(A(1:2:end), raw_width/2, raw_height);
    raw_right = ConvertRawToImage(A(2:2:end), raw_width/2, raw_height);

    fclose(fid);
       
    imwrite(raw_left, [folder_setting.dst_folder FNameRemoveExtension(folder_setting.src_raw_name) '_raw_left.jpg']);
    imwrite(raw_right, [folder_setting.dst_folder FNameRemoveExtension(folder_setting.src_raw_name) '_raw_right.jpg']);

    if isfield(display_option, 'show_left_raw') && ... 
       strcmp(display_option.show_left_raw, 'on')
        figure();
        imshow(raw_left);
        title('Left Raw Image');
    end
    
    if isfield(display_option, 'show_left_surf') && ...
       strcmp(display_option.show_left_surf, 'on')
        h = figure();
        ratio = 20;
        l = raw_left(1:ratio:end, 1:ratio:end);
        surf(l);
        saveas(h, [folder_setting.dst_folder FNameRemoveExtension(folder_setting.src_raw_name) '_raw_left_surf.fig']);
    end
end

function ret = ConvertRawToImage(raw, width, height)
    left_image = reshape(raw, [width height]);
    ret = left_image'/1024;
end
