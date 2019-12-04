function lens_pos = RawFileNameGetLensPosition(raw_file_name)
    a = strfind(raw_file_name, 'pos_');
    b = strfind(raw_file_name, '.');
    pos_str = raw_file_name(a+4:b-1);
    lens_pos = str2double(pos_str);
end