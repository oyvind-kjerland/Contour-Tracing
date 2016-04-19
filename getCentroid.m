function C = getCentroid( B )
    % Get the centroid of the boundary B
    bbox = getBoundingBox(B);

    % Create temp mat
    T = ones(bbox(4)+3, bbox(3)+3);
    
    fillBoundary(B,T);
    

    
    
    
    %{
    
    % Set boundary
    for n=1:size(B,2)
        T(B(1,n),B(2,n)) = 0;
    end
    
    % fill the image
    inside = 0;
    onedge = 0;
    edges = 0;
    startstate = 0;
    endstate = 0;
    STATE_TOP = 1;
    STATE_BOTTOM = 2;
    
    for y=1:size(T,1)
        inside = 0;
        onedge = 0;
        for x=1:size(T,2)
            if (T(y,x)==1 && onedge==1)
                
                % get end state
                if (edges > 1 && x < size(T,2) && (T(y+1,x)==0 || T(y+1,x+1)==0))
                    endstate = STATE_TOP; 
                else
                    endstate = STATE_BOTTOM;
                end
                
                if (edges > 1 && startstate==endstate)
                    % do not toggle inside
                else
                    if (inside == 1)
                        inside = 0;
                    else
                        inside = 1;
                    end
                end
                onedge = 0;
                edges = 0;
                startstate = 0;
                endstate = 0;
                
            elseif (T(y,x)==0 && onedge==0)
                onedge = 1;
                
                % Get startstate
                if (T(y+1,x-1)==0 || T(y+1,x)==0)
                    startstate = STATE_TOP;
                else
                    startstate = STATE_BOTTOM;
                end
                edges = edges + 1;
                
            elseif (T(y,x)==0) 
                edges = edges + 1;
            end;
            
            if (inside == 1)
                T(y,x) = 0;
            end;
        end
    end
    %}

    [y,x] = ind2sub(size(T),find(T));
    cX = sum(x)/length(x);
    cY = sum(y)/length(y);
    C = [cY; cX];
    
end

