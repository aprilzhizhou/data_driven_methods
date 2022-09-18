function [corrs1, corrs2, indices] = convergence_plot(x_data, y_data, lag, shadow_dim, length, start_step, step_size)    
    interval = start_step+lag:step_size:length;
    corrs1 = [];
    corrs2 = [];
    indices = [];
    for interval_length = interval
        [predict_x,residual_x,origin_x,lagged_x, predict_y,residual_y,origin_y,lagged_y, corr] = CCMap(x_data,y_data,lag,shadow_dim,interval_length);
        disp(corr)
        corrs1 = [corrs1, corr(1)];
        corrs2 = [corrs2, corr(2)];
        indices = [indices, interval_length];
    end
end