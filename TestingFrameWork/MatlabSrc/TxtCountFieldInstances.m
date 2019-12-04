function [indices] = TxtCountFieldInstances(txt, field_name, start_idx)
    if nargin > 2
        st = start_idx;
    else
        st = 1;
    end
    
    n = 1;
    for i=st:length(txt{1})
        if( strcmp(field_name,txt{1}(i)) )
            indices(n)= i; %no prelocated for now
            n = n+1;
        end
    end
end