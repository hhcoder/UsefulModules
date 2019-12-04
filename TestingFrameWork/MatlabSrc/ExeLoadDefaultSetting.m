function setting = ExeLoadDefaultSetting(config_file)
    
    fid = fopen(config_file);
    txt = textscan(fid, '%s', 'delimiter', ' ');
    fclose(fid);
    
    setting = TxtParseFileContentToStruct(txt);
end
