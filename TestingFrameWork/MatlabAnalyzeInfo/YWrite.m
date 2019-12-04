function YWrite(img, target_size, dst_path)
    result = imresize(img, target_size);

    if length(size(result))==3
        result = rgb2ycbcr(result);
    end

    t = zeros(target_size, 'uint8');
    
    for j=1:target_size(2)
        for i=1:target_size(1)
            t(i, j) = round(result(i, j,1));
        end
    end
    
    file_id = fopen(dst_path, 'w');
    fwrite(file_id, t);
    fclose(file_id);    
end