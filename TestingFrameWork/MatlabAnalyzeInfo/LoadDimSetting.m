function ret = LoadDimSetting()
    ret.raw_width = 4032;
    ret.raw_height = 756;
    ret.input_sensor_type = 1;
    ratio = 1080/3024;
    ret.yuv_width = floor(4032*ratio);
    ret.yuv_height = floor(3024*ratio);
end