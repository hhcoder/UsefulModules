function [field_value, idx] = TxtFindValueByField(txt, field_name, start_idx)
    field_value = 'NaN';
    if nargin > 2
        st = start_idx;
    else
        st = 1;
    end
    
    for i=st:length(txt{1})
        if( strcmp(field_name,txt{1}(i)) )
            field_value = txt{2}(i);
            idx = i;
            break;
        end
    end
end