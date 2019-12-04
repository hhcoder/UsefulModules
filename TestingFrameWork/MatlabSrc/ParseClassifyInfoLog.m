function result = ParseClassifyInfoLog(dst_log_path)
    fid = fopen(dst_log_path);
    txt = textscan(fid,'%s %f','delimiter',' ');
    fclose(fid);
    
    
    mean_values_indices = TxtCountFieldInstances(txt, 'MeanValue');
    num_of_unit = length(mean_values_indices);
    means = zeros(num_of_unit, 1);
    for i=1:num_of_unit
        means(i) = TxtFindValueByIdx(txt, mean_values_indices(i));
    end
        
    count_indices = TxtCountFieldInstances(txt, 'Count');
    num_of_unit = length(count_indices);
    counts = zeros(num_of_unit, 1);
    for i=1:num_of_unit
        counts(i) = TxtFindValueByIdx(txt, count_indices(i));
    end

    sum_indices = TxtCountFieldInstances(txt, 'Sum');
    num_of_unit = length(sum_indices);
    sums = zeros(num_of_unit, 1);
    for i=1:num_of_unit
        sums(i) = TxtFindValueByIdx(txt, sum_indices(i));
    end
    
    result = struct('means', means,...
                    'counts', counts, ...
                    'sums', sums);
end