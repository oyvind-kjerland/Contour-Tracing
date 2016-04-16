function [ I_SEG ] = segmentImage( I )
%SEGMENTIMAGE Segment image

I_gray = rgb2gray(I);
% TODO perform image processing to smooth image


I_bw = im2bw(I_gray);
% TODO perform morphology to fix segmented structures


I_SEG = I_bw;
end

