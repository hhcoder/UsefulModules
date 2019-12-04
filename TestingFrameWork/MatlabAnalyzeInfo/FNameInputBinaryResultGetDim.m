function [width, height] = FNameInputBinaryResultGetDim(bin_name)
    rot = StrRotate(bin_name);
    idx_first_dot = strfind(rot, '.');
    idx_second_x = strfind(rot(idx_first_dot:end), 'x') + idx_first_dot - 1;
    idx_third__ = strfind(rot(idx_second_x:end), '_') + idx_second_x - 1;
    width = str2double(StrRotate(rot(idx_first_dot+1:idx_second_x-1)));
    height = str2double(StrRotate(rot(idx_second_x+1:idx_third__-1)));
end

function rot = StrRotate(str)
    rot = str(end:-1:1);
end