function [pd_info, pd_image] = ParsePdFrameInfo(pd_info_path)
    fid = fopen(pd_info_path);
    txt = textscan(fid,'%s %f','delimiter',' ');
    fclose(fid);
    
    width = GetValue(txt, 1);
    height = GetValue(txt, 2);
    
    pd_info = zeros(height*width, 1);
    for i=1:width*height
        pd_info(i) = GetValue(txt, i+2);
    end
    pd_info = reshape(pd_info, [width height]);
    pd_image = (pd_info - min(min(pd_info)))./( max(max(pd_info)) - min(min(pd_info)));
end

function v = GetValue(txt, idx)
    value_str = txt{1}(idx);
    v = str2double(value_str);
end