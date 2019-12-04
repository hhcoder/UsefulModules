function [original_y, sparse_depth, dense_depth] = GuidedFilterAnalyze(folder_setting, display_option)
    original_y = Func_dense_orig_y();
    figure,

    subplot(3,1,1);
    imshow(original_y.value./max(max(original_y.value)));
    
    sparse_depth = Func_sparse_scaled();
    subplot(3,1,2);
    imshow(sparse_depth.value./max(max(sparse_depth.value)));
    
    dense_depth = Func_guided_result();
    subplot(3,1,3);
    imshow(dense_depth.value./max(max(dense_depth.value)));
end