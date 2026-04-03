function [fx, ea, iter] = IterMeth(x,ea,maxit)
% Maclaurin series of exponential function
% [fx,ea,iter] = IterMeth[x,es,maxit]
% input:
% x = value at which series evaluated
% es = stopping criterion (default=0.0001)
% maxit = maximum iterations (default = 50)
% output:
% fx = estimated value
% ea = approximate relative error (%)
% iter = number of iterations

% defaults:
if nargin<2 | isempty(es), es=0.0001; end
if nargin<3 | isempty(maxit), maxit=50; end

% initialization
iter = 1; sol = 1; ea = 100;

% iterative calculation
while (1)
    solold = sol;
    sol = sol + x^iter / factorial(iter);
    iter = iter + 1;
    if sol ~= 0
        ea = abs((sol - solold)/sol)*100;
    end
    if ea <= es | iter >= maxit, break, end
end
fx = sol;
end