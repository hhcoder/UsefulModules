function config_file_path = ConfigFileGenerate(folder_setting, dim_setting)

    cfg_file_name = FNameOutputConfigFileName(folder_setting);
    
    config_file_path = [folder_setting.dst_folder cfg_file_name];
    
    fid = fopen(config_file_path, 'w');

    ConfigFileDumpField(fid, 'Source2PdRawDataPath', [folder_setting.src_folder folder_setting.src_raw_name]);
    ConfigFileDumpField(fid, 'Source2pdRawWidth', sprintf('%d', dim_setting.raw_width));
    ConfigFileDumpField(fid, 'Source2pdRawHeight', sprintf('%d', dim_setting.raw_height));
    ConfigFileDumpField(fid, 'Source2pdRawFormat', '10BitUnpacked');
    ConfigFileDumpField(fid, 'ResultDepthMapPath', FNameOutputDepthMapName(folder_setting));
    ConfigFileDumpField(fid, 'ResultConfidenceMapPath', FNameOutputConfMapName(folder_setting));
    ConfigFileDumpField(fid, 'SourceYuvDataPath', [folder_setting.src_folder folder_setting.preview_yuv_name]);
    ConfigFileDumpField(fid, 'SourceYuvWidth', sprintf('%d', dim_setting.yuv_width));
    ConfigFileDumpField(fid, 'SourceYuvHeight', sprintf('%d', dim_setting.yuv_height));
    ConfigFileDumpField(fid, 'ResultDenseMapPath', FNameOutputDenseMapName(folder_setting));
    ConfigFileDumpField(fid, 'ResultBokehPath', FNameOutputBokehName(folder_setting));
    ConfigFileDumpField(fid, 'SourceMaxDisparityValue', folder_setting.max_search_range);
    
    % For auto focus lens only
    if isfield(folder_setting, 'lens_macro_loc')
        ConfigFileDumpField(fid, 'SourceLensMacroLoc', folder_setting.lens_macro_loc);
    end
    if isfield(folder_setting, 'lens_infinity_loc')
        ConfigFileDumpField(fid, 'SourceLensInfinityLoc', folder_setting.lens_infinity_loc);
    end
    if isfield(folder_setting, 'lens_current_loc')
        ConfigFileDumpField(fid, 'SourceLensCurrentLoc', folder_setting.lens_current_loc);
    end
    
    fclose(fid);
end

function ConfigFileDumpField(fid, key, value)
    fprintf(fid, '%s\n', key);    
    fprintf(fid, '%s\n', value );
end
