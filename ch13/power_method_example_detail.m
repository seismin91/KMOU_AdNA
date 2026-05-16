clear; close all; clc;

%% 1. Define a matrix
A = [2 1;
     1 2];

%% 2. Define initial vector
x = [1;
    0];

x = x / norm(x);
x_init = x;
maxIter = 10;
x_history = zeros(2, maxIter);
lambda_history = zeros(maxIter, 1);
angle_history = zeros(maxIter, 1);


%% 3. Compute true eigs
% ------------------------------------
[V, D] = eig(A);
eigvals = diag(D);

[eigvals, idx] = sort(eigvals, 'descend');
V = V(:, idx);

lambda_true = eigvals(1);
v_true = V(:, 1);
v_true = v_true / norm(v_true);

%% 4. Run Power method 

for k = 1:maxIter

    y = A * x;
    x = y / norm(y);

    lambda = x' * A * x;


    cos_angle = abs(dot(x, v_true) / (norm(x) * norm(v_true)));
    angle_error = acosd(cos_angle);

    x_history(:, k) = x;
    lambda_history(k) = lambda;
    angle_history(k) = angle_error;
end


%% 5. Display 1: Convergence on vector direction
% ------------------------------------
figure('Color','w','Position',[100 100 700 650]);
hold on; grid on; axis equal;


theta = linspace(0, 2*pi, 300);
plot(cos(theta), sin(theta), 'k--', 'LineWidth', 1);

% initial vector
quiver(0, 0, x_init(1), x_init(2), 0, ...
    'LineWidth', 3, 'MaxHeadSize', 0.5);


% dominant eigenvector 
quiver(0, 0, v_true(1), v_true(2), 0, ...
    'LineWidth', 3, 'MaxHeadSize', 0.5);

quiver(0, 0, -v_true(1), -v_true(2), 0, ...
    'LineWidth', 3, 'MaxHeadSize', 0.5);

% iterated vectors
for k = 1:maxIter
    xk = x_history(:, k);

    quiver(0, 0, xk(1), xk(2), 0, ...
        'LineWidth', 1.5, 'MaxHeadSize', 0.4);

    text(1.08*xk(1), 1.08*xk(2), sprintf('%d', k), ...
        'FontSize', 10);
end

xlabel('x_1');
ylabel('x_2');
title('Power Method: Convergence of Eigenvector Direction');

legend({'Unit circle', ...
    'Initial vector',...
        'Dominant eigenvector', ...
        'Opposite direction', ...
        'Power method iterates'}, ...
        'Location', 'best');

xlim([-1.2 1.2]);
ylim([-1.2 1.2]);


%% 6. Display 2: Convergence on estimated eigenvalue
figure('Color','w','Position',[200 200 700 400]);
hold on; grid on;

plot(1:maxIter, lambda_history, 'o-', 'LineWidth', 2);
yline(lambda_true, 'k--', 'LineWidth', 2);

xlabel('Iteration');
ylabel('Estimated eigenvalue');
title('Convergence of Dominant Eigenvalue');

legend({'Power method estimate', ...
        'True dominant eigenvalue'}, ...
        'Location', 'best');


%% 7. Display 3: Convergence on angle misfit
figure('Color','w','Position',[300 300 700 400]);
hold on; grid on;

semilogy(1:maxIter, angle_history, 'o-', 'LineWidth', 2);

xlabel('Iteration');
ylabel('Angle error [degree]');
title('Angle Error to Dominant Eigenvector');