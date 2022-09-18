function [lagged_x] = get_lagged_data(x_data, lag, dim)
    % get lagged coordinates of input time series with given lag and dimension
    % @return: [x(t), x(t-1*n), ..., x(t-m*n)]
    length = size(x_data, 2);
    lagged_x = zeros(length - (dim-1)*lag, dim);
    for index = 1:length-(dim-1)*lag
        for sub_index = 1:dim
            lagged_x(index, sub_index) = x_data(index+(dim-sub_index)*lag);
        end
    end
end