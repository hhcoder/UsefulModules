function ret = FNameOutputConfMapName(folder_setting)
    file_name = FNameInputRawWithoutExtension(folder_setting.src_raw_name, '.raw');
    conf_map_name = [file_name '_confmap' '.raw'];
    ret = [folder_setting.dst_folder conf_map_name];
end