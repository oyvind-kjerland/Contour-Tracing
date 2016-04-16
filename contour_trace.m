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


% Obtain database
database = struct;
filenames = dir('database/*.png');

for f=1:length(filenames)
    filename = filenames(f).name;
    
    fullpath = strcat('database/',filename);

    I_DB = imread(fullpath);
    I_DB = segmentImage(I_DB);
    B_DB = trace(I_DB);
    BBOX_DB = getBoundingBox(B_DB);
    B_DB = repositionBoundary(B_DB);
    FD_DB = getFD(B_DB);
    
    database(f).name = filename;
    %database(f).I = I_DB;
    %database(f).B = B_DB;
    database(f).BBOX = BBOX_DB;
    database(f).FD = FD_DB;
end


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

