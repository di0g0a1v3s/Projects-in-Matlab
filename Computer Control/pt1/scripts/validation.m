clear
clc
close all
warning('off')
load('ssfinal.mat');
load('barrassmodel.mat');
T = 120;
f = 0.4;
fs= 100;
t = (0:1/fs:T)';
%u=1*t;
%u=0*t+1;
%u=0*t;u(1000)=1;
%u = idinput(length(t),'prbs',[0 0.01]);
%u = sin(2*pi*f*t);
u = square(2*pi*f*t);
%u=sawtooth(t,1);
sim('SYS');
us = simout.signals.values(:,2);
ys = simout.signals.values(:,1);
ts = simout.time;

figure();
h=bodeplot(ss(Atrue,Btrue,Ctrue,Dtrue),ss(A,B,C,D,1/fs));
p = getoptions(h); 
p.PhaseMatching = 'on'; 
p.PhaseMatchingFreq = 1; 
p.PhaseMatchingValue = 0;
setoptions(h,p);
legend('Sistema Real', 'Modelo');

figure();
pzmap(ss(A,B,C,D,1/fs));


ysim = dlsim(A,B,C,D, us); 


figure();
hold on;
gg=plot(ts,ys,'b');
set(gg,'LineWidth',1.5);
gg=plot(ts,ysim,'r');
set(gg,'LineWidth',1.5);
hold off;
legend('Sistema Real', 'Modelo');
title('Saída do modelo e do sistema real a um sinal quadrado com f=0.4Hz');
