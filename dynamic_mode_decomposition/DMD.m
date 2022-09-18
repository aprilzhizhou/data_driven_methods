function [ u_dmd,u_modes,mu] = DMD( usol, uinit )


n = size(usol,1);
t=1:size(usol,2);
dt = t(2) - t(1);

X =  usol; X1 = X(:,1:end-1); X2 = X(:,2:end);
[U,Sigma,V]  = svd(X1,'econ');

S=  U'*X2*V*diag(1./diag(Sigma));
[eV,D] = eig(S);
mu = diag(D);
omega = log(mu)/(dt);
Phi = U*eV;
y0 = Phi\uinit; % pseudo-invese initial condition
u_modes = zeros(length(y0),length(t));

for iter = 1:length(t)
    u_modes(:,iter) = (y0.*exp(omega*t(iter)));
end
u_dmd = Phi*u_modes;

end

