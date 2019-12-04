function [raw_image] = RawImageRead(raw_file_path, raw_width, raw_height)
    fname = raw_file_path;
    fid = fopen(fname, 'rb');
    A = fread(fid, 'uint16');
    raw_image = ConvertRawToImage(A, raw_width, raw_height);
    fclose(fid);
end

function ret = ConvertRawToImage(raw, width, height)
    left_image = reshape(raw, [width height]);
    ret = left_image';
end
