function TestLiveness
    clear;
    %ret = ProcessImage('1610-jake-30cm');
    ret = ProcessImage('1610-hh-15cm');
    
    pd_result = ret.pd_pyramid{1}.value;
    
    figure,
    surf(ret.high_res_pd);
    
    face_rect_f = [0.5291 0.2569 0.3862 0.2599];
    %face_rect_f = [0 0 1 1];
    texture = ImageCrop(ret.original_image, face_rect_f);
    
    %pd_result_face = ImageCrop(pd_result, face_rect_f);
    pd_result_face = ImageCrop(ret.high_res_pd, face_rect_f);
    
    [x, y, z, t] = Render3DMap(texture, 1, pd_result_face);
    figure,
    surf(x,y,z,t);
    
end
