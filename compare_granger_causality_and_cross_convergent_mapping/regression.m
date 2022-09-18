function [Var] = regression(x,y,p,q)

N = length(x);
% set up linear system
Y = x(p+1:end);
X = ones(length(Y),2+p+q);

if q ==0
    for ii = 1:p
        X(:,1+ii)= x(p+1-ii:N-ii);
    end
else 
    for ii = 1:p
        X(:,1+ii)= x(p+1-ii:N-ii);
    end
    for ii = 0:q
        X(:,p+2+ii)= y(p+1-ii:N-ii);
    end
end

% solve for coefficinet vector B
B = (X'* X)\(X'* Y);

for ii = 1:p+1
    b(ii) = B(ii);
end
for ii = 1:q+1
    a(ii) = B(p+1+ii);
end

% compute residual 
Res = Y - X*B;

% compute variance
Var = var(Res);

end

