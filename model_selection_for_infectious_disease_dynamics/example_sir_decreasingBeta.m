% Copyright 2015, All Rights Reserved
% Code by Steven L. Brunton
% For Paper, "Discovering Governing Equations from Data: 
%        Sparse Identification of Nonlinear Dynamical Systems"
% by S. L. Brunton, J. L. Proctor, and J. N. Kutz

clear all, close all, clc
figpath = '../figures/';
addpath('./utils');

%% generate Data
polyorder = 2;
usesine = 0;

% beta = @(t,n) 1.1*(t<=n/2) + 1.1/2 *(t>n/2);
beta1 = 1.8/2; beta2=1.8; xi=0.01;
beta= @(x,n)    ( (beta1+beta2)/2 + (beta1-beta2)/2*tanh(((x) - 0.1*n)/xi)  )  ;
gamma = 0.5;

n = 2;
%% solve sir 
s0 = 0.9; i0 = 0.1;
x0 = [s0 i0]
h = 0.01; tspan = [0:h:10]; 
S = [];
I = [];
eps = 0.1;
betavec = [];
for tt = tspan
    s1 = s0 + h*(-beta(tt,tspan(end))*s0.*i0);
    i1 = i0 + h*(beta(tt,tspan(end))*s0.*i0 - gamma*i0);
    betavec = [betavec beta(tt,tspan(end))];
    S = [S s1]; I = [I i1];
    s0 = s1; i0 = i1; 
end
x = [S', I'];
t = tspan;

figure (1)
% plot(tspan, beta(tspan,tspan(end)),'-k','linewidth',1.5);
plot(tspan, betavec,'-k','linewidth',1.5);
xlabel('t');
ylabel('\beta');
xlim([tspan(1) tspan(end)])
title('transmission rate')
set(gca,'fontsize',20)

% figure (2)
% subplot(2,1,1)
% plot(t,x(:,1),'-k','LineWidth',1.5); hold on 
% subplot(2,1,2)
% plot(t,x(:,2),'-k','LineWidth',1.5); 

%% compute Derivative
% eps = 0;
% dx =  zeros(size(x));
% for i = 1:size(x,1)
% dx(i,1) = -beta(i,size(x,1))*x(i,1)*x(i,2);
% dx(i,2) = beta(i,size(x,1))*x(i,1)*x(i,2)- gamma*x(i,2);
% end
% dx = dx + eps*randn(size(dx));

dt = h;
for i=3:length(x)-3
    for k=1:2 
        dx(i-2,k) = (1/(12*dt))*(-x(i+2,k)+8*x(i+1,k)-8*x(i-1,k)+x(i-2,k));
    end
end  
% concatenate
x = x(3:end-3,:);
tspan = tspan(3:end-3);
t=tspan;
eps = 0;
dx = dx + eps*randn(size(dx));

%% pool Data  (i.e., build library of nonlinear time series)
Theta = poolData(x,n,polyorder,usesine);
m = size(Theta,2);

%% compute Sparse regression: sequential least squares
lambda = 0.025;    % lambda is our sparsification knob.
%  lambda=0.01;
Xi = sparsifyDynamics(Theta,dx,lambda,n)
poolDataLIST({'x','y'},Xi,n,polyorder,usesine);

%% FIGURE 1:  LOTKA for T\in[0,20]
tA =t; xA = x; 
% [tA,xA]=ode45(@(t,x)sir(t,x,beta,gamma),tspan,x0,options);   % true model
options = odeset('RelTol',1e-12,'AbsTol',1e-12*ones(1,n));
[tB,xB]=ode45(@(t,x)sparseGalerkin(t,x,Xi,polyorder,usesine),tspan,x0,options);  % approximate

figure (2)
subplot(1,2,1)
plot(xA(:,1),xA(:,2),'-k','LineWidth',2); hold on
xlabel('S')
ylabel('I')
title('true model')
set(gca,'fontsize',15)
subplot(1,2,2)
plot(xB(:,1),xB(:,2),'--k','LineWidth',2)
xlabel('S')
ylabel('I')
title('approximation')
set(gca,'fontsize',15)


figure (3)
subplot(2,1,1)
plot(tA,xA(:,1),'-k','LineWidth',2); hold on 
plot(tB,xB(:,1),'--r','LineWidth',2); hold on
xlabel('t')
ylabel('S')
legend('true model','approximation')
set(gca,'fontsize',15)
subplot(2,1,2)
plot(tA,xA(:,2),'-k','LineWidth',2); hold on 
plot(tB,xB(:,2),'--r','LineWidth',2);
xlabel('t')
ylabel('I')
legend('true model','approximation')
set(gca,'fontsize',15)


