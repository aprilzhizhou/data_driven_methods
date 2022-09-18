clear all 
close all 

NLS
[u_dmd,u_modes,mu] = DMD( usol', u );

unorm_dmd = abs(u_dmd);


figure (2)
for j = 1:length(t)
    plot3(x,j*ones(1,n),unorm_dmd(:,j),'linewidth',2); hold on
end

ylabel('time')
xlabel('x')
zlabel('|u|')
title('DMD')
set(gca,'fontsize',20)


figure (3) 
muReal = real(mu); muImag = imag(mu);
% plot unit circle
angle = 0:0.01:2*pi;
radius = 1;
xcoord = radius*cos(angle);
ycoord = radius*sin(angle);
plot(xcoord,ycoord,'k-','linewidth',2); axis equal
hold on

plot(muReal,muImag,'bo','markerSize',12,'MarkerFaceColor','b')
axis equal 
set(gca,'fontsize',20)

figure (4)
u_modes =  real(u_modes)
for j = 1:size(u_modes,1)
    plot3(1:size(u_modes,2),j*ones(1,size(u_modes,2)),u_modes(j,:),'linewidth',2); hold on
end
set(gca,'fontsize',20)

