tic
epsvec = 0:0.01:0.05;
Tvec1 =  [];
for eps = epsvec
    N = 5000;
    Tvec2 = [];
    for ii = 1:10
        x = zeros(N,1);
        y = zeros(N,1);
        x(1) = rand;
        y(1) = rand;
        for i=2:N
            x(i) = ftent(eps*y(i-1) + (1-eps)*x(i-1));
            y(i) = rand;
        end
        x = x(N/2:N);
        y = y(N/2:N);
        T = 0;
        
        
        for i=1:N/2-1
            [pjoint, pcond] = TransferEntropyProb(x, y, i);
            T = T + pjoint*log(1/pcond);
        end
    end
    Tvec2 = [Tvec2 T];
    Tmean = mean(Tvec2);
    disp(Tmean)
    Tvec1 = [Tvec1 Tmean];
end

plot(epsvec,Tvec1)

toc
function y = ftent(x)
if x < 0.5
    y = 2*x;
else
    y = 2-2*x;
end
end
