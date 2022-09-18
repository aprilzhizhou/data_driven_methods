close all
var =1; tMax =  5000;
%% Granger causality test 
%% linear time series 
% [x,y]=ar_linearGenerate(var, tMax);
% var1 = regression(y',x',1,1)
% var2 = regression(y',x',1,0)
% 
% if var1 < var2
%     fprintf('x is causing y.\n')
% else
%     fprintf('n/a\n')
% end
%% nonlinear time series

% [x,y]=ar_nonlinearGenerate(var, tMax);
% var1 = regression(y',x',1,1)
% var2 = regression(y',x',1,0)
% 
% if var1 < var2
%     fprintf('x is causing y.\n')
% else
%     fprintf('n/a\n')
% end
% plot(y,'.-'); hold on; plot(x,'.-');
% legend('y','x');
% xlabel('t');
% set(gca,'fontsize',20)

%% CCM test 
%% linear time series
% [x,y]=ar_linearGenerate(var, tMax);
% plot(x,y,'.')
% ccm_2d_2(x,y)
%% nonlinear time series
figure (1)
[x,y]=ar_nonlinearGenerate(var, tMax);
plot(y,'.-'); hold on; plot(x,'.-');
legend('y','x');
xlabel('t');
set(gca,'fontsize',20)

figure (2)
ccm_2d_2(x,y)