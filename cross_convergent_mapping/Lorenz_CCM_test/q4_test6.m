%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% generate data from an asymmetric system
% [x_data, y_data, z_data] = generator(100, 100000, 10, 26, 8/3, 0, 1,
% 1.05); % original parameters

 [x_data, y_data, z_data] = generator(100, 100000, 10, 28, 8/3, 0, 1, 0); % 15: sigma, 30: r, 4:beta, other arguments reference can be found in "generator.m"
% Fail: [x_data, y_data, z_data] = generator(100, 100/100000, 10, 28, 8/3, 0, 1, 0); % 15: sigma, 30: r, 4:beta, other arguments reference can be found in "generator.m"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% run CCM test
lag = 100;
shadow_dim = 3;
length = 2000;
[predict_x,residual_x,origin_x,lagged_x, predict_y,residual_y,origin_y,lagged_y, corr] = CCMap(x_data,z_data,lag,shadow_dim,length);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% plot origin x data against predicted x data
subplot(2,3,1);
plot(origin_x, predict_x, 'r*');
grid; 
title('Original X versus Predicted X');
xlabel('Original X'); ylabel('Predicted X');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% plot origin z data against predicted z data
subplot(2,3,2);
plot(origin_y, predict_y, 'b*');
grid; 
title('Original Y versus Predicted Y');
xlabel('Original Y'); ylabel('Predicted Y');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% plot correlation coefficient convergence
subplot(2,3,3);
[corrs1, corrs2, indices] = convergence_plot(x_data,y_data,lag,shadow_dim,length,5,200);
disp(corrs1)
disp(corrs2)
disp(indices)
hold on
plot(indices, corrs1, 'b*-');
plot(indices, corrs2, 'r*-');
legend('X^*(t)|M_Y','Y^*(t)|M_X');
grid; 
title('Convergence of Correlation Coefficients');
xlabel('Length'); ylabel('Correlation Coefficient');
hold off
% figure()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% visualize shadow manifold for time series x
subplot(2,3,4);
origin_lagged_x = get_lagged_data(x_data, lag, shadow_dim);
plot3(origin_lagged_x(:,1), origin_lagged_x(:,2), origin_lagged_x(:,3), 'r');
axis equal;
grid; 
title('Shadow Manifold for Time Series X');
xlabel('X(t)'); ylabel('X(t-\tau)'); zlabel('X(t-2\tau)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% visualize shadow manifold for time series z
subplot(2,3,5);
origin_lagged_y = get_lagged_data(z_data, lag, shadow_dim);
plot3(origin_lagged_y(:,1), origin_lagged_y(:,2), origin_lagged_y(:,3), 'g');
axis equal;
grid; 
title('Shadow Manifold for Time Series Y');
xlabel('Y(t)'); ylabel('Y(t-\tau)'); zlabel('Y(t-2\tau)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% original manifold
subplot(2,3,6);
plot3(x_data,y_data,z_data, 'b'); 
axis equal;
grid; 
title('Lorenz attractor');
xlabel('X'); ylabel('Y'); zlabel('Z');
