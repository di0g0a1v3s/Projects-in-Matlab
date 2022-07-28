function [mag, arg]= calc_mag_and_arg( a, b )
x= a+b*i;
mag= abs(x);
arg= angle(x);
