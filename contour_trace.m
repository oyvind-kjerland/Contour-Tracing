% ----
% DONE
% ----
% trace routine radial sweep
% descriptors
%   centroid
%   bounding box
%   fourier descriptor
%   PCA

% ----
% TODO
% ----
% more trace routines?
% descriptors
%   chain codes
%   statistical moments
% recognition based on descriptors
%   check for rotation, translation, scale, projective

% ----
% OPTIONAL
% ----
% image processing and basic thresholding
% b-splines


%{

% Compare square against scaled and rotated versions
I = imread('database/square.png');
I_square = im2bw(rgb2gray(I));
I = imread('square_scaled.png');
I_square_scaled = im2bw(rgb2gray(I));
I = imread('diamond.png');
I_diamond = im2bw(rgb2gray(I));
I = imread('database/L.png');
I_L = im2bw(rgb2gray(I));

B_square = trace(I_square);
B_square_scaled = trace(I_square_scaled);
B_diamond = trace(I_diamond);
B_L = trace(I_L);

FD_square = getFD(B_square);
FD_square_scaled = getFD(B_square_scaled);
FD_diamond = getFD(B_diamond);
FD_L = getFD(B_L);

D_square = checkFDerror(FD_square, FD_square);
D_square_scaled = checkFDerror(FD_square_scaled, FD_square);
D_diamond = checkFDerror(FD_diamond, FD_square);
D_L = checkFDerror(FD_L, FD_square);

% Test something
D_diamond_square = checkFDerror(FD_diamond, FD_square);
D_diamond_L = checkFDerror(FD_diamond, FD_L);
D_diamond_square_scaled = checkFDerror(FD_diamond, FD_square_scaled);

%}


database = createDatabase();


I_shapes = imread('shapes.png');
I_shapes = (segmentImage(I_shapes));
imshow(I_shapes);
I_labels = bwlabel(I_shapes);
% Find unique values
labels = unique(I_labels);

BS = struct;

% Go through the labels and trace
for l=1:labels(end)
    B = trace(I_labels);
    
    %if (l==12)
        innerBoundaries = getBoundaries(B, I_shapes);
        BS(l).innerBoundaries = innerBoundaries;
    %end
    BS(l).boundary = B;
    
    % find current label
    label = I_labels(B(1,1),B(2,1));
    
    % Remove from labels
    I_labels(I_labels==label) = 0;
end

% Plot the image
figure;
imshow(I_shapes);
hold on;

% Check the boundaries and map on the original image
for b=1:length(BS)
    B = BS(b).boundary;
    plot(B(2,:),B(1,:),'b');
    
    disp(length(BS(b).innerBoundaries));
    
    full_boundary = B;
    
    innerBoundaries = BS(b).innerBoundaries;
    numInnerBoundaries = 0;

    if (isfield(innerBoundaries,'boundary'))
        for ib=1:length(innerBoundaries)

            IB = innerBoundaries(ib).boundary;

            plot(IB(2,:),IB(1,:),'g');
            full_boundary = [full_boundary, IB];
            
            numInnerBoundaries = length(innerBoundaries);
        end
    end
    
    %plot(full_boundary(2,:),full_boundary(1,:));
    pca_d = getPCAdescriptor(full_boundary);

    
    
    BBOX = getBoundingBox(B);
    rectangle('Position',BBOX, 'EdgeColor', 'g');
    
    B = repositionBoundary(B);
    FD = getFD(B);
    
    
    % Check against database
    minIndex = 0;
    minError = 10000;
    innerBoundaryPenalty = 1;
    
    for i=1:length(database)
        error = checkFDerror(FD, database(i).FD);
        
        
        %
        % Check inner boundaries
        IB_DB = database(i).IB;
        if (isfield(IB_DB,'boundary'))
            IB_length = length(IB_DB);
            if (IB_length > numInnerBoundaries)
                error = error + (IB_length-numInnerBoundaries)*innerBoundaryPenalty;
            elseif (IB_length < numInnerBoundaries)
                error = error + (numInnerBoundaries-IB_length)*innerBoundaryPenalty;
            else
                for db_ib=1:IB_length
                    db_fd = IB_DB(db_ib).FD;
                    ib_minErr = 1000;
                    for q_ib=1:numInnerBoundaries
                        IB_FD = getFD(B);
                        ib_err = checkFDerror(IB_FD, db_fd);
                        if (ib_err < ib_minErr)
                            ib_minErr = ib_err;
                        end
                    end
                    error = error + ib_minErr;
                end
                
            end
        else
            error = error + innerBoundaryPenalty * numInnerBoundaries;
        end
        %
        
        
        
        disp(error);
        
        % Check PCA error
        %error = error + abs((pca_d - database(i).PCA_D));
        
        
        if (error < minError)
            minError = error;
            minIndex = i;
        end
    end
    
    name = database(minIndex).name;
    disp(name);
    text(BBOX(1),BBOX(2),name,'color','r');
end

return;



%{
B_shapes = trace(I_shapes);
plot(B_shapes(2,:),B_shapes(1,:));
I_labels = bwlabel(I_shapes);
label = I_labels(B_shapes(1,1),B_shapes(2,1));
I_labels(I_labels==label) = 0;
return;

% Test an image
I_test = imread('diamond.png');
I_test = segmentImage(I_test);
B_test = trace(I_test);
B_test = repositionBoundary(B_test);
FD_test = getFD(B_test);

minIndex = 0;
minError = 10000;
for i=1:length(database)
    error = checkFDerror(FD_test, database(i).FD);
    disp(error);
    if (error < minError)
        minError = error;
        minIndex = i;
    end
end

if (minIndex > 0)
    disp(database(minIndex).name);
else
    disp('Could not match')
end
%}
