function UiDisplayWaitBar(from, to, name, delay_time)
    if nargin < 4
        delay_time = 0.001;
    end
    h = waitbar(0,name);
    for i=from:to
        pause(delay_time);
    end
    delete(h);
end