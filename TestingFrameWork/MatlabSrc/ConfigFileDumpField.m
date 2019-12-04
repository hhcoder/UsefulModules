function ConfigFileDumpField(fid, key, value)
    fprintf(fid, '%s\n', key);
    
    if ischar(value)
        fprintf(fid, '%s\n', value );
    else
        fprintf(fid, '%d\n', value ); 
    end
end
