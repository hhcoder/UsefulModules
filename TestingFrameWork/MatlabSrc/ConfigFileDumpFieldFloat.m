function ConfigFileDumpFieldFloat(fid, key, value)
    fprintf(fid, '%s\n', key);
    
    if ischar(value)
        fprintf(fid, '%s\n', value );
    else
        fprintf(fid, '%.2f\n', value ); 
    end
end
