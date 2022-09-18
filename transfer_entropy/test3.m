%% construct lattice

M = 100; % number of points 
N= 2*1000; % number of iterations 
epsvec = 0.01:0.01:0.05; % epsilon list 
Tavgvec = []; % average transfer entropy list
tic
for eps = 0.01:0.01:0.05
    Tvec = [];
    for jj = 1:10 % averaging 10 runs 
        xold =  rand(M,1);
        x1 = xold(1); x2 = xold(2);
        for n = 1:N 
              % for m =1
                xnew(1) = ftent(eps*xold(M) + (1-eps)*xold(1)); %periodic
            for m = 2:M
                xnew(m) = ftent(eps*xold(m-1) + (1-eps)*xold(m));
            end
            x1 = [x1 xnew(1)]; x2 = [x2 xnew(2)];
            xold = xnew; 
        end
        
        x1 = x1(N/2:end); x2 = x2(N/2:end); % remove transient steps 
        
        T = 0; % transfer entropy 
        for ii=1:N/2-1
            [pjoint, pcond] = TransferEntropyProb(x2, x1, ii);
            T = T + pjoint*log(1/pcond);
        end
        Tvec =[Tvec T];
    end
    Tavg = mean(Tvec); % compute average 
    disp(Tavg) 
    Tavgvec = [Tavgvec Tavg];
end
toc

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
