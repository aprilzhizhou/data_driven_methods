rx =1.2; ry = 0.1; beta_yx = 7;
% xfix = -(1-rx)/rx;
% yfix = -(rx - rx*ry - beta_yx + rx*beta_yx)/(rx*ry);

xfix = (rx-1)/rx;
yfix = 0; 
eps= 0.4;


eig = [-1 - rx - 2 *rx*xfix ,-1 + ry - 2*ry*yfix - xfix *beta_yx]

x0 = xfix+eps; X = [x0];
y0 = yfix+eps; Y = [y0];
T = 500;
for t = 1:T
    x1 = x0*(rx - rx*x0) ;
    y1 = y0*(ry - ry*y0 - beta_yx*x0);
    X = [X x1]; 
    Y = [Y y1];
    x0 = x1;
    y0 = y1; 
end

figure(1)
plot(X,Y,'linewidth',2);
hold on
plot(xfix,yfix,'o','MarkerEdgeColor','r',...
    'MarkerFaceColor','r',...
    'MarkerSize',5);
set(gca,'fontsize',20)

figure(2)
plot(1:T+1,X,'linewidth',2); hold on
plot(1:T+1,Y,'linewidth',2)
set(gca,'fontsize',20)