function StructPrintToFile(src, dst_path)

    s = fieldnames(src);
    fid = fopen(dst_path, 'w');
    for i=1:length(s)
        fprintf(fid, '%s\n', s{i});

        % Hard to believe still have to use this kind of type
        %  indentifier in Matlab; there must be a better way
        if ischar(src.(s{i})) 
            fprintf(fid, '%s\n', src.(s{i}) );
        else
            fprintf(fid, '%d\n', src.(s{i}) ); 
        end

    end
    fclose(fid);
end

