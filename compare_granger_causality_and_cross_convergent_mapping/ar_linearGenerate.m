function [x,y] = ar_linearGenerate(var, tMax)

x = randn(1); y = randn(1);
for ii = 2: tMax
    x = [x var*randn(1)]; 
    y = [y x(ii-1)+var*randn(1)];  
end

end
