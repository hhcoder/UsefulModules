function ret = FNameRemoveExtension(src_file_name)
    ext_idx = strfind(src_file_name, '.');
    ret = src_file_name(1:ext_idx(end)-1);
end