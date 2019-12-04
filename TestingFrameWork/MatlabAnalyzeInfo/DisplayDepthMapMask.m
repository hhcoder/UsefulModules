function DisplayDepthMapMask(folder_setting, dmap, display_option)

    if nargin < 3
        display_option.mask_with_clustering = 'on';
        display_option.overlay_image = 'on';
    end
    
    if isfield(display_option, 'display_mask_result') && ...
       strcmp(display_option.display_mask_result, 'on')
   
        src_image = imread([folder_setting.src_folder folder_setting.src_img_name]);
        src_image = imrotate(src_image, 90);
        src_image = im2double(src_image);

        processed_mask = KMeanClustering(dmap, display_option);
        processed_result = OverlayImage(src_image, processed_mask);

        h = figure();

        standard_mask = imread([folder_setting.src_folder folder_setting.src_mask_name]);
        standard_mask = imrotate(imresize(standard_mask, size(dmap)),90);
        standard_mask = im2double(standard_mask);

        standard_result = OverlayImage(src_image, standard_mask);

        subplot(2,2,1);
        imshow(processed_mask);
        title('Processed Mask');
        subplot(2,2,2);
        imshow(processed_result);
        title('Processed Result');

        subplot(2,2,3);
        imshow(standard_mask);
        title('Standard Mask');
        subplot(2,2,4);
        imshow(standard_result);
        title('Standard Result');
        saveas(h, [folder_setting.dst_folder FNameRemoveExtension(folder_setting.src_raw_name) '_result_mask.png']);	
    end
end

function overlay_image = OverlayImage(src_image, mask)
    overlay_image = imresize(src_image, [size(mask, 1) size(mask,2)]);
    overlay_image = overlay_image .* mask;
end

function mask_image = KMeanClustering(dmap, display_option)
    k = 4;
    d = reshape(dmap, [numel(dmap) 1]);
    l = kmeans(d, k);
    labels = reshape(l, size(dmap));
    
    masks = zeros([size(dmap) k]);
	
    for i=1:k
        masks(:,:,i) = (labels==i);
    end

    if isfield(display_option, 'mask_with_clustering') && ...
        strcmp(display_option.mask_with_clustering, 'on')
		h = figure();
		for i=1:k
			subplot(2,ceil(k/2),i);
			imshow(masks(:,:,i));
			title(sprintf('Label: %d', i));
        end
        m = mean(mean(masks));
        max_idx = find(m==max(m));
        m = masks(:,:,max_idx);
        mask_image = Gray2Rgb(m);
    end 

end

function rgb = Gray2Rgb(g)
    rgb = zeros([size(g) 3]);
    for i=1:3
        rgb(:,:,i) = g;
    end
end