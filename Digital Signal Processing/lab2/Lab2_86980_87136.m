%%Lab 2 Processamento Digital de Sinais

%86980   Diogo Martins Alves
%87136	Xavier Abreu Dias

clear all
clc
%% R1.a)

M = 512;
wo = 5.2*2*pi/M;

n = 0:(M-1);
x = 5*cos(wo*n + 1) + 2*cos(2*wo*n + 2) + 3*cos(5*wo*n + 3);

%% R1.b)
figure(1);
plot(n, x)
title('R1.b) Gráfico de x(n)');
legend('x(n)');
xlabel('n');
ylabel('x(n)');
grid on;


%% R1.c)

N = 512;

X = fftshift(fft(x, N));
magnitude = abs(X)/N;
phase = angle(X);

w = 2*pi*(-N/2:N/2-1)/N;

figure(2);
subplot(2,1,1)
plot(w, magnitude);
title('R1.c) Magnitude do espectro de x[n] (|X(w)|)');
legend('|X(w)|');
xlabel('w (rad/s)');
ylabel('|X(w)|');
grid on;

hold on

subplot(2,1,2)
plot(w, phase);
title('R1.c) Fase do espectro de x[n] (arg(X(w))');
legend('arg(X(w))');
xlabel('w (rad/s)');
ylabel('arg(X(w))');
grid on;

hold off



%% R1.d)

% Os três maiores picos da magnitude do espetro do sinal são os
% seguintes:
%  - magnitude = 2.294 (n=261, fase= 1.6611 rad e w=0.0614 rad/s)
%  - magnitude = 0.7867 (n=266, fase=-2.8673 rad e w=0.1227 rad/s) 
%  - magnitude = 1.479 (n=282, fase= 3.0211 rad e w=0.3191 rad/s). 
% (Nota: considera-se n = {0,..., N-1}

% Reconstrução, xr[n]
xr1 = 2*magnitude(262)*cos(w(262)*n + phase(262));
xr2 = 2*magnitude(267)*cos(w(267)*n + phase(267));
xr3 = 2*magnitude(283)*cos(w(283)*n + phase(283));
xr = (xr1 + xr2 + xr3);

figure(3);
plot(n, xr);
title('R1.d) Gráfico de x_r(n), N = 512');
legend('x_r(n)');
xlabel('n');
ylabel('x_r(n)');
grid on;
%% R1.e)

figure(4);
plot(n, x);
hold on
plot(n, xr);
title('R1.e) x(n) vs x_r(n), N = 512');
legend('x(n)', 'x_r(n)');
xlabel('n');
ylabel('x(n) / x_r(n)');
grid on;


%% R1.f)

N = 1024;

% c)
X = fftshift(fft(x, N));
magnitude = abs(X)/M;
phase = angle(X);

w = 2*pi*(-N/2:N/2-1)/N;

figure(5);
subplot(2,1,1)
plot(w, magnitude);
title('R1.f)(c) Magnitude do espectro de x[n] (|X(w)|)');
legend('|X(w)|');
xlabel('w (rad/s)');
ylabel('|X(w)|');
grid on;

hold on

subplot(2,1,2)
plot(w, phase);
title('R1.f)(c) Fase do espectro de x[n] (arg(X(w))');
legend('arg(X(w))');
xlabel('w (rad/s)');
ylabel('arg(X(w))');
grid on;

hold off


% d)
% Os três maiores picos da magnitude do espetro do sinal são os
% seguintes:
%  - magnitude = 2.294 (n=522, fase = 1.6611 rad e w=0.0614 rad/s)
%  - magnitude = 0.9745 (n=533, fase = 1.6276 rad e w=0.1289 rad/s) 
%  - magnitude = 1.479 (n=564, fase = 3.0211 rad e w=0.3191 rad/s). 
% (Nota: considera-se n = {0,..., N-1}

% Reconstrução, xr[n]
xr1 = 2*magnitude(523)*cos(w(523)*n + phase(523));
xr2 = 2*magnitude(534)*cos(w(534)*n + phase(534));
xr3 = 2*magnitude(565)*cos(w(565)*n + phase(565));
xr = (xr1 + xr2 + xr3);

figure(6);
plot(xr);
title('R1.f)(d) Gráfico de x_r(n), N = 1024');
legend('x_r(n)');
xlabel('n');
ylabel('x_r(n)');
grid on;

% e)
figure(7);
plot(n, x);
hold on
plot(xr);
title('R1.f)(e) x(n) vs x_r(n), N = 1024');
legend('x(n)', 'x_r(n)');
xlabel('n');
ylabel('x(n) / x_r(n)');
grid on;


%% R2.a)
[x, Fs] = audioread('How_many_roads.wav'); %carregamento do sinal

x = x(:,1); %são carregadas duas colunas, apenas nos interessa uma delas

soundsc(x, Fs); %ouvir o sinal



%% R2.c)
M=2048;
x_segment = x(48500:48500+M-1); %sub-vetor de x, de tamanho 2048 a começar na amostra 48500


%% R2.d)
N=2048; %tamanho da dft
X = fft(x_segment,N);
X = fftshift(X);
X_abs = abs(X/N); %módulo
X_angle = angle(X); %fase
df = Fs/N;
f = -Fs/2:df:Fs/2-df; %vetor de frequências
figure;
subplot(2,1,1);

plot(f,X_abs);
title('R2.d) Magnitude do espectro de x(t) (|X(w)|)');
legend('|X(w)|');
xlabel('Frequência (Hz)');
ylabel('|X(w)|');
subplot(2,1,2);
plot(f,X_angle);
title('R2.d) Fase do espectro de x(t) (arg(X(w)))');
legend('arg(X(w))');
xlabel('Frequência (Hz)');
ylabel('arg(X(w))');

% Analisando a DFT do sinal, verificamos que este é constituido por várias
% frequências, sendo que os três maiores picos da magnitude do espetro do 
% sinal são os seguintes:
% - magnitude = 0.009226 (n=1030, fase = -0.6054 rad e f=129.20 Hz (w=0.01841 rad/s))
% - magnitude = 0.005528 (n=1036, fase = -0.4384 rad e f=258.40 Hz (w=0.03682 rad/s)) 
% - magnitude = 0.003674 (n=1042, fase = -2.614 rad e f=387.60 Hz (w=0.05522 rad/s))
% (Nota: considera-se n = {0,..., N-1}
% Assim, o sinal
% reconstruído será um somatório de cosenos com as frequências mencionadas,
% cuja fase é igual à fase da DFT e a amplitude é o dobro da amplitude da
% DFT, uma vez que a DFT de um cosseno terá metade da amplitude do sinal.


%sinal reconstruido
t = 0:1/Fs:(M-1)/Fs;

xr1 = 2*X_abs(1031)*cos(2*pi*f(1031)*t + X_angle(1031));
xr2 = 2*X_abs(1037)*cos(2*pi*f(1037)*t + X_angle(1037));
xr3 = 2*X_abs(1043)*cos(2*pi*f(1043)*t + X_angle(1043));
x_reconstructed = (xr1 + xr2 + xr3);

figure;

plot(t, x_segment); %plot do sinal original
title('R2.d) Sinal Original (truncado) (x(t)) e Sinal Reconstruído (x_r(t))')
hold on

plot(t, x_reconstructed);
legend('x(t)','x_r(t)');
ylabel('x(t), x_r(t)');
xlabel('Tempo (s)');



