function [x,y] = ar_nonlinearGenerate(var, tMax)

x = var*randn(1)
y = var*randn(1)
for ii = 2: tMax
    x = [x var*randn(1)]; 
    y = [y x(ii-1)^2+var*randn(1)];  
end

end
