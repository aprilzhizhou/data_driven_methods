function [ X,Y ] = undirectinalGenerate(length )
% this program generates time series X and Y such that 
% X is unidirectionally causing Y. 

T = length; 

% parameter values 
%(see supplementary material page 6 asymmetrically coupled dynamic system)
rx =3.7; ry = 3.7; beta_xy = 0.32; beta_yx = 0.32; 
x0 = 0.2; y0 = 0.4;

% rx =3.8; ry = 3.5; beta_xy = 0; beta_yx = 0.1; 
% x0 = 0.8; y0 = 0.8;

% rx =3.8; ry = 3.8; beta_xy = 0.2; beta_yx = 0.1; 
% x0 = 0.4; y0 = 0.2;

X = [x0]; Y = [y0];
for t = 1:T
    x1 = x0*(rx - rx*x0 - beta_xy*x0) ;
    y1 = y0*(ry - ry*y0 - beta_yx*x0);
    X = [X x1]; 
    Y = [Y y1];
    x0 = x1;
    y0 = y1; 
end


end

