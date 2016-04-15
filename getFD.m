function FD = getFD( B )
%GETFD Get fourier descriptors

% Get centroid of boundary
C = getCentroid(B);

% Use y as complex plane
U = (B(2,:) - C(2)) + i * (B(1,:) - C(1));

% Take the fourier transform to obtain coefficients
F = fft(U);

% Make it translation invariant
F(1) = 0;

% Make it scale, rotation and starting point invariant
FD = abs(F(1:32)) / abs(F(2));


end

