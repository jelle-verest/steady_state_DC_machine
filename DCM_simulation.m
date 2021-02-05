%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% author: J.N.G.W. Verest   %
% Title: DCM simulation     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


close all
clear
clc

%% constants
% these are to be measured/calculated/found beforehand

R_a     = 1;    % armature resistance [Ohm]
R_f     = 100;  % field resistance [Ohm]
KPhi    = 1;    % motor constant [Vs/rad]


%% simulation parameters
% one or more of these variables may be swept over. In this case, armature
% current I_a is used.

V_f     = 230;          % field voltage [V]
V_a     = 230;          % armature voltage [V]
I_a     = -10:0.01:10;  % armature current [A]

%% simulation

E_f     = V_a - I_a * R_a;
T_d     = KPhi * I_a;
W_m     = E_f / KPhi;

% create efficiency vector
eff     = zeros(size(I_a));
M_c     = (I_a > 0);    % motor condition
G_c     = (I_a < 0);    % generator condition
eff(M_c) = T_d(M_c) .* W_m(M_c) ./ (V_a * I_a(M_c) + V_f^2 / R_f);
eff(G_c) = V_a * I_a(G_c)./ (T_d(G_c) .* W_m(G_c) + V_f^2 / R_f);

eff(eff<0) = 0;

%% Plots

Ia_eff = figure();
plot(I_a,100 * eff);
grid on
xlabel("armature current I_a [A]")
ylabel("efficiency \eta [%]")
ylim([0 100])