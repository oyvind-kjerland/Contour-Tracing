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




% Compare square against scaled and rotated versions
I = imread('square.png');
I_square = im2bw(rgb2gray(I));
I = imread('square_scaled.png');
I_square_scaled = im2bw(rgb2gray(I));
I = imread('diamond.png');
I_diamond = im2bw(rgb2gray(I));
I = imread('L.png');
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







