clc; clear;

x = 0;
niter = 10;
Ea = 999999.;
for iter = 0:niter
    x_old = x;

    if iter>=1
        x = exp(-x);
    
        if iter >=1
            Ea = abs((x - x_old)/x)*100;
        end
        
    end
    fprintf('Iter = {%d} | Sol= {%f} | Ea = {%f} \n',iter, x, Ea)
end