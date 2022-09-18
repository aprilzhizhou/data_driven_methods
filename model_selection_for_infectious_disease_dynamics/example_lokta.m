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

alpha = 0.5;
beta = 0.5;

n = 2;

x0 = [20 20] % Initial condition

% Integrate
tspan=[0:.01:300];
% tspan = [0:0.1: 20] % insufficient sampling 
% tspan=[0.001:.1:300];
N = length(tspan);
options = odeset('RelTol',1e-12,'AbsTol',1e-12*ones(1,n));
[t,x]=ode45(@(t,x) lotka1(t,x,alpha,beta),tspan,x0,options);

%% compute Derivative
eps = 1;
dx =  zeros(size(x));
for i=1:length(x)
    dx(i,:) = lotka1(0,x(i,:),alpha,beta);
end
dx = dx + eps*randn(size(dx));

%% pool Data  (i.e., build library of nonlinear time series)
Theta = poolData(x,n,polyorder,usesine);
m = size(Theta,2);

%% compute Sparse regression: sequential least squares
lambda = 0.025;      % lambda is our sparsification knob.
Xi = sparsifyDynamics(Theta,dx,lambda,n)
poolDataLIST({'x','y'},Xi,n,polyorder,usesine);

%% FIGURE 1:  LOTKA for T\in[0,20]
tspan=[0:.01:300];
%tA =t; xA = x; 
[tA,xA]=ode45(@(t,x)lotka1(t,x,alpha,beta),tspan,x0,options);   % true model
[tB,xB]=ode45(@(t,x)sparseGalerkin(t,x,Xi,polyorder,usesine),tspan,x0,options);  % approximate

figure (1)
subplot(1,2,1)
plot(xA(:,1),xA(:,2),'-k','LineWidth',2); hold on
xlabel('x')
ylabel('y')
title('true model')
set(gca,'fontsize',15)
subplot(1,2,2)
plot(xB(:,1),xB(:,2),'--k','LineWidth',1)
xlabel('x')
ylabel('y')
title('approximation')
set(gca,'fontsize',15)


figure (2)
subplot(2,1,1)
plot(tA,xA(:,1),'-k','LineWidth',1.5); hold on 
plot(tB,xB(:,1),'--r','LineWidth',1.5); hold on
xlabel('t')
ylabel('x')
legend('true model','approximation')
set(gca,'fontsize',15)
subplot(2,1,2)
plot(tA,xA(:,2),'-k','LineWidth',1.5); hold on 
plot(tB,xB(:,2),'--r','LineWidth',1.5);
xlabel('t')
ylabel('y')
legend('true model','approximation')
set(gca,'fontsize',15)


