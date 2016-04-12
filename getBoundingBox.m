function boundingBox = getBoundingBox( B )
% get the bounding box of a boundary B

    minY = min(B(1,:));
    minX = min(B(2,:));
    maxY = max(B(1,:));
    maxX = max(B(2,:));
    
    boundingBox = [minX minY maxX-minX maxY-minY];
end

