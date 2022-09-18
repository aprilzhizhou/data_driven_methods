% space 
L= 40; 
n = 512; 
x2 = linspace(-L/2,L/2,n+1); x = x2(1:n);
k = (2*pi/L)*[0:n/2-1 -n/2:-1].';
slices =20;
t=linspace(0,2*pi,slices+1); dt = t(2) - t(1);

u = 2*sech(x).';
ut = fft(u);
[t,utsol] = ode45('nls_rhs',t,ut,[],k);
for j = 1:length(t)
    usol(j,:) = ifft(utsol(j,:));
end

figure (1)
unorm = abs(usol);
for j = 1:length(t)
    plot3(x,j*ones(1,n),unorm(j,:),'linewidth',2); hold on
end

ylabel('time')
xlabel('x')
zlabel('|u|')
title('PDE')
set(gca,'fontsize',20)
