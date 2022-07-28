function [Kp, Ti]= calc_pi_controller( K0, tau, xi, wn )
Kp=(2*xi*wn-1/tau)/(K0/tau)
Ti=K0*Kp/(wn*wn*tau)