function TestFullSweepFolder
    src_folder = '../../SourceImages/PD1710FullSweepDxo1000Lux/';
    dst_folder = '../../ProcessedResults/PD1710FullSweepDxo1000Lux/';
    
    src_raw_names = dir([src_folder '*.raw']);
      
    FileOpClearFolder(dst_folder);
    
    file_count = length(src_raw_names);
    full_sweep_pd = zeros(1, file_count);
    full_sweep_lens_pos = zeros(1, file_count);

    for i=1:file_count
        folder_setting.src_folder = src_folder;
        %setting.src_img_name = NaN;
        folder_setting.src_raw_name = src_raw_names(i).name;
        folder_setting.dst_folder = dst_folder;
        folder_setting.debug_folder = '../../ProcessedResults/tmp/';
        
        ret = ProcessImage(folder_setting);
        
        close('all');

        low_res_pd = ret.pd_pyramid{end}.value;
        center_y = floor((size(low_res_pd,1)+1)./2);
        center_x = floor((size(low_res_pd,2)+1)./2);
        full_sweep_pd(i) = low_res_pd(center_y, center_x);
        full_sweep_lens_pos(i) = RawFileNameGetLensPosition(src_raw_names(i).name);
    end
    
    h = figure();
    plot(full_sweep_lens_pos, full_sweep_pd);
    title('Full sweep analyze result');
    saveas(h, [folder_setting.dst_folder 'full_sweep_result.png']);
    
end