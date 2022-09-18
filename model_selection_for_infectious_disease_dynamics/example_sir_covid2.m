% Copyright 2015, All Rights Reserved
% Code by Steven L. Brunton
% For Paper, "Discovering Governing Equations from Data: 
%        Sparse Identification of Nonlinear Dynamical Systems"
% by S. L. Brunton, J. L. Proctor, and J. N. Kutz

clear all, close all, clc
hubei_covid19_data2
figpath = '../figures/';
addpath('./utils');

%% generate Data
polyorder = 2;
usesine = 0;

n = 2;
%% solve sir 

x = [data_S', data_I'];
x0 = x(1,:);
tspan = tspan2';


%% compute Derivative

for i=3:length(data_S)-3
    for k=1:2 
        dx(i-2,k) = (1/(12*dt))*(-x(i+2,k)+8*x(i+1,k)-8*x(i-1,k)+x(i-2,k));
    end
end  

%% concatenate
x = x(3:end-3,:);
tspan = tspan(3:end-3);

eps = 0;
dx = dx + eps*randn(size(dx));

%% pool Data  (i.e., build library of nonlinear time series)
Theta = poolData(x,n,polyorder,usesine);
m = size(Theta,2);

%% compute Sparse regression: sequential least squares
lambda = 0.025;    % lambda is our sparsification knob.
Xi = sparsifyDynamics(Theta,dx,lambda,n)
poolDataLIST({'x','y'},Xi,n,polyorder,usesine);

%% FIGURE 1:  LOTKA for T\in[0,20]
tA =tspan; xA = x; 
% [tA,xA]=ode45(@(t,x)sir(t,x,beta,gamma),tspan,x0,options);   % true model
options = odeset('RelTol',1e-12,'AbsTol',1e-12*ones(1,n));
tspanB = [tspan(1):0.001:100];
% tspanB = tspan;
[tB,xB]=ode15s(@(t,x)sparseGalerkin(t,x,Xi,polyorder,usesine),tspanB,x0,options);  % approximate

% figure (2)
% subplot(1,2,1)
% plot(xA(:,1),xA(:,2),'-k','LineWidth',2); hold on
% xlabel('S')
% ylabel('I')
% title('data')
% set(gca,'fontsize',15)
% subplot(1,2,2)
% plot(xB(:,1),xB(:,2),'--k','LineWidth',2)
% xlabel('S')
% ylabel('I')
% title('approximation')
% set(gca,'fontsize',15)


figure (3)
subplot(2,1,1)
plot(1:length(hubei_I),hubei_S/N,'bo','linewidth',1.5); hold on
plot(tA,xA(:,1),'-k','LineWidth',2); hold on 
plot(tB,xB(:,1),'--r','LineWidth',2); 
legend('data','regression','approximation')
xlabel('t')
ylabel('S')
set(gca,'fontsize',15)
subplot(2,1,2)
plot(1:length(hubei_I),hubei_I/N,'bo','linewidth',1.5); hold on
plot(tA,xA(:,2),'-k','LineWidth',2); hold on 
plot(tB,xB(:,2),'--r','LineWidth',2); hold on
xlabel('t')
ylabel('I')
legend('data','regression','approximation')
set(gca,'fontsize',15)

% figure (4)
% tspanB = [tspan(1):0.001:52];
% [tB,xB]=ode15s(@(t,x)sparseGalerkin(t,x,Xi,polyorder,usesine),tspanB,x0,options);  % approximate
% plot(tB,xB(:,2),'--r','LineWidth',1.5);