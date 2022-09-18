function dy = lotka1(t,y,alpha,beta)
% Copyright 2015, All Rights Reserved
% Code by Steven L. Brunton
% For Paper, "Discovering Governing Equations from Data: 
%        Sparse Identification of Nonlinear Dynamical Systems"
% by S. L. Brunton, J. L. Proctor, and J. N. Kutz
dy = zeros(2,1);
dy(1) = (1 - alpha*y(2))*y(1);
dy(2) = (-1 + beta*y(1))*y(2);
end