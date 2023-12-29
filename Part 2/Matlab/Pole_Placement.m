clc

% State Matrices 
A = [ 0 1 ; 2 -1  ] ; 
%display(A) ;
B = [1 ; 0] ; 
C = [1 0]; 
D = 0 ;

% Create state space object 
sys = ss(A, B, C, D) ; 
% display(sys) ; 

% Open Loop eigenvalues
E = eig(A) ; 
display(E) ; 

% Open Loop step response 
figure(1)
step(sys ,'r') ; 
title('Open Loop step response')  ;
grid on;  

% Desired poles
P = [-2 -1]; 

% Solve for K using pole placement 
K = place(A,B,P) ; 
display(K) ; 

% Closed Loop eigenvalues
A_star = A - B*K ; 
E_cl = eig(A_star) ; 
display(E_cl) ; 

% Closed Loop step response 

sys_cl = ss(A_star, B, C, D) ; 
figure(2)
step(sys_cl ,'b') ; 
title('Closed Loop step response') ; 
grid on;  

% For steady state error 
kr = 1/ dcgain(sys_cl) ; 

sys_cl_scaled = ss(A_star, B*kr, C, D); 
figure(3)
step(sys_cl_scaled ,'g') ; 
title('Closed Loop step response') ; 
grid on;  




