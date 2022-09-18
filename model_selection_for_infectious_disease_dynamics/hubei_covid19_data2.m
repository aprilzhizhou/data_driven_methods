load('hubei_confirmed')
load('hubei_recovered')
load('hubei_deaths')
N = 10000000;
% N = 100000;

n = length(hubei_confirmed);
hubei_R = hubei_recovered + hubei_deaths;
hubei_I = hubei_confirmed - hubei_recovered;
hubei_S = N - hubei_R - hubei_I;



%% susceptible
figure (1)

tspan = 1:n;
S = hubei_S/N;
alpha = min(S); beta = max(S);
ys = @(b,x) 1/2*(alpha+beta + (beta-alpha)*erf(b(1)-b(2)*x) );
OLS = @(b) norm(ys(b,tspan) - S);          % Ordinary Least Squares cost function
opts = optimset('MaxFunEvals',50000, 'MaxIter',10000);
Bs = fminsearch(OLS, rand(2,1), opts)       % Use ?fminsearch? to minimise the ?OLS? function

f_s = ys(Bs,tspan);

% figure(1)
% plot(x, yx, '*r')
% hold on
% x1 = linspace(x(1),x(end),100)
% plot(x1, y(B,x1), 'k-','linewidth',2)
% hold on
% grid

subplot(2,1,1)
plot(tspan,S,'ko','linewidth',2)
hold on
plot(tspan,f_s,'r-','linewidth',2)
legend('data','regression')
title('Susceptible population')
xlabel('day')
set(gca,'fontsize',15)

%% infected
tspan = 1:n;
tspan_ext=[ tspan , 200:300];
I = hubei_I/N;
Iext = [I, zeros(1,length(200:300))];
% y = @(b,x) b(1).*exp(b(3)-b(2).*x);    % Objective function
yi = @(b,x) max(I).*exp(-b(1)*log(x/31).^2);
% p = [3; 5]*1E-1;                            % Create data
% x  = linspace(1, 10);
% yx = y(p,x) + 0.1*(rand(size(x))-0.5);


OLS = @(b) norm(yi(b,tspan_ext) - Iext);          % Ordinary Least Squares cost function
opts = optimset('MaxFunEvals',50000, 'MaxIter',10000);
Bi = fminsearch(OLS, rand(1,1), opts)       % Use ?fminsearch? to minimise the ?OLS? function

tspan_ext2 = tspan_ext(1):0.1:tspan_ext(end);
f_i =yi(Bi,tspan_ext2);

subplot(2,1,2)
plot(tspan_ext,Iext,'ko','linewidth',2)
hold on
plot(tspan_ext2,f_i,'r-','linewidth',2)
legend('data','regression')
title('Infected population')
xlabel('day')
set(gca,'fontsize',15)

figure (2)


subplot(2,1,1)
plot(1:n,hubei_S/N,'ko','linewidth',2); hold on;
plot(1:n,hubei_I/N,'ro','linewidth',2); 
legend('susceptible','infected')
title('Data')
xlabel('day')
set(gca,'fontsize',15)

subplot(2,1,2)
tstart =0;
tend = 50;
dt = 0.01;
tspan2 =tstart:dt:tend;
data_S = ys(Bs,tspan2);
data_I = yi(Bi,tspan2);

plot(tspan2,data_S,'k-','linewidth',2)
hold on
plot(tspan2,data_I,'r-','linewidth',2)
legend('susceptible','infected')
title('Regression')
xlabel('day')
set(gca,'fontsize',15)

% dt = 0.01; 
% tspan2 =tstart:dt:tend;
% data_S = polyval(p_s,tspan2);
% data_I = polyval(p_i,tspan2);
% % figure (3)
% % plot(data_S); hold on
% % plot(data_I)
