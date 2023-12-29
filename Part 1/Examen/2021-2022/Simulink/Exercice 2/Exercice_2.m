Km = 0.8 ; 
tau_m = 0.5 ; 
J = 3 ; 
p = tf('p') ; 
e = 0.01 ; 

%% Fonctions de transfert 
H1 = Km / ( 1 + tau_m*p) ; 
H2 = 1 / (J*p) ; 
%% FEED-FORWARD
filtre = (1/(1 + e*p));  % pour assurer l'inversion 
H1_inv = H1^-1 ; % Pour l'action d'anticipation
G = minreal(H1_inv*filtre) ; 

%% DOB
Kq = 1 ; 
Q = Kq/( 1 + e*p) ; % LOW PASS FILTER
H2_inv = minreal(H2^-1*filtre) ; % Pour le DOB 