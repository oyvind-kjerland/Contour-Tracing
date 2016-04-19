function descriptor = getPCAdescriptor( B )
%GETPCAEIGENVALUES Get eigenvalues of boundary B


% Transpose boundary
B = transpose(B);
B(:,[1,2]) = B(:,[2,1]); 

% mean of input vectors
ux = mean(B); 

% Center around mean
x = [B(:,1)-ux(1), B(:,2)-ux(2)];
%figure, plot(x(:,1), x(:,2), '.');
%title('Centered input vectors');
%axis equal

% Find covariance matrix
Cx = cov(x);

% Find eigenvalues of covariance matrix
[V,D] = eig(Cx); 
%hold on
e1 = V(:,1);
e2 = V(:,2);
d1 = D(1,1);
d2 = D(2,2);

%line([0 d1*e1(1)], [0 d1*e1(2)], 'Color', 'g', 'LineWidth', 2);
%line([0 d2*e2(1)], [0 d2*e2(2)], 'Color', 'g', 'LineWidth', 2);

if (D(1,1) > D(2,2))
    descriptor = D(1,1) / D(2,2);
else
    descriptor = D(2,2) / D(1,1);
end

end

