
%% LINEAR SYSTEM

% MASS - SPRING SYSTEM 

m = 0.1 ; 
lambda = 0 ; 
k = 0.1 ; 
% freq = w / 2*pi
% T = 2*pi / w 

% STATE MATRICES

A = [0 1 ; -k/m -lambda/m] ; 
B = [0 ; 1/m] ; 
C = [1 0];
D = 0 ; 

step(ss(A,B,C,D)) ; 
%%

