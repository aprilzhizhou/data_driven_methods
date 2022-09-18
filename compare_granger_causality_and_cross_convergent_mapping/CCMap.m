function [predict_x,residual_x,OrigX,X_lagged, predict_y,residual_y,OrigY,Y_lagged corr] = CCMap(Xdata,Ydata,tau,E,L)
%% Given two time series Xdata and Ydata, use the first L terms to construct CCM and compute correlations
%% It may take a couple seconds to run if L is large.
% input list:
% Xdata, Ydata: two time series (full)
% tau: time lag
% E: dimension
% L: length

% output list:
% residual:  the prediction substracted by actual data 
% corr: correlation. corr(1) = corr(Y,Y^), corr(2)=corr(X,X^)
% predict: prediction made by CCM

%%
start_time = 1 + (E-1)*tau;
lagged_length = L - start_time + 1;
predict_x = zeros(1,lagged_length);
predict_y = zeros(1,lagged_length);
OrigX = Xdata(start_time:L);
OrigY = Ydata(start_time:L);

X_lagged = zeros(lagged_length, E);
Y_lagged = zeros(lagged_length, E);

%% Shadow manifolds
for i = start_time : L
   X_lagged(i - (E-1)*tau,:) = Xdata(i:-tau:i-(E-1)*tau);
   Y_lagged(i - (E-1)*tau,:) = Ydata(i:-tau:i-(E-1)*tau);
end

%%
%%CCM
for j = 1:lagged_length
   [nx,dx] = knnsearch(X_lagged,X_lagged(j,:),'k',E+2); 
   [ny,dy] = knnsearch(Y_lagged,Y_lagged(j,:),'k',E+2); 
   correspond_y = OrigY(nx(2:end));
   correspond_x = OrigX(ny(2:end));
   sugi_dx = dx(:,2:E+2);
   sugi_dy = dy(:,2:E+2);
   u_x = exp(-sugi_dx./sum(sugi_dx(:,1)));
   u_y = exp(-sugi_dy./sum(sugi_dy(:,1)));
   w_x=u_x./(sum(u_x,2)*ones(1,E+1));
   w_y=u_y./(sum(u_y,2)*ones(1,E+1));
   predict_y(j)= w_x*correspond_y';
   predict_x(j)= w_y*correspond_x';
end

residual_y = predict_y - OrigY;
residual_x = predict_x - OrigY;

A = corrcoef(predict_y, OrigY);
B = corrcoef(predict_x, OrigX);

corr(1,1) = A(1,2);
corr(1,2) = B(1,2);

end

