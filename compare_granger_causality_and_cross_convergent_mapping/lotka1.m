function [Y1,Y2 ] = lotka1()
type lotka
t0 = 0;
tfinal = 40;
y0 = [20; 20];   
% [t,y] = ode23(@lotka,[t0 tfinal],y0);
% 
% 
% plot(t,y)
% title('Predator/Prey Populations Over Time')
% xlabel('t')
% ylabel('Population')
% legend('Prey','Predators','Location','North')

Nstep = 10000;
dt = (tfinal-t0)/Nstep;
Y = zeros(2,Nstep);
Y(:,1) = y0;
for ii = 1:Nstep
t = t0 + dt;
y1 = y0 + dt*lotka(t,y0);
Y(:,ii) = y1;
y0 =  y1;
end
% Y = Y + var*randn(size(Y));

Y1 = Y(1,:);
Y2 = Y(2,:);
figure (1)
plot(Y1,Y2,'-');
title('Phase Plane Plot')

end