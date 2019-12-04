function BatchProcGeneratePreviewYuv()
    folder = '../../SourceImages/PD1709FrontHzTestBed/';
    %folder = '../../SourceImages/PD1709/008_OutsideTwoFaces/';
    
    d = dir([folder '*.bmp']);
    
    for i=1:length(d)
        
        bmp_name = d(i).name;
        yuv_name = [bmp_name(1:end-3) 'yuv'];

        bmp = imread([folder bmp_name]);

        bmp_preview = imresize(bmp, 1080/size(bmp,1));
        %bmp_preview = imrotate(bmp_preview, 270);

        YuvWrite(bmp_preview, [folder yuv_name]);    
    end
end