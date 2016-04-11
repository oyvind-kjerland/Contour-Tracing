function B = trace(I_bw) 
    %
    % start contour procedure
    %

    % The boundary points
    B = [];

    % The direction to reach the boundary points from the previous boundary
    % point
    P = [];

    % Find size of image
    [width, height] = size(I_bw);

    % Scan from top left until finding the starting pixel
    s = [1;1];
    brk = 0;
    for y=1:height,
        for x=1:width,
            % Check if the pixel is black
            if (I_bw(y,x) == 0)
                s = [y;x];
                brk = 1;
                break;
            end;
        end;
        if (brk == 1)
            break;
        end;
    end;


    neighbors = [
        0 -1;
        -1 -1;
        -1 0;
        -1 1;
        0 1;
        1 1;
        1 0;
        1 -1
    ];
    neighbors = transpose(neighbors);

    % Update B
    B = [B, s];

    prev = neighbors(:,1);

    % Update P
    P = [P, prev];

    max_tries = 3000;
    done = 0;

    % neighbor tracing
    for i=1:max_tries

        % Find the index of the previous neighbor direction
        pIndex = findNeighborIndex(prev, neighbors);

        % Go through neighbors clockwise
        for n=0:7
            nIndex = mod(pIndex + n, 8) + 1;

            offset = neighbors(:,nIndex);
            c = s + offset;

            if (I_bw(c(1),c(2)) == 0)
                % set the previous direction
                prev = -offset;

                bIndex = findVecIndex(c, B);
                if (bIndex > 0)
                    if (isequal(prev, P(:,bIndex)))
                       done = 1;
                       break;
                    end
                end

                % Update the point
                s = c;

                % add the point to the contour list
                B = [B, s];
                P = [P, prev];


                break;
            end
        end

        if (done == 1)
            break;
        end 
    end
end











