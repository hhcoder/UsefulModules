function ret = GuidedFilter(A, G)
    if sum(size(A)) > sum(size(G))
        Gp = imresize(G, size(A));
        Ap = A;
    else
        Ap = imresize(A, size(G));
        Gp = G;
    end
   
    neighborhood_size = [45 45];
    degree_of_smoothing = 1.5;
    ret = imguidedfilter(Ap, Gp, ...
        'NeighborhoodSize', neighborhood_size, ...
        'DegreeOfSmoothing', degree_of_smoothing);
end