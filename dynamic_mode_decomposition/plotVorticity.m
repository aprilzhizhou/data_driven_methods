close all
clear all

load('vorticity.mat')

nx = 199; ny = 449; 
% n = size(VORTALL,1);
% t=1:size(VORTALL,2);

% VORT = reshape(VORTALL(:,1),nx,ny);
VORTALL = real(VORTALL);
figure (1)
for j = 1:size(VORTALL,2)
    VORT = reshape(VORTALL(:,j),nx,ny);
    plotCylinder(VORT,nx,ny); pause(0.1)
end 



