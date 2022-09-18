%% construct lattice

M = 100; % number of points 
N = 1000; % number of iterations 
epsvec = 0.02; % epsilon list 
Tavgvec = []; % average transfer entropy list 
for eps = epsvec
    Tvec = [];
    for jj = 1 % averaging 10 runs 
        xold = rand(M,1);
        x1 = zeros(1,N+1); x2 = zeros(1,N+1);
        x1(1) = xold(1); x2(1) = xold(2);
        for n =1:N
                xnew(1) = ftent(eps*xold(M) + (1-eps)*xold(1));
            for m=2:M
                xnew(m) = ftent(eps*xold(m-1) + (1-eps)*xold(m));
            end
            x1(n+1) = xnew(1); x2(n+1) = xnew(2); % record first two points 
            xold = xnew; 
        end
        x1 = x1(N/2:N);
        x2 = x2(N/2:N); % remove transient steps 
        
        T = 0; % transfer entropy 
        for i=1:length(x1)-1
            [pjoint, pcond] = TransferEntropyProb(x2, x1, i);
            T = T + pjoint*log(1/pcond);
        end
        Tvec =[Tvec T];
    end
    Tavg = mean(Tvec); % compute average 
    disp(Tavg) 
    Tavgvec = [Tavgvec Tavg];
end
% plot 
plot(epsvec,Tavgvec)

% define map 
function y = ftent(x)
if x < 0.5
    y = 2*x;
else
    y = 2-2*x;
end
end
