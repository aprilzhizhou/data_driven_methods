close all
clear all
%% generate date 
var = 3
%     subplot(2,2,var+1)
figure (1)
[x,y ] = noisy_lotka(var);
%% granger causality test 
% is x causing y 
% var1 = regression(y',x',1,1)
% var2 = regression(y',x',1,0)
% 
% if var1 < var2
%     fprintf('x is causing y.\n')
% else
%     fprintf('n/a\n')
% end
% 
% % is y causing x 
% var1 = regression(x',y',1,1)
% var2 = regression(x',y',1,0)
% 
% if var1 < var2
%     fprintf('x is causing y.\n')
% else
%     fprintf('n/a\n')
% end
%% CCM test
figure (2)
ccm_2d_2(x,y)