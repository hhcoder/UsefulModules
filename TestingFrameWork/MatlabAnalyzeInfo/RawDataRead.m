function img = RawDataRead(fname, raw_width, raw_height)
    data_type = 'uint8';
    
    fid = fopen(fname, 'rb');
    A = fread(fid, raw_width*raw_height, data_type);
    img = reshape(A, [raw_width raw_height]);
    img = img./255;
    fclose(fid);
end
