clc; clear;

x = 0.5;
niter = 100;
Ea = 999999.;



for iter = 0:niter
    x_old = x;

    if iter>=1
        func_prime = 10 * x^9; 
        func = x^10 - 1;
        x = x - (func/func_prime);
        
        if iter >=1
            Ea = abs((x - x_old)/x)*100;
        end
        
    end
    fprintf('Iter = {%d} | Sol= {%f} | Ea = {%f} \n',iter, x, Ea)
end