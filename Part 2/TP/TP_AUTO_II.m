% % Parametres 
% % Fonction qui définit la dynamique du pendule rotatif
% 
% % Etat et entrée du système
% alpha= inp(1);
% beta= inp(2);
% alpha_dot= inp(3);
% beta_dot= inp(4);
% u= inp(5);

% Points d'équilibre

alpha= 0;
beta= pi;
alpha_dot= 0;
beta_dot= 0;
u= 0;



%Paramètres physiques:
    %Moteur
    kt= 0.042;
    km= 0.042;
    Rm= 8.4;
    %Rotor
    mr = 0.095;
    Lr = 0.085;
    Jr= mr*Lr^2/12;
    cr= 15e-4;
    % Pendule
    mp= 0.024;
    Lp= 0.129;
    Jp= mp*Lp^2/12;
    cp= 5e-4 ;
%     
% %Calcul des matrices M, N, G et des couples moteurs
%  J1= Jr+mp*Lr^2;
% J2= Jp+mp*Lp^2/4;
% tau= -kt*(u+km*alpha_dot)/Rm;
% M= [J1+mp*Lp^2*sin(beta)^2/4 , mp*Lr*Lp*cos(beta)/2; mp*Lr*Lp*cos(beta)/2 , J2];
% N=( mp/2)*Lp*sin(beta)*[Lp*alpha_dot*beta_dot*cos(beta)-Lr*beta_dot^2;-Lp*alpha_dot^2*cos(beta)/2];
% G= [0;mp*9.81*Lp*sin(beta)];
% Couples= [tau-cr*alpha_dot;-cp*beta_dot];
% 
% % %Calcul de la sortie
% % angles_ddot= (inv(M))*(Couples-G-N);
% % out= [alpha_dot;beta_dot;angles_ddot];
% 
% %% Calcul de Axo et Bxo au points d'équilibre 
% 
% 
% 
% 
% 
% 
% 
% 
% %% Calcul de Axo et Bxo au points d'équilibre  et Pour chaque équilibre le systeme est il commandable ?
% 
% beta= 0 ; 
%     
%     M = [J1+mp*Lp^2*sin(beta)^2/4 , mp*Lr*Lp*cos(beta)/2; mp*Lr*Lp*cos(beta)/2 , J2] ; 
%     BxO =  -(inv(M))*[kt/Rm  ; 0];
%     Bxo = [0;0;BxO] ; 
% 
%     dG_dq = [0 ; mp*9.81*Lp*cos(beta)] ;  
%     I2 = eye(2,2) ; 
%     Inv = [ 0,0 ; (-inv(M)*dG_dq)']' ; 
% 
% 
%     Axo = [zeros(2,2) , I2 ; Inv , -inv(M)*[cr , 0 ; 0 , cp] ] ; 
%     
%     
%     display(Axo)
%     display(Bxo)
% 
%     
%     Rang = [Bxo , Axo*Bxo , (Axo.^2)*Bxo , (Axo.^3)*Bxo] ; 
% 
%     if rank(Rang) == 4 
%         disp("Le système est commandable") 
%         disp(" ")
% 
% 
%     elseif rank(Rang) ~= 4 
%         disp("Le système n'est pas commandable") 
%         disp(" ")
%     end 




Axo = [ 0 0 1 0 ; 0 0 0 1 ; 0 149 -17 4.91 ; 0 -262 16.8 -8.61] ; 
Bxo = [0 ; 0 ; -49.7 ; 49.1] ; 

Axp = [ 0 0 1 0 ; 0 0 0 1 ; 0 149 -17 -4.91 ; 0 262 -16.8 -8.61] ; 
Bxp = [0 ; 0 ; -49.7 ; -49.1] ; 

C = [ eye(2,2) zeros(2,2) ] ; 

e = 0.8 ; % Amortissement 
wa = 15*5 ; 
wb = 10*5 ; 

p = tf('p') ; 

Filtre_a = (p*wa^2)/(p^2 + 2*e*wa*p + wa^2) ; 
Filtre_b = (p*wb^2)/(p^2 + 2*e*wb*p + wb^2) ; 


% Question 7

poles = [ -10.01 ; -9 ; -11 ; -12] ; 
L = place(Axo' , C' , poles) ; % Placement de poles avec A et C transposées 
L = L' ; 
disp(L) ; 
eig(Axo - L*C)

% x tilde point = (A - LC)*x tilde  ; avec L*C = B 
A_c  = Axo - L*C ; % A chapeau
B_c = [L  Bxo] ; 

Q1=eye(4,4);
R=1;
Q2= eye(4,4) ; 
Q2(2,2) = 30 ; 

K1  = lqr(Axo , Bxo , Q1 , R) ; 
K2 = lqr(Axo , Bxo , Q2 , R) ; 
  