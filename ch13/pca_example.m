clear; close all; clc;

%% 1. Generate 2D data
% ------------------------------------
rng(1);

N = 300;

% random and independent data
Z = randn(N, 2);

% data preconditioning to make them more longer
A = [3 1.5;
     1 1];

X = Z * A';

% eliminate the average of data
mu = mean(X, 1);
X_centered = X - mu;



figure('Color','w','Position',[100 100 700 650]);
hold on; grid on; axis equal;

% 데이터 산점도
scatter(X_centered(:,1), X_centered(:,2), 25, 'filled', ...
    'MarkerFaceAlpha', 0.4);

xlabel('x_1');
ylabel('x_2');
title('Dataset');






%% 2. Compute covariance matrix
C = cov(X_centered);

%% 3. Eigenvalue analysis of covariance matrix

[V, D] = eig(C);

eigvals = diag(D);

% Sort them as descending order
[eigvals, idx] = sort(eigvals, 'descend');
V = V(:, idx);

% Primary and secondary principal components
v1 = V(:, 1);
v2 = V(:, 2);

lambda1 = eigvals(1);
lambda2 = eigvals(2);



%% 4. Display

figure('Color','w','Position',[100 100 700 650]);
hold on; grid on; axis equal;


scatter(X_centered(:,1), X_centered(:,2), 25, 'filled', ...
    'MarkerFaceAlpha', 0.4);


plot(0, 0, 'ko', 'MarkerSize', 8, 'LineWidth', 2);


scale = 2;

pc1 = scale * sqrt(lambda1) * v1;
pc2 = scale * sqrt(lambda2) * v2;


quiver(0, 0, pc1(1), pc1(2), 0, ...
    'LineWidth', 3, 'MaxHeadSize', 0.5);


quiver(0, 0, pc2(1), pc2(2), 0, ...
    'LineWidth', 3, 'MaxHeadSize', 0.5);


quiver(0, 0, -pc1(1), -pc1(2), 0, ...
    'LineWidth', 3, 'MaxHeadSize', 0.5);

quiver(0, 0, -pc2(1), -pc2(2), 0, ...
    'LineWidth', 3, 'MaxHeadSize', 0.5);

xlabel('x_1');
ylabel('x_2');
title('PCA: Eigenvectors of the Covariance Matrix');

legend({'Data', 'Mean', ...
        '1st principal component', ...
        '2nd principal component'}, ...
        'Location', 'best');

fprintf('Covariance matrix C = \n');
disp(C);

fprintf('Eigenvalues:\n');
fprintf('lambda1 = %.4f\n', lambda1);
fprintf('lambda2 = %.4f\n', lambda2);

fprintf('Explained variance ratio:\n');
fprintf('PC1: %.2f %%\n', 100 * lambda1 / sum(eigvals));
fprintf('PC2: %.2f %%\n', 100 * lambda2 / sum(eigvals));




%% 5. Reduce dimensionality of dataset from 2D to 1D via PCA projection
% Project to primary principal axis
Z_1D = X_centered * v1;

% Reconstruct 1D dataset to 2D space
X_reconstructed = Z_1D * v1';



%% 6. Explained variance ratio
explained_PC1 = lambda1 / sum(eigvals);
explained_PC2 = lambda2 / sum(eigvals);

fprintf('Eigenvalues:\n');
fprintf('lambda1 = %.4f\n', lambda1);
fprintf('lambda2 = %.4f\n\n', lambda2);

fprintf('Explained variance ratio:\n');
fprintf('PC1 = %.2f %%\n', 100 * explained_PC1);
fprintf('PC2 = %.2f %%\n\n', 100 * explained_PC2);


%% 7. Display : Original data and projected data
figure('Color','w','Position',[100 100 750 650]);
hold on; grid on; axis equal;

% original 2D data
scatter(X_centered(:,1), X_centered(:,2), 25, 'filled', ...
    'MarkerFaceAlpha', 0.25);

% 1D 
scatter(X_reconstructed(:,1), X_reconstructed(:,2), 25, 'filled');

% direction ofprimary principal axis
t = linspace(min(Z_1D), max(Z_1D), 100);
pc1_line = t' * v1';

plot(pc1_line(:,1), pc1_line(:,2), 'k-', 'LineWidth', 2.5);

step = 15;
for i = 1:step:N
    plot([X_centered(i,1), X_reconstructed(i,1)], ...
         [X_centered(i,2), X_reconstructed(i,2)], ...
         'k--', 'LineWidth', 0.8);
end

xlabel('x_1');
ylabel('x_2');
title('PCA Dimensionality Reduction: 2D to 1D');

legend({'Original 2D data', ...
        'Projected data on PC1', ...
        '1D PCA axis', ...
        'Projection lines'}, ...
        'Location', 'best');


%% 8. Display : true 1D coordinate
% ------------------------------------
figure('Color','w','Position',[200 200 800 300]);
hold on; grid on;

scatter(Z_1D, zeros(size(Z_1D)), 30, 'filled', ...
    'MarkerFaceAlpha', 0.5);

xlabel('1D PCA coordinate, z');
yticks([]);
title('Reduced 1D Data');


%% 8. Display : comparison of original data and 1D reconstructed data

figure('Color','w','Position',[300 100 1200 500]);

subplot(1,2,1);
hold on; grid on; axis equal;
scatter(X_centered(:,1), X_centered(:,2), 25, 'filled', ...
    'MarkerFaceAlpha', 0.4);
xlabel('x_1');
ylabel('x_2');
title('Original 2D Data');

subplot(1,2,2);
hold on; grid on; axis equal;
scatter(X_reconstructed(:,1), X_reconstructed(:,2), 25, 'filled', ...
    'MarkerFaceAlpha', 0.6);
xlabel('x_1');
ylabel('x_2');
title('Reconstructed from 1D PCA');