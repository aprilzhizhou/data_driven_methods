clear all
close all
load('vorticity.mat')
nx = 199; ny = 449; 
% plotVorticity

n = size(VORTALL,1);
t=1:size(VORTALL,2);
uinit = VORTALL(:,1);
usol = VORTALL;
[u_dmd,u_modes] = DMD(usol,uinit);
u_dmd = real(u_dmd);

figure (2)
for j = 1:size(u_dmd,2)
    VORT_dmd = reshape(u_dmd(:,j),nx,ny);
    plotCylinder(VORT_dmd,nx,ny); pause(0.1)
end 





