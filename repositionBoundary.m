function O = repositionBoundary( B )
%REPOSITIONBOUNDARY Reposition the boundary

    % Get the bounding box of the boundary
    bbox = getBoundingBox(B);

    % Reposition the boundary
    O = [B(1,:)-bbox(2)+2 ; B(2,:)-bbox(1)+2];
end

