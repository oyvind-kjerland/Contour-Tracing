% ----
% DONE
% ----

% ----
% TODO
% ----
% trace routine for bw image, moore, radial sweep etc
% descriptors
%   centroid
%   bounding box
%   statistical moments
%   fourier
%   PCA
% recognition based on descriptors
%   check for rotation, translation, scale, projective



% ----
% OPTIONAL
% ----
% image processing and basic thresholding
% b-splines


% read image
I = imread('Random.png');

% Turn to bw
I_bw = im2bw(rgb2gray(I));
% show image
figure;
imshow(I_bw);
hold on;

B = trace(I_bw);

% Plot boundary points
for n=1:size(B,2)
    c = B(:,n);
    plot(c(2),c(1), 'r.');
end