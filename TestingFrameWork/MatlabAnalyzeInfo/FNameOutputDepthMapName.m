function ret = FNameOutputDepthMapName(folder_setting)
    file_name = FNameInputRawWithoutExtension(folder_setting.src_raw_name, '.raw');
    depth_map_name = [file_name '_depthmap' '.raw'];
    ret = [folder_setting.dst_folder depth_map_name];
end