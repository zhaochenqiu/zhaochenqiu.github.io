clear all
close all
clc

A = rand(4,4);
X = rand(10,4);

Y = X*A;

% X = U * S * V^T
[U S V] = svd(X);

% A = X^+ Y
% X^+ = V S^+ U^T
S_ = S;
idx = S_ > 0.00000001;
S_(idx) = 1 ./ S_(idx);

A_ = V * S_' * U' * Y;

Y_ = X*A_;

sum(sum(Y_ - Y))


