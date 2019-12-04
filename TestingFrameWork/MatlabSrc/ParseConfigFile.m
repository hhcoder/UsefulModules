function config = ParseConfigFile(config_file_path)
    fid = fopen(config_file_path);
    txt = textscan(fid,'%s %f','delimiter',' ');
    fclose(fid);
    
    config = struct; 
    for i=1:2:length(txt{1})
        field_str = GetString(txt{1}{i});
        config.(field_str) = GetValue(txt{1}{i+1});
    end
end

function ret = GetString(str)
    ret = str;
end


function ret = GetValue(value_str)
    value_num = str2double(value_str);
    if isnan(value_num) %is not a number
        ret = value_str;
    else
        ret = value_num;
    end
end