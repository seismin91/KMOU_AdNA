clear; close all; clc;

%% 1. Define a matrix
A = [2 1;
     1 2];

%% 2. Define initial vector
x = [1;
     0];

x = x / norm(x);

maxIter = 20;

lambda_history = zeros(maxIter, 1);
x_history = zeros(2, maxIter);


%% 3. Do power method
for k = 1:maxIter

    y = A * x;

    % normalize
    x = y / norm(y);

    % estimate eigenvalue
    lambda = x' * A * x;

    % 저장
    lambda_history(k) = lambda;
    x_history(:, k) = x;

    fprintf('iter %2d: lambda = %.8f, x = [%.8f, %.8f]^T\n', ...
        k, lambda, x(1), x(2));
end


%% 4.comparison with matlab function 

[V, D] = eig(A);
eigvals = diag(D);

[eigvals_sorted, idx] = sort(eigvals, 'descend');
V = V(:, idx);

lambda_true = eigvals_sorted(1);
v_true = V(:, 1);

% adjut sign for direciton comparison
if dot(x, v_true) < 0
    v_true = -v_true;
end

fprintf('\nTrue dominant eigenvalue = %.8f\n', lambda_true);
fprintf('True dominant eigenvector = [%.8f, %.8f]^T\n', ...
    v_true(1), v_true(2));
