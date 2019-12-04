function ret = FNameInputRawWithoutExtension(src_raw_name, raw_extension)
    ext_idx = strfind(src_raw_name, raw_extension);
    ret = src_raw_name(1:ext_idx-1);
end