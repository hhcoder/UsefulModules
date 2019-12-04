function dst = FileNameReplaceWith(src, sub_string, to_replace)
    config_prefix = src(1:strfind(src, sub_string)-1);
    dst = [config_prefix, to_replace];
end