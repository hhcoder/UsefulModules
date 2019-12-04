function y = YRead(y_path, width, height)
    data_type = 'uint8';
    
    fid = fopen(y_path, 'rb');
    A = fread(fid, width*height, data_type);
    y = reshape(A, [width height]);
    y = y./255;
    fclose(fid);
end