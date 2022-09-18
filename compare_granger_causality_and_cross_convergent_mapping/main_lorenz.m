T = [0:0.001:100];
initV = [0 1 0];
eps = 0.000001;

[X Y Z] = lorenz(28, 10, 8/3,initV,T,eps);
% [X, Y, Z] = generator(100, 100000, 10, 28, 8/3, 0, 1, 0);
% figure (1)
% plot3(X,Y,Z,'linewidth',1); hold on
% plot3(initV(1),initV(2),initV(3),'o','MarkerEdgeColor','r',...
%     'MarkerFaceColor','r',...
%     'MarkerSize',5);
% xlabel('x'); ylabel('y'); zlabel('z');
% title('Lorenz attractor')
% set(gca,'fontsize',20)
% grid on

%% granger 
% part 1: is x causing y? 
var1 = regression(Y,X,1,1) % sig(Y | X,Y)
var2 = regression(Y,X,1,0) % sig(Y | Y)

if var1 < var2
    fprintf('x is causing y.\n')
else
    fprintf('n/a\n')
end


% part 1: is y causing x? 
var1 = regression(X,Y,1,1) % sig(X | X,Y)
var2 = regression(X,Y,1,0) % sig(X | X)

if var1 < var2
    fprintf('y is causing x.\n')
else
    fprintf('n/a\n')
end




% figure (2)
% t=  40;
% x0 = X(1:end-2*t);
% x1 = X(t+1 :end-t);
% x2 = X(2*t+1:end);
% plot3(x0,x1,x2,'linewidth',1);
% xlabel('x_{t}'); ylabel('x_{t+n}'); zlabel('x_{t+2n}');
% set(gca,'fontsize',20)
% grid on
% 
% figure (3)
% y0 = Y(1:end-2*t);
% y1 = Y(t+1 :end-t);
% y2 = Y(2*t + 1:end);
% plot3(y0,y1,y2,'linewidth',1);
% xlabel('y_{t}'); ylabel('y_{t+n}'); zlabel('y_{t+2n}');
% set(gca,'fontsize',20)
% grid on
% 
% 
% figure (4)
% z0 = Z(1:end-2*t);
% z1 = Z(t+1 :end-t);
% z2 = Z(2*t + 1:end);
% plot3(z0,z1,z2,'linewidth',1);
% xlabel('z_{t}'); ylabel('z_{t+n}'); zlabel('z_{t+2n}');
% set(gca,'fontsize',20)
% grid on
% 


%% ccm test 
figure (3)
% ccm_2d_2(X',Y')
ccm_2d_2(X',Y')


