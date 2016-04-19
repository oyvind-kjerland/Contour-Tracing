function coeffs = getFourierCoefficients( f )
% Calcualte the first n coefficients of the discrete function f

N = length(f);
n = floor(-N/2):floor(N/2);
n = n(1:N);

coeffs = [];

for k=n(1):n(end)
    a = sum(f .* exp((-i)*2*pi*k*n/N)) / N;
    coeffs = [coeffs, a];
end

% get center 
zeroIndex = find(n==0);

% Set it to center for translation invariance
coeffs(zeroIndex) = 0;

% divide by scale
coeffs = coeffs / abs(coeffs(zeroIndex+1));

% Return only a certain amount of coefficients
coeffs = coeffs(zeroIndex-16:zeroIndex+16);

% Make rotation invariant
coeffs = abs(coeffs);

end

