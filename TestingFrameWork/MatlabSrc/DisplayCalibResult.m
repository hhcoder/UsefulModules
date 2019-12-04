function DisplayCalibResult(calib_info, out_folder, raw_fname)
    figure;
    subplot(1,2,1);
    DrawMap(calib_info.Left_GainMap, 'Left Gain Map');
    
    subplot(1,2,2);
    DrawMap(calib_info.Right_GainMap, 'Right Gain Map');
    
    gain_map_name = FileNameReplaceWith(raw_fname, '.raw', '_gain_map');
    FigSave(out_folder, gain_map_name);
end

function DrawMap(map, in_title)
    surf(map);
    axis([0 size(map, 1) 0 size(map, 2) 0 1 ]);
    title(in_title);
end