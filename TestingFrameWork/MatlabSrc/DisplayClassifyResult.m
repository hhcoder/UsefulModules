function DisplayClassifyResult(dpd_result, output_folder, raw_file_name)

    classify_info = dpd_result.ClassifyInfo;
    x = classify_info.means;
    y = classify_info.counts;
    
    if NoDuplicatedItem(x)
        figure,
        bar(x,y);
        if nargin > 1
            fig_name = FileNameReplaceWith(raw_file_name, '.raw', '_classify');
            FigSave(output_folder, fig_name);
        end

        str='';
        for i=1:length(x)
            str = strcat(str, sprintf('%.2f, ', x(i)));
        end
        
        title(sprintf('Classified result: %s', str));
    end
    
end

function b = NoDuplicatedItem(x)
    for i=1:length(x)
        if sum(x(i)==x) > 1
            b = 0;
            return;
        end
    end
    b = 1;
    return;
end