%% Dynamic control of a MEMS active force sensor

% We first begin by define all the variables and function transfert needed

p = tf('p'); % Laplace Variable 
ke = 0.3  ; %N/V
m = 7.85 * 1e-9 ;  % kg :  mass of the moving part of the MEMS.
v = 5 *1e-6 ;  % N/ms: damping factor.
k = 1.5 ; % N/m : stiffness of the flexible structure

Kamp = 10 ;  % linear amplifier of gain
G = ke/ (m*p^2 + v*p + k) ; % System transfert function 

% We'll use minreal when comes to multiply two transfert functions or
% calculate the open loop transfert function 

%% I/ Study of the non-forced sensor: -study of the system with an input U0 and an output Y for Fext = 0

%0.1.1 System definition in Matlab
% In this section, we consider Fext = 0.

Gc = Kamp * G ; 
display(Gc)



% 0.1.2 Calculation of poles, zeros and static gain

% 1/ and 2/  



damp(Gc) 

display(dcgain(Gc)) ;  % Equal to 2 


% 2 poles avec une partie imaginaire (complexe conjugués) , Re[poles] < 0 
% ==> (Marginalement) stable 


% The damping factor is << 1  ( and > 0 to avoid divergence ) , thus the
% system is resonnant but the step response will still exhebit
% oscillations

% So the complex parts of the poles show a presence of oscillations , so we
% have to consider their imaginary part to have a value : 1.38e+04rad/s 


% 3 /  lim Gs(t) = p[u(p)*]Gc(p) = 3/1.5 = 2 (when p--> 0 and t --> +oo ) 



% 0.1.3 Calculation and plotting of temporal responses

% Impulse 

figure(1) 
impulse(Gc)
title("Impulse response for G")
grid on 


% La réponse impulsionelle converge vers une valeur finie lorsque t -->
% infini 
% Le systeme est dit marginalement stable 


% Step 
figure(2)
step(Gc,'r') 
title("Step response for G")
grid on 

% Overshoot = 93% 
% settling time : 0.00933 seconds 
% Steady state value == 2 as predicted 
% Pulsation of the oscillations : sqrt(k/m) = 1.38e+04 rad/s (as predicted)


% these measurements are consistent with the values of the poles and the static gain calculated previously


% 0.1.4 Bode diagram

figure(3)
bode(Gc) 
grid on() 

% Resonnance : 1.38*1e4 ; 32.8 dB 

% At low frequencies : 6.09 dB 

% static gain calculated : 2 ; thus 20Log(2) = 6.02 

G_145 = freqresp (Gc , 1.45*1e4) ; 
Gain_145 = 20*log10( abs(G_145)) ; 
disp('the value of the gain (in dB)of Gc(s) at the pulse 1.45e+04 rad/s.');  disp(Gain_145) ;

disp('value of the phase (in rad/s) of Gc(s) at the pulse 1.45e+04 rad/s');  Phase_145 = angle(G_145) ; disp(Phase_145) ; disp(" rad/s")

% Margin : 
margin(Gc) 
grid on() 
% Phase margin =  2.29*1e4 rad/s 
% Gain margin = inf 
% WodB = 2.39*1e4
% W(-180) = inf 



%% 0.2 Study of the forced sensor: -study of the system with the input U0 and the output Y for Fext different of 0 

% The maximum electrical voltage applicable on the actuator is U = 200V


% With pic3 , we consider y = 0 

% G*( U - (Fext)/ke ) = y = 0 

% so 

% Fext Max Measured = 60 N 


%% 0.3 Dynamic force measurement: -Dynamic control


% static error in steady state equal to zero, i.e. y(t) = yref = 0 in steady state.
% Phase margin of the corrected open loop Fbo(s) = C(s)Gc(s) equal to pi/4 in order to reduce the vibrations of the probe.
% Pulse Wodb of the corrected open loop Fbo(s) sufficient for a force measurement at 1 kHz.

% On prend W0db = 
f = 4000; % 8KHz
wodb = 2*pi*f ; 
% Justification : 
% 
M = pi/4 ; % Marge de phase voulue 
Tau_c = 1/wodb*tan(-(pi/2)-(M - pi)) ; % Expression generale 
Kc = (wodb * sqrt ( 1 + (Tau_c*wodb).^2))/(Kamp*ke) ; 
% % Correcteur 
C = Kc*(m*p^2 + v*p + k)/(p*(1+ Tau_c*p)) ; 

%Check 
FTBO = minreal(C*Gc) ; 
margin(FTBO) 
grid on()

% Parametres de Fext 
A = 15*1e-6 ; % 15 µN 
F = 1e3 ; % 1KHz
W = 2*pi*F ; 



% Reponse indicielle sans perturbations 
BF = minreal(FTBO/(1+FTBO)) ; 
step(BF)
grid on


nyquist(BF)
grid on 

Fs = 1e6 ; 
Ts = 1/Fs ; 



% Marge de gain : 
% Valeur du gain à la pulsation w - pi 