function YuvWrite(rgb_img, yuv_path)
    ycbcr = rgb2ycbcr(im2double(rgb_img));
    ycbcr = ycbcr .* 255;

    y_plane = ycbcr(:,:,1);
    
    y_frame = Double2Uint8(y_plane);
    
    uv_width = size(rgb_img, 2);
    uv_height = size(rgb_img, 1) .* 0.5;
    
    u_plane = imresize(ycbcr(:,:,2), [uv_height uv_width]);
    v_plane = imresize(ycbcr(:,:,3), [uv_height uv_width]);        
    uv_plane = zeros(uv_height, uv_width);
    uv_plane(:,1:2:end) = u_plane(:,1:2:end);
    uv_plane(:,2:2:end) = v_plane(:,2:2:end);
   
    uv_frame = Double2Uint8(uv_plane);
       
    file_id = fopen(yuv_path, 'w');
    fwrite(file_id, y_frame');
    fwrite(file_id, uv_frame');
    fclose(file_id);    
   
end

function dst = Double2Uint8(src)
    dst = zeros(size(src), 'uint8');    

    for i=1:numel(src)
        dst(i) = Clamp2Uint8(src(i));
    end
end

function ret = Clamp2Uint8(v)
    x = 255;
    n = 0;
    if v>x
        ret = x;
    else
        if v<n
            ret = n;
        else
            ret = v;
        end
    end
end
