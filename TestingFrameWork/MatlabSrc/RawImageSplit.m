function [left_image, right_image] = RawImageSplit(raw_file_path, raw_width, raw_height)
    fname = raw_file_path;
    fid = fopen(fname, 'rb');
    A = fread(fid, 'uint16');
    left_image = ConvertRawToImage(A(1:2:end), raw_width/2, raw_height);
    right_image = ConvertRawToImage(A(2:2:end), raw_width/2, raw_height);
    fclose(fid);
end

function ret = ConvertRawToImage(raw, width, height)
    left_image = reshape(raw, [width height]);
    ret = left_image'/1024;
end
