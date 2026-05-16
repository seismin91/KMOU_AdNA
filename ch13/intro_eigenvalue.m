clear; close all; clc;

%% 1. Define matrix A
A = [2 1;
     1 2];

%% 2. Compute Eigenvalues and Eigenvectors of A
[V, D] = eig(A);


% Normalize eigenvectors
for i = 1:size(V,2)
    V(:,i) = V(:,i) / norm(V(:,i));
end


%% 3. Define arbitrary vectors (in this example, we set vectors on unit circle
% Define unit circle
theta = linspace(0, 2*pi, 401);

circle = [cos(theta);
          sin(theta)];

% Apply matrix A to unit circle
ellipse = A * circle;


%% 4. Select a arbitrary vector on unit circle
% A vector
rad = pi / 2.5;
x = [sin(rad);
     cos(rad)];

% Apply A to this vector
Ax = A * x;

%% 5. Display 
figure('Color','w','Position',[100 100 1200 550]);

% 5.1 Left figure
subplot(1,2,1);
hold on; grid on; axis equal;

plot(circle(1,:), circle(2,:), 'k-', 'LineWidth', 1.5);

% x and y axes
hx = xline(0, 'k-', 'LineWidth', 0.8);
hy = yline(0, 'k-', 'LineWidth', 0.8);

hx.HandleVisibility = 'off';
hy.HandleVisibility = 'off';

% A arbitrary vector x
quiver(0, 0, x(1), x(2), 0, ...
    'LineWidth', 2, 'MaxHeadSize', 0.5);

% eigenvectors
for i = 1:2
    v = V(:,i);

    quiver(0, 0, v(1), v(2), 0, ...
        'LineWidth', 2, 'MaxHeadSize', 0.5);

    % 반대 방향도 표시
    quiver(0, 0, -v(1), -v(2), 0, ...
        'LineWidth', 1.5, 'MaxHeadSize', 0.5);
end

title('Original space', 'FontSize', 14);
xlabel('x_1'); ylabel('x_2');

xlim([-2 2]); ylim([-2 2]);

legend({'Unit circle', ...
        'General vector x', ...
        sprintf('Eigenvector v_1, \\lambda = %.1f', V(1)), ...
        '-v_1', ...
        sprintf('Eigenvector v_2, \\lambda = %.1f', V(2)), ...
        '-v_2'}, ...
        'Location', 'northwest');


% 5.2 Right figure
subplot(1,2,2);
hold on; grid on; axis equal;

plot(ellipse(1,:), ellipse(2,:), 'k-', 'LineWidth', 1.5);

% x and y axes
hx = xline(0, 'k-', 'LineWidth', 0.8);
hy = yline(0, 'k-', 'LineWidth', 0.8);

hx.HandleVisibility = 'off';
hy.HandleVisibility = 'off';

% transformed vector
quiver(0, 0, Ax(1), Ax(2), 0, ...
    'LineWidth', 2, 'MaxHeadSize', 0.5);

% transformed eigenvectors A v = lambda v
for i = 1:2
    v = V(:,i);
    Av = A * v;

    quiver(0, 0, Av(1), Av(2), 0, ...
        'LineWidth', 2, 'MaxHeadSize', 0.5);

    t = linspace(-4, 4, 100);
    line_points = v * t;

    plot(line_points(1,:), line_points(2,:), '--', 'LineWidth', 1.2);
end

title('After applying A', 'FontSize', 14);
xlabel('x_1');
ylabel('x_2');

xlim([-4 4]);
ylim([-4 4]);

legend({'Transformed circle', ...
        'A x', ...
        'A v_1 = \lambda_1 v_1', ...
        'Direction of v_1', ...
        'A v_2 = \lambda_2 v_2', ...
        'Direction of v_2'}, ...
        'Location', 'northwest');

sgtitle('Meaning of Eigenvalues and Eigenvectors', 'FontSize', 16);