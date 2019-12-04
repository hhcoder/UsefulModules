function PdToDepth
    pd_range = 24;
    
    in_pd = 0:0.001:pd_range;
    out_depth = zeros(size(in_pd));
    
    min_pd = 8;
    max_pd = 14;
    roi_pd = 10;
    
    small_slope = 255 / (min_pd - roi_pd);
    large_slope = 255 / (max_pd - roi_pd);
    
    for i=1:length(in_pd)
        if in_pd(i) < min_pd
            out_depth(i) = 255;
            continue;
        end
        
        if in_pd(i) > max_pd
            out_depth(i) = 255;
            continue;
        end
        
        shift = in_pd(i) - roi_pd;
        if shift > 0
            out_depth(i) = large_slope * shift;
        else
            out_depth(i) = small_slope * shift;
        end
    end
    
    figure,
    plot(in_pd, out_depth);
end