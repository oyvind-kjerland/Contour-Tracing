function O = fillBoundary( B, T )
%FILLBOUNDARY Fills a boundary and returns the mask
% Get the centroid of the boundary B
    
    T = zeros(size(T));
    % Set boundary
    for n=1:size(B,2)
        T(B(1,n),B(2,n)) = 1;
    end
    
    % Just floodfill it
    O = imfill(T,'holes');
    return;
    
    
    
    
    % fill the image
    inside = 0;
    onedge = 0;
    edges = 0;
    startstate = 0;
    endstate = 0;
    STATE_TOP = 1;
    STATE_BOTTOM = 2;
    startx = -1;
    endx = -2;
    hold off;
    imshow(T);
    hold on;
    
    for y=1:size(T,1)
        inside = 0;
        onedge = 0;
        startx = -1;
        endx = -2;
        
        for x=1:size(T,2)
            
            if (T(y,x)==1 && onedge==1)
                plot(x,y,'g.');
                % get end state
                if (T(y+1,x-1)==0) %|| T(y+1,x)==0 || (x<size(T,2) && T(y+1,x+1)==0))
                    endstate = STATE_TOP;
                   
                    endx = x-1;
                elseif (T(y+1,x)==0)
                    endstate = STATE_TOP;
                    endx = x;
                elseif (x<size(T,2) && T(y+1,x+1)==0)
                    endstate = STATE_TOP;
                    endx = x+1;
                    
                else
                    endstate = STATE_BOTTOM;
                end

                %disp([startstate, endstate]);
                %disp(inside);
                %disp(edges);
                
                if ((startstate==endstate && edges > 1) || (edges==1 && (startstate==STATE_BOTTOM)))
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
                endx =-2;
                startx = -1;
           
            elseif (T(y,x)==0 && onedge==0)
                onedge = 1;
                
                % Get startstate
                if (T(y+1,x-1)==0)
                    startstate = STATE_TOP;
                    startx = x-1;
                elseif (T(y+1,x)==0)
                    startstate = STATE_TOP;
                    starty = x;
                elseif (T(y+1,x+1)==0)
                    startstate = STATE_TOP;
                    starty = x+1;
                else
                    startstate = STATE_BOTTOM;
                end
                edges = edges + 1;
                plot(x,y,'y.');
            elseif (T(y,x)==0 && onedge==1)
                edges = edges + 1;
                
                plot(x,y,'w.');
            end;
            %pause;
            
            if (inside == 1)
                T(y,x) = 0;
                plot(x,y,'r.');
            else
                plot(x,y,'b.');
            end;
            
            
        end
    end
    hold off;
    O = T;

end

