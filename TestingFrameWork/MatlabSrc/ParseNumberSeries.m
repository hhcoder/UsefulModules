function v = ParseNumberSeries(in_file_path)
    fid = fopen(in_file_path);
    txt = textscan(fid,'%s %f','delimiter',' ');
    fclose(fid);
    
    len = length(txt{1});
    v = zeros(1, len);
    
    for i=1:len
        v(i) = GetValue(txt{1}{i});
    end
end

function ret = GetValue(value_str)
    value_num = str2double(value_str);
    if isnan(value_num) %is not a number
        ret = value_str;
    else
        ret = value_num;
    end
end