function s = TxtParseFileContentToStruct(txt)
    s = struct;

    t = txt{1};
    for i=1:2:length(t)
        field_name = t{i};
        field_value = t{i+1};
        s.(field_name) = field_value;
    end

end

    
