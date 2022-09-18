 length = 5000; 

[ X,Y ] = undirectinalGenerate(length)


figure(1)
%% plot shadow manifolds 
tau = 1; % time lag
subplot(1,2,1)
% plot3(X([1:end-2*tau]),X([tau+1:end-tau]),Y(2*tau+1:end),'.','linewidth',2);
plot(X([tau+1:end]),X([1:end-tau]),'.','linewidth',2);
set(gca,'fontsize',20)
subplot(1,2,2)
% plot3(Y([1:end-2*tau]),Y([tau+1:end-tau]),Y(2*tau+1:end),'.','linewidth',2);
plot(Y([tau+1:end]),Y([1:end-tau]),'.','linewidth',2);
set(gca,'fontsize',20)

figure(2)
% T= length;
% plot(1:T+1,X,'linewidth',2); hold on
% plot(1:T+1,Y,'linewidth',2)
% xlim([1,T+1]);
% xlabel('time')
% set(gca,'fontsize',20)
plot(X,Y,'.','linewidth',2)
set(gca,'fontsize',20)