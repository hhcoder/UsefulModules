function ret = FNameOutputDenseMapName(folder_setting)
    file_name = FNameInputRawWithoutExtension(folder_setting.src_raw_name, '.raw');
    dense_map_name = [file_name '_dense_dmap' '.raw'];
    ret = [folder_setting.dst_folder dense_map_name];
end
