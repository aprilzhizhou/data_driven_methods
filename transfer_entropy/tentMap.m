%% construct lattice

M = 100; % number of points 
N= 2*1e5; % number of iterations 
epsvec = 0.04; % epsilon list 
Tavgvec = []; % average transfer entropy list
tic
for eps = epsvec
    Tvec = [];
    for jj = 1 % averaging 10 runs 
        X = zeros(M,N);
        X(:,1)=  rand(M,1);
        for n = 1:N 
              % for m =1
                X(1,n+1) = ftent(eps*X(M,n) + (1-eps)*X(1,n)); %periodic
            for m = 2:M
                X(m,n+1) = ftent(eps*X(m-1,n) + (1-eps)*X(m,n));
            end
        end
        X = X(:,N/2:N); % remove transient steps 
        % consider only the first two points in the lattice 
        y = X(1,:); 
        x = X(2,:);
        
        T = 0; % transfer entropy 
        for ii=1:N/2-1
            [pjoint, pcond] = TransferEntropyProb(x', y', ii);
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
