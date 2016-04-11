function i = findVecIndex( vec, mat )
    i = find(mat(1,:)==vec(1) & mat(2,:)==vec(2));
    if (isempty(i))
        i = -1;
    end
end

