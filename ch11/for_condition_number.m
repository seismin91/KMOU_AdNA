%% Condition number 이해하기
clc; clear;
n = 3;
x = randn(n,1);
perc = 0.01;

example = 1; % 1: 'ideal case', 2: 'bad case' ;


if example == 1
    
    
    %% 1. Ideal case: A가 단위행렬
    A = eye(n, n);
    
    b = A * x;
    
    noise = randn(size(b));
    noise = noise / norm(noise);
    
    b_n = b + perc * noise;
    
    x_n = inv(A) * b_n;
    
    
    % Calculate the error ratios for the solution and the right-hand side
    error_ratio_x = norm(x_n - x) / norm(x);
    error_ratio_b = norm(b_n - b) / norm(b);
    
    
    fprintf("For ideal case, A is identity matrix \n")
    fprintf("||dX||/||x|| :  %f \n", error_ratio_x);
    fprintf("||db||/||b|| :  %f \n", error_ratio_b);


elseif example == 2
        
    
    %% 2. Ill-conditioned case: A는 Hilbert matrix 
    
    A = [1 1/2 1/3; 1/2 1/3 1/4; 1/3 1/4 1/5];
    
    b = A * x;
    
    noise = randn(size(b));
    noise = noise / norm(noise);
    
    b_n = b + perc * noise;
    
    x_n = inv(A) * b_n;
    
    
    % Calculate the error ratios for the solution and the right-hand side
    error_ratio_x = norm(x_n - x) / norm(x);
    error_ratio_b = norm(b_n - b) / norm(b);
    
    
    fprintf("For bad case, A is ill-conditioned (Hilbert matrix) \n")
    fprintf("||dX||/||x|| :  %f \n", error_ratio_x);
    fprintf("||db||/||b|| :  %f \n", error_ratio_b);

else
    
    fprintf("Choose one case for this test. 1: ideal case, 2: bad case \n")
    fprintf("------------------------------------------------ \n");
end
