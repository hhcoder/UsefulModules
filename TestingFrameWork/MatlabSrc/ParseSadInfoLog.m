function [sad_info] = ParseSadInfoLog(common_grid_path, output_folder)

    loc = strfind(common_grid_path, '.txt');
    sad_info_keyword = common_grid_path(loc-3:loc-1);

    sad_info_files = dir([output_folder '*' sad_info_keyword '*.txt']); 

    num_files = length(sad_info_files);

    sad_info = cell(num_files,1);
    
    for i=1:num_files
       sad_info{i} = ParseSADInfoFromFile([output_folder sad_info_files(i).name]);
    end

end

function [sad_info] = ParseSADInfoFromFile(file_path)
    fid = fopen(file_path);
    txt = textscan(fid,'%s %f','delimiter',' ');
    fclose(fid);

    grid_start_x = TxtFindValueByField(txt, 'grid_start_x');
    grid_end_x = TxtFindValueByField(txt, 'grid_end_x');
    grid_start_y = TxtFindValueByField(txt, 'grid_start_y');
    grid_end_y = TxtFindValueByField(txt, 'grid_end_y');
    
    grid_SAD = TxtParseGridSAD(txt);
    
    sum_SAD = TxtParseSumSAD(txt);
    
    confidence = TxtFindValueByField(txt, 'confidence');
    phase_diff = TxtFindValueByField(txt, 'phase_diff');
    out_range_from = TxtFindValueByField(txt, 'out_range_from');
    out_range_to = TxtFindValueByField(txt, 'out_range_to');
    
    sad_info = struct( ...
        'grid_start_x', grid_start_x,...
        'grid_end_x', grid_end_x,...
        'grid_start_y', grid_start_y,...
        'grid_end_y', grid_end_y,...
        'grid_SAD', grid_SAD,...
        'sum_SAD', sum_SAD,...
        'confidence', confidence,...
        'phase_diff', phase_diff,...
        'out_range_from', out_range_from,...
        'out_range_to', out_range_to);
end

function grid_SAD = TxtParseGridSAD(txt)
    SAD_line_start = TxtCountFieldInstances(txt, 'SAD_line_start');
    SAD_line_count = TxtFindValueByField(txt, 'SAD_line_start');
    num_of_unit = length(SAD_line_start);      
    grid_SAD = zeros(num_of_unit, SAD_line_count);
    for j=1:num_of_unit
        for i=1:SAD_line_count
            idx = SAD_line_start(j)+i;
            grid_SAD(j, i) = TxtFindValueByIdx(txt, idx);
        end
    end    
end

function sum_SAD = TxtParseSumSAD(txt)    
    [SAD_sum_start, SAD_sum_start_idx] = TxtFindValueByField(txt, 'SAD_Sum_start');
    sum_SAD = zeros(length(SAD_sum_start), 1);
    for i=1:SAD_sum_start
        sum_SAD(i) = TxtFindValueByIdx(txt, SAD_sum_start_idx+i);
    end
end

% function min_loc = TxtParseMinThreeLoc(txt)
%     min_loc = zeros(3,1);
%     min_loc(1) = TxtFindValueByField(txt, 'LocalShift_0');
%     min_loc(2) = TxtFindValueByField(txt, 'LocalShift_1');
%     min_loc(3) = TxtFindValueByField(txt, 'LocalShift_2');
% end
% 
% function min_coef = TxtParseMinThreeCoef(txt)
%     min_coef = zeros(3,1);
%     min_coef(1) = TxtFindValueByField(txt, 'LocalCoeff_0');
%     min_coef(2) = TxtFindValueByField(txt, 'LocalCoeff_1');
%     min_coef(3) = TxtFindValueByField(txt, 'LocalCoeff_2');
% end    
% 
% 
% function linear_fine_shift = TxtParseFineShift(txt)
%     linear_fine_shift = TxtFindValueByField(txt, 'Linear_FineShift');
% end
