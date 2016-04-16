% ----
% DONE
% ----
% trace routine radial sweep
% descriptors
%   centroid
%   bounding box
%   fourier descriptor

% ----
% TODO
% ----
% more trace routines?
% descriptors
%   chain codes
%   statistical moments
%   PCA
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
    BS(l).boundary = B;
    %figure;
    %plot(B(2,:),B(1,:));
       
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
    plot(B(2,:),B(1,:),'r');
    BBOX = getBoundingBox(B);
    rectangle('Position',BBOX, 'EdgeColor', 'g');
    
    B = repositionBoundary(B);
    FD = getFD(B);
    
    
    % Check against database
    minIndex = 0;
    minError = 10000;
    for i=1:length(database)
        error = checkFDerror(FD, database(i).FD);
        disp(error);
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
