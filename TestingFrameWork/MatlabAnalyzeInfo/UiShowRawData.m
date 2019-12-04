function UiShowRawData
    [file_name, path_name] = uigetfile('*.raw', 'Select the 2PD raw data');
    raw_width = 4032;
    raw_height = 756;
    [l, r] = RawDataSplit([path_name file_name], raw_width, raw_height);
    subplot(1,2,1);
    l = ImSizeTo(l);
    imshow(l);
    subplot(1,2,2);
    r = ImSizeTo(r);
    imshow(r);
    SaveToJpeg(l, '_left', path_name, file_name);
    SaveToJpeg(r, '_right', path_name, file_name);
end

function l = ImSizeTo(l)
    height = size(l,1);
    l = imrotate(l, 270);
    l = imresize(l, [round(height.*4./3) height]);
end

function SaveToJpeg(l, tag, path_name, file_name)
    j_file_name = [file_name(1:end-4) tag '.jpg'];
    imwrite(l, [path_name j_file_name]);
end