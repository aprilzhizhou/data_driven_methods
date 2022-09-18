tic


N = 10000; 
eps = 0.03; 
x = zeros(N,1);
y = zeros(N,1);  
x(1) = rand; 
y(1) = rand; 
for i=2:N
    x(i) = fulam(eps*y(i-1) + (1-eps)*x(i-1)); 
    y(i) = rand; 
end
x = x(N/2:N); 
y = y(N/2:N); 
T = 0;


for i=1:N/2-1
    [pjoint, pcond] = TransferEntropyProb(x, y, i); 
    T = T + pjoint*log(1/pcond); 
end
disp(T)
toc



function y = fulam(x)
y = 2 - x.^2;
end