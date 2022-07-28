%%
clear
clc
close all
warning('off')
load('ssfinal.mat');
load('barrassmodel.mat');


%----Regulador Linear Quadrático----
T = 120;
f = 0.04;
fs= 100;
G = ss(A,B,C,D,1/fs);
t = (0:1/fs:T)';
%u = square(2*pi*f*t);
%u = sawtooth(2*pi*f*t);
%u = sin(2*pi*f*t);
u = 0*t;
u(100:900)=1;


%Botões de Ajuste
Q = C.'* C;
R = 10;

[K,S,p] = dlqr(A,B,Q,R)


%Simulação
clear simout
sim('SystemModelLQR');
us = simout.signals.values(:,2);
ys = simout.signals.values(:,1);
ts = simout.time;
ysim = dlsim(A,B,C,D, us); 

figure();
hold on;
gg=plot(ts,us,'r');
set(gg,'LineWidth',1.5);
gg=plot(ts,ys,'b');
set(gg,'LineWidth',1.5);
grid on;
%xlim([0,40]);
legend('Input','Sinal Controlado')
hold off
title('LQR')


%Localização dos pólos e zeros através dos valores próprios
figure();
ss_var = ss(A-B*K,B,C,D,1/fs); 
%Cálculo da margem de ganho e margem de fase
[Gm,Pm,Wcg,Wcp] = margin(ss_var)

%Diagrama de Bode do LQR
hold on 
bode(ss_var); 
hold off
title('Bode LQR')


%simetrico de root locus
[num,den] = tfdata(G, 'v');
[num,den] = eqtflength(num,den);
symmetric = tf(conv(num,fliplr(num)),conv(den,fliplr(den)));
figure();
hold on
rlocus(symmetric);
xlim([-2, 2]);
ylim([-2, 2]);
title('Simétrico de Root Locus - LQR')
hold off 

%Ritmo de decaimento
figure();
hold on;
plot(log10(abs(ys)))
xlim([0,2000])
grid on;
hold off ;
title('Ritmo de Decaimento LQR')
r_decaimento_lqr = log10(abs(p))
%%

%----Estimador Linear Quadrático Tipo 1 ----
qE = 500;
QE = eye(size(A))*qE;
RE = 1;
B1 = eye(size(A));

[M,P,Z,EE] = dlqe(A,B1,C,QE,RE);

clear simout
sim('SystemModelLQE');
us = simout.signals.values(:,size(simout.signals.values,2));
xs = simout.signals.values(:,1);
ts = simout.time;

figure();
hold on;
gg=plot(ts,us,'r');
set(gg,'LineWidth',1.5);
gg=plot(ts,xs);
set(gg,'LineWidth',1.5);
grid on;
legend('Input', 'Diferença entre Estados');
hold off;
title('LQE 1')

%Ritmo de decaimento
figure();
hold on;
plot(log10(abs(xs)))
xlim([0,2000])
grid on;
hold off ;
title('Ritmo de Decaimento LQE 1')
r_decaimento_lqe1 = log10(abs(EE))
%----Estimador Linear Quadrático Tipo 2 ----
rhoE = 0.01;
QE = 1;
RE = 1/rhoE;
B1 = B;

[M,P,Z,EE] = dlqe(A,B1,C,QE,RE);

clear simout
sim('SystemModelLQE');
us = simout.signals.values(:,size(simout.signals.values,2));
xs = simout.signals.values(:,1);
ts = simout.time;

figure();
hold on;
gg=plot(ts,us,'r');
set(gg,'LineWidth',1.5);
gg=plot(ts,xs);
set(gg,'LineWidth',1.5);
grid on ;
legend('Input','Sinal Descontrolado')
hold off;
title('LQE 2')

%Ritmo de decaimento
figure();
hold on;
plot(log10(abs(xs)))
grid on;
hold off ;
title('Ritmo de Decaimento LQE 2')
r_decaimento_lqe2 = log10(abs(EE))

%simetrico de root locus
ss_var = ss(A-B1*K,B1,C,D,1/fs); 
[num,den] = tfdata(ss_var, 'v');
symmetric = tf(conv(num,fliplr(num)),conv(den,fliplr(den)));
figure();
hold on
rlocus(symmetric);
zplane([],[]);
xlim([-2, 2]);
ylim([-2, 2]);
title('Simétrico de Root Locus - LQE2')
hold off 



%----Controlador Linear Quadrático Gaussiano / Modelo  ----


%Calculo de Nbar
N = inv([A-eye(size(A)), B; C,0])*[zeros(size(A,1),1);1];
Nx = N(1:end-1,:);
Nu = N(end,:);
Nbar = Nu+K*Nx;

clear simout
sim('SystemModelControlled');
us = simout.signals.values(:,2);
ys = simout.signals.values(:,1);
ts = simout.time;

ysim = dlsim(A,B,C,D, us); 

figure();
hold on;
gg=plot(ts,us,'r');
set(gg,'LineWidth',1.5);
gg=plot(ts,ys,'b');
set(gg,'LineWidth',1.5);
legend('Input','Sinal Controlado')
hold off;
title('Modelo c/ LQG')

%bode
PHIE = A-M*C*A; % Matriz da dinamica do estimador
GAMMAE = B-M*C*B; % Matriz de entrada do estimador
lqg = ss([A zeros(size(A)); M*C*A PHIE-GAMMAE*K], [B; M*C*B],[zeros(size(K)) K],0,1/fs);
figure()
bode(lqg)
title('Bode LQG')

%----Controlador Linear Quadrático Gaussiano / Modelo com Deadzone  ----
clear simout
sim('SystemModelControlled_Deadzone');
us = simout.signals.values(:,2);
ys = simout.signals.values(:,1);
ts = simout.time;

ysim = dlsim(A,B,C,D, us); 

figure();
hold on;
gg=plot(ts,us,'r');
set(gg,'LineWidth',1.5);
gg=plot(ts,ys,'b');
set(gg,'LineWidth',1.5);
legend('Input','Sinal Controlado')
hold off;
title('Modelo c/ LQG c/ Deadzone')



%----Controlador Linear Quadrático Gaussiano / Real ----
clear simout
sim('SystemRealControlled');
us = simout.signals.values(:,2);
ys = simout.signals.values(:,1);
ts = simout.time;

figure();
hold on;
gg=plot(ts,us,'r');
set(gg,'LineWidth',1.5);
gg=plot(ts,ys,'b');
set(gg,'LineWidth',1.5);

legend('Input','Sinal Controlado')
hold off;
title('Sistema Real c/ LQG')

