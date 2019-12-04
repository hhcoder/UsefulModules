function pd_pyramid = ParsePdPyramid(src_folder, common_pd_fname, num_of_layers, dst_folder, mode)
    pd_pyramid = cell(num_of_layers, 1);
    for i=0:num_of_layers-1
        pd_info_path = sprintf('%s_%s.txt', src_folder, common_pd_fname);
        [pd_info, pd_image] = ParsePdFrameInfo(pd_info_path);
        pd_pyramid{i+1}.pd_info = pd_info;
        pd_pyramid{i+1}.pd_image = pd_image;
    
        if strcmp(mode, 'display')
            figure,
            hold on
            imshow(pd_pyramid{i+1}.pd_image);
            title('layer: %d, %dx%d', i, size(pd_image,1), size(pd_image,2));
            pd_out_path = sprintf('%s%s_%d.jpg', dst_folder, common_pd_fname, i);
            saveas(gcf, pd_out_path, 'jpg');
            hold off
        end
    end
end