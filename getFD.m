function FD = getFD( B )
%GETFD Get fourier descriptors

% Get centroid of boundary
C = getCentroid(B);

% Use y as complex plane
U = (B(2,:) - C(2)) + i * (B(1,:) - C(1));
%U = sqrt((B(2,:) - C(2)).^2+(B(1,:) - C(1)).^2);
%figure;
%plot(U);
%pause;
%U = (B(2,:)+i*(B(1,:)));

% Take the fourier transform to obtain coefficients
%F = fft(U);
F = getFourierCoefficients(U);
plot(abs(F));
FD = F;

%pause;
return;
% Make it translation invariant
F(1) = 0;

num_coeffs = 32;
l = min(num_coeffs, length(F));
% Make it scale, rotation and starting point invariant
FD = abs(F(1:l)) / abs(F(2));
FD = [FD,zeros(1,num_coeffs-l)];
plot(abs(F));
pause;
return;
% Take the 32 largest values
[sortedFD,sortingIndices] = sort(FD,'descend');
FD = sortedFD(1:32);
end

