function ret = FNameOutputBokehName(folder_setting)
    file_name = FNameInputRawWithoutExtension(folder_setting.src_raw_name, '.raw');
    dense_map_name = [file_name '_bokeh_result' '.yuv'];
    ret = [folder_setting.dst_folder dense_map_name];
end
