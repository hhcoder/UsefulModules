function [img_info, grid_info] = ParseDepthMapGridInfo(grid_info_path)

    fid = fopen(grid_info_path);
    txt = textscan(fid,'%s %f','delimiter',' ');
    fclose(fid);

    img_info.width = TxtFindValueByField(txt, 'win_width');
    img_info.height = TxtFindValueByField(txt, 'win_height');
    img_info.grid_skip_left = TxtFindValueByField(txt, 'grid_skip_left');
    img_info.grid_skip_right = TxtFindValueByField(txt, 'grid_skip_right');
    img_info.grid_skip_top = TxtFindValueByField(txt, 'grid_skip_top');
    img_info.grid_skip_bottom = TxtFindValueByField(txt, 'grid_skip_bottom');
    img_info.grid_count_hor = TxtFindValueByField(txt, 'grid_count_hor');
    img_info.grid_count_vert = TxtFindValueByField(txt, 'grid_count_vert');
    
    grid_info = ParseGridInfo(txt);
end

function grid_info = ParseGridInfo(txt)
    grid_idx = TxtCountFieldInstances(txt, 'grid_idx');
    num_grids = length(grid_idx);
    grid_info = zeros(num_grids, 4);
    for j=1:num_grids
        grid_info(j,1) = TxtFindValueByField(txt, 'grid_start_x', grid_idx(j));
        grid_info(j,2) = TxtFindValueByField(txt, 'grid_end_x', grid_idx(j));
        grid_info(j,3) = TxtFindValueByField(txt, 'grid_start_y', grid_idx(j));
        grid_info(j,4) = TxtFindValueByField(txt, 'grid_end_y', grid_idx(j));
    end
end
