load('hubei_confirmed')
load('hubei_recovered')
load('hubei_deaths')
N = 100000;

n = length(hubei_confirmed);
hubei_R = hubei_recovered + hubei_deaths;
hubei_I = hubei_confirmed - hubei_recovered;
hubei_S = N - hubei_R - hubei_I;



%% susceptible
figure (1)

tspan = 1:n;
S = hubei_S/N;
p_s = polyfit(tspan,S,5);
f_s = polyval(p_s,tspan);

subplot(2,1,1)
plot(tspan,S,'ko','linewidth',2)
hold on
plot(tspan,f_s,'r-','linewidth',2)
legend('data','polyfit')
title('Susceptible population')
xlabel('day')
set(gca,'fontsize',15)

%% infected
tspan = 1:n;
% tspan =[ tspan , 200:300];
I = hubei_I/N;
% I = [I, zeros(1,length(200:300))];
p_i = polyfit(tspan,I,5);
f_i = polyval(p_i,tspan);

subplot(2,1,2)
plot(tspan,I,'ko','linewidth',2)
hold on
plot(tspan,f_i,'r-','linewidth',2)
legend('data','polyfit')
title('Infected population')
xlabel('day')
set(gca,'fontsize',15)

figure (2)
subplot(2,1,1)
plot(1:n,hubei_S/N,'ko','linewidth',1.5); hold on;
plot(1:n,hubei_I/N,'ro','linewidth',1.5); 
legend('susceptible','infected')
title('Data')
xlabel('day')
set(gca,'fontsize',15)

subplot(2,1,2)
tstart =8;
tend = 48
f_s1 = f_s(tstart:tend);
f_i1 = f_i(tstart:tend);
tspan1 = tspan(tstart:tend);

plot(tspan1,f_s1,'k-','linewidth',2)
hold on
plot(tspan1,f_i1,'r-','linewidth',2)
legend('susceptible','infected')
title('Polyfit')
xlabel('day')
set(gca,'fontsize',15)

dt = 0.01; 
tspan2 =tstart:dt:tend;
data_S = polyval(p_s,tspan2);
data_I = polyval(p_i,tspan2);
% figure (3)
% plot(data_S); hold on
% plot(data_I)
