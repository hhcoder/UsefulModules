function [calib_info] = ParseCalibInfoLog(calib_info_path)
    fid = fopen(calib_info_path);
    txt = textscan(fid,'%s %f','delimiter',' ');
    fclose(fid);
    
    %TODO: It's possible to write a common parser
    VersionNum = TxtFindValueByField(txt, 'VersionNum');
    OffsetX = TxtFindValueByField(txt, 'OffsetX');
    OffsetY = TxtFindValueByField(txt, 'OffsetY');
    RatioX = TxtFindValueByField(txt, 'RatioX');
    RatioY = TxtFindValueByField(txt, 'RatioY');
    MapWidth = TxtFindValueByField(txt, 'MapWidth');
    MapHeight = TxtFindValueByField(txt, 'MapHeight');
    VersionNum_DCC = TxtFindValueByField(txt, 'VersionNum_DCC');
    Q_factor_DCC = TxtFindValueByField(txt, 'Q_factor_DCC');
    MapWidth_DCC = TxtFindValueByField(txt, 'MapWidth_DCC');
    MapHeight_DCC = TxtFindValueByField(txt, 'MapHeight_DCC');

    [Left_GainMap, Left_GainMap_raw] = GetGainMap(txt, 'Left_GainMap_start', MapWidth, MapHeight);
    [Right_GainMap, Right_GainMap_raw] = GetGainMap(txt, 'Right_GainMap_start', MapWidth, MapHeight);
    
    calib_info = struct(...
        'VersionNum', VersionNum,...
        'OffsetX', OffsetX,...
        'OffsetY', OffsetY,...
        'RatioX', RatioX,...
        'RatioY', RatioY,...
        'MapWidth', MapWidth,...
        'MapHeight', MapHeight,...
        'VersionNum_DCC', VersionNum_DCC,...
        'Q_factor_DCC', Q_factor_DCC,...
        'MapWidth_DCC', MapWidth_DCC,...
        'MapHeight_DCC', MapHeight_DCC,...
        'Left_GainMap', Left_GainMap,...
        'Left_GainMap_raw', Left_GainMap_raw,...
        'Right_GainMap', Right_GainMap,...
        'Right_GainMap_raw', Right_GainMap_raw);
    
end

function array_values = TxtParseArray(txt, array_start_key)
    [array_length, start_idx] = TxtFindValueByField(txt, array_start_key);
    array_values = zeros(length(array_length), 1);
    for i=1:array_length
        array_values(i) = TxtFindValueByIdx(txt, start_idx+i);
    end
end
    
function [gain_map_normalized, gain_map_raw]= GetGainMap(txt, key, width, height)
    gain_map_array = TxtParseArray(txt, key);
    gain_map_raw = reshape(gain_map_array(1:width*height), [width height]);
    gain_map_normalized = gain_map_raw./max(max(gain_map_raw));
end