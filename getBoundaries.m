function BS = getBoundaries( B, I )
%GETBOUNDARIES get inner boundaries

    
    % Get bounding box of B
    bbox = getBoundingBox(B);
    bbox(3) = bbox(3) + 3;
    bbox(4) = bbox(4) + 3;
    
    % Reposition B
    B = repositionBoundary(B);

    % Create temp mat
    T = ones(bbox(4), bbox(3));
    
    fill = fillBoundary(B,T);
    imshow(fill);
    
    width = bbox(3);
    height = bbox(4);
    startX = bbox(1)-1;
    startY = bbox(2)-1;
    endX = startX + width - 1;
    endY = startY + height - 1;
    
    I_bbox = I(startY:endY, startX:endX);

    

    % Mask the output
    imshow(I_bbox);
    %pause;
        hold off;
    imshow(fill);
    I_bbox = I_bbox .* fill;

    %pause;
    % Label the inverse
    I_inv = ~I_bbox;
    
    I_labels = bwlabel(I_inv);

    % Remove background
    I_labels(I_labels==1) = 0;
    imshow(I_labels);
    
    labels = unique(I_labels);

    BS = struct;
    
    imshow(I_labels);
    %pause;
    for l=2:labels(end)
  
        B = trace(I_labels);
    
        % find current label
        label = I_labels(B(1,1),B(2,1));

        % Remove from labels
        I_labels(I_labels==label) = 0;

        % Move the boundary again
        B = [B(1,:)+startY-1; B(2,:)+startX-1];
        
        BS(l-1).boundary = B;
    end
end

