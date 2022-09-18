% Copyright 2015, All Rights Reserved
% Code by Steven L. Brunton
% For Paper, "Discovering Governing Equations from Data: 
%        Sparse Identification of Nonlinear Dynamical Systems"
% by S. L. Brunton, J. L. Proctor, and J. N. Kutz

clear all, close all, clc
figpath = '../figures/';
addpath('./utils');

%% generate Data
polyorder = 3;
usesine = 0;

beta = 1.1;
gamma = 0.5;

n = 2;

x0 = [0.9 0.1] % Initial condition

% Integrate
dt = 0.01
tspan=[0001:dt:10];
% tspan = [0:0.1: 20] % insufficient sampling 
% tspan=[0.001:.1:300];
N = length(tspan);
options = odeset('RelTol',1e-12,'AbsTol',1e-12*ones(1,n));
[t,x]=ode45(@(t,x) sir(t,x,beta,gamma),tspan,x0,options);


figure (1)
subplot(2,1,1)
plot(t,x(:,1),'-k','LineWidth',2); hold on 
subplot(2,1,2)
plot(t,x(:,2),'-k','LineWidth',2); 

%% compute Derivative
eps = 0;
dx =  zeros(size(x));
for i=1:length(x)
    dx(i,:) = sir(0,x(i,:),beta,gamma);
end
dx = dx + eps*randn(size(dx));


% for i=3:length(x)-3
%     for k=1:2 
%         dx(i-2,k) = (1/(12*dt))*(-x(i+2,k)+8*x(i+1,k)-8*x(i-1,k)+x(i-2,k));
%     end
% end  
% %concatenate
% x = x(3:end-3,:);
% tspan = tspan(3:end-3);


%% pool Data  (i.e., build library of nonlinear time series)
Theta = poolData(x,n,polyorder,usesine);
m = size(Theta,2);

%% compute Sparse regression: sequential least squares
lambda = 0.025;    % lambda is our sparsification knob.
% lambda=0.01;
Xi = sparsifyDynamics(Theta,dx,lambda,n)
poolDataLIST({'x','y'},Xi,n,polyorder,usesine);

%% FIGURE 1:  LOTKA for T\in[0,20]
%tA =t; xA = x; 
[tA,xA]=ode45(@(t,x)sir(t,x,beta,gamma),tspan,x0,options);   % true model
[tB,xB]=ode45(@(t,x)sparseGalerkin(t,x,Xi,polyorder,usesine),tspan,x0,options);  % approximate

figure (2)
subplot(1,2,1)
plot(xA(:,1),xA(:,2),'-k','LineWidth',2); hold on
xlabel('x')
ylabel('S')
title('true model')
set(gca,'fontsize',15)
subplot(1,2,2)
plot(xB(:,1),xB(:,2),'--k','LineWidth',2)
xlabel('x')
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


