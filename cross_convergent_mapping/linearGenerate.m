xSigma = 0.1;
ySigma = 0.01; 
N=1000;
for t = 1:N
    x(t) = xSigma.*randn(1);
end

for t = 2:N
    y(t) = x(t-1) + ySigma*randn(1);
end

x = x(2:end); x = x';
y = y(2:end); y = y';