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

beta0 = 1.1;
gamma = 0.5;

n = 2;
%% solve sir 
s0 = 0.9; i0 = 0.1;
x0 = [s0 i0]
h = 0.1; tspan = [0:h:10]; 
S = [];
I = [];
eps = .5;
betaVec = [];
for idx = tspan
    beta = beta0 + eps*randn;
    betaVec = [betaVec beta];
    s1 = s0 + h*(-beta*s0.*i0);
    i1 = i0 + h*(beta*s0.*i0 - gamma*i0);
    S = [S s1]; I = [I i1];
    s0 = s1; i0 = i1; 
end
x = [S', I'];
t = tspan;

figure (1)
plot(tspan, betaVec,'-k','linewidth',1.5);
xlabel('t');
ylabel('\beta');
title('transmission rate')
xlim([tspan(1) tspan(end)])
set(gca,'fontsize',20)



% figure (1)
% subplot(2,1,1)
% plot(t,x(:,1),'-k','LineWidth',1.5); hold on 
% subplot(2,1,2)
% plot(t,x(:,2),'-k','LineWidth',1.5); 

%% compute Derivative
eps = 0.01;
dx =  zeros(size(x));
for i=1:length(x)
    dx(i,:) = sir(0,x(i,:),beta0,gamma);
end
dx = dx + eps*randn(size(dx));


%% pool Data  (i.e., build library of nonlinear time series)
Theta = poolData(x,n,polyorder,usesine);
m = size(Theta,2);

%% compute Sparse regression: sequential least squares
lambda = 0.025;    % lambda is our sparsification knob.
% lambda=0.01;
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
xlabel('x')
ylabel('y')
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


