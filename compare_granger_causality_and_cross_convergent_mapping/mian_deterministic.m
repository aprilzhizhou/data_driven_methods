%% lotka-verra system 

[x,y] = lotka1();

var1 = regression(y',x',1,1)
var2 = regression(y',x',1,0)

if var1 < var2
    fprintf('x is causing y.\n')
else
    fprintf('n/a\n')
end

var1 = regression(x',y',1,1)
var2 = regression(x',y',1,0)

if var1 < var2
    fprintf('x is causing y.\n')
else
    fprintf('n/a\n')
end