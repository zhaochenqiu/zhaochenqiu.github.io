clear all
close all
clc

mat = rand(3,3);

mat = mat * mat';

[U S] = eig(mat);

mat = U*S*U'


U(:, 2) = U(:, 3);
S(2, 2) = S(3, 3);

newmat = U*S*U'

[U S] = eig(newmat)
