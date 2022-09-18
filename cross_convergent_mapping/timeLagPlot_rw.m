clear 
clc

%% random walk 
N=10000;
x(1)=0;
for t = 2:N
    A = sign(randn);
    x(t) =  x(t-1) +  A;
end

t=  500;
x0 = x(1:end-2*t);
x1 = x(t+1 :end-t);
% x2 = x(2*t+1:end);
% plot3(x0,x1,x2,'.');
plot(x0,x1,'.')
set(gca,'fontsize',20)
grid on