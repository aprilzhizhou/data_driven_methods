function [Xdata,Ydata,Zdata] = generator(end_time,steps,sigma,r,beta,X_initial,Y_initial,Z_initial)
% use runge-kutta(2) to generate data for Lorenz system
% input list:
% end_time: end time
% steps: number of steps taken to end time (MAKE IT BIG)
% sigma, r, beta: parameters of Lorenz System
% X_initial, Y_initial, Z_initial: initial data

%% Initialization
% steps = end_time/dt;
Xdata = zeros(1,steps);
Ydata = zeros(1,steps);
Zdata = zeros(1,steps);
Xdata(1) = X_initial;
Ydata(1) = Y_initial;
Zdata(1) = Z_initial;
dt = end_time/steps


%%Generation
for k = 2 : steps
    rungekutta_x = Xdata(k-1) + dt * sigma * (Ydata(k-1) - Xdata(k-1));
    rungekutta_y = Ydata(k-1) + dt * (r * Xdata(k-1) - Ydata(k-1) - Xdata(k-1) * Zdata(k-1));
    rungekutta_z = Zdata(k-1) + dt * (Xdata(k-1) * Ydata(k-1) - beta * Zdata(k-1));
    
    Xdata(k) = Xdata(k-1) + dt * sigma * (rungekutta_y - rungekutta_x);
    Ydata(k) = Ydata(k-1) + dt * (r * rungekutta_x - rungekutta_y - rungekutta_x * rungekutta_z);
    Zdata(k) = Zdata(k-1) + dt * (rungekutta_x * rungekutta_y - beta * rungekutta_z); 
end