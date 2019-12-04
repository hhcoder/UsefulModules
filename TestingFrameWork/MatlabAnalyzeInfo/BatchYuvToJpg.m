function BatchYuvToJpg

    folder = '../../ProcessedResults/PD1709FrontHzTestBed/';
    yuv_list = dir([folder '*yuv*1440*.raw']);
    
    for i=1:length(yuv_list)
        yuv_name = yuv_list(i).name;
        yuv_path = [folder yuv_name];
        jpg_name = [yuv_name(1:end-4) '.jpg'];
        jpg_path = [folder jpg_name];

        YToJpg(yuv_path, jpg_path);
    end

end

function YToJpg(yuv_path, jpg_path)
    yimg = YRead(yuv_path, 1440, 1080);
    yimg = imrotate(yimg, 180);
    imwrite(yimg, jpg_path);
end