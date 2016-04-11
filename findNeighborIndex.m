function i = findNeighborIndex( direction, neighbors )
% Finds the index of the direction in the neighbor array
    i = find(neighbors(1,:)==direction(1) & neighbors(2,:)==direction(2));
end

