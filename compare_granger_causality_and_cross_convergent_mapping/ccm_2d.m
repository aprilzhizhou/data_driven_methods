function [ ] = ccm(x_data,y_data)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% generate data from an asymmetric system
% [x_data, y_data, z_data] = generator(100, 100000, 10, 26, 8/3, 0, 1,
% 1.05); % original parameters

% x_data = Y1;
% y_data = Y2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% run CCM test
lag = 100;
shadow_dim = 2;
length = 2000;
[predict_x,residual_x,origin_x,lagged_x, predict_y,residual_y,origin_y,lagged_y, corr] = CCMap(x_data,y_data,lag,shadow_dim,length);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% plot origin x data against predicted x data
figure (2)
subplot(3,2,1);
plot(origin_x, predict_x, 'r*');
grid; 
title('Original X versus Predicted X');
xlabel('Original X'); ylabel('Predicted X');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% plot origin z data against predicted z data
subplot(3,2,2);
plot(origin_y, predict_y, 'b*');
grid; 
title('Original Y versus Predicted Y');
xlabel('Original Y'); ylabel('Predicted Y');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% plot correlation coefficient convergence

[corrs1, corrs2, indices] = convergence_plot(x_data,y_data,lag,shadow_dim,length,5,200);
disp(corrs1)
disp(corrs2)
disp(indices)
subplot(3,2,3);
plot(indices, corrs1, 'b*-'); hold on
plot(indices, corrs2, 'r*-');
legend('X^*(t)|M_Y','Y^*(t)|M_X');
grid; 
title('Convergence of Correlation Coefficients');
xlabel('Length'); ylabel('Correlation Coefficient');
hold off
% figure()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% visualize shadow manifold for time series x
subplot(3,2,4);
origin_lagged_x = get_lagged_data(x_data, lag, shadow_dim);
plot(origin_lagged_x(:,1), origin_lagged_x(:,2), 'r');
axis equal;
grid; 
title('Shadow Manifold for Time Series X');
xlabel('X(t)'); ylabel('X(t-\tau)'); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% visualize shadow manifold for time series z
subplot(3,2,5);
origin_lagged_y = get_lagged_data(y_data, lag, shadow_dim);
plot(origin_lagged_y(:,1), origin_lagged_y(:,2), 'g');
axis equal;
grid; 
title('Shadow Manifold for Time Series Y');
xlabel('Y(t)'); ylabel('Y(t-\tau)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% original manifold
subplot(3,2,6);
plot(x_data,y_data, 'b'); 
axis equal;
grid; 
title('Limit Cycle');
xlabel('X'); ylabel('Y');


end
