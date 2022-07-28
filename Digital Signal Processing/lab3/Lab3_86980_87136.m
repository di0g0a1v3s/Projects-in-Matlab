%LAB 3 PDS

close all
clear all
clc

%R.1a)

[x, Fs] = audioread('fugee.wav'); %carregamento do sinal
%soundsc(x(1:int64(length(x)/20)), Fs); %ouvir o sinal
%pause(length(x)/20*1/Fs);


%% R1.b)

t = (0:(length(x)-1))/Fs;
plot(t,x)
title('R1.b) Gráfico de x(t)');
xlabel('t (s)');
ylabel('x(t)');


%% R1.c)
X = fftshift(fft(x));
magnitude_X = abs(X)/length(x);

w = 2*pi*(-length(x)/2:length(x)/2-1)/length(x);

figure(2);
semilogy(w, magnitude_X);
title('R1.c) Magnitude do espectro de x[n] (|X(w)|)');
legend('|X(w)|');
xlabel('w (rad/s)');
ylabel('|X(w)|');
grid on;




%% R2.a)

L = 11;
h = gausswin(L);

%% R2.b)
wvtool(h)

%% R2.c)
y = conv(x,h);
y = y((L+1)/2:length(y)-(L-1)/2); %necessario para que x e y tenham o mesmo tamanho e estejam sincronizados

%% R2.d)
figure(4);
plot(t,y)
hold on;
plot(t, x)


title('R2.d) Gráfico de x(t) e do sinal filtrado y(t) pelo 1º método');
xlabel('t (s)');
ylabel('Ampitude');
legend('y(t) (filtrado)','x(t) (original)');

%% R2.e)
figure(5);
Y = fftshift(fft(y));
magnitude_Y = abs(Y)/length(y);


semilogy(w, magnitude_Y)
hold on;
semilogy(w, magnitude_X)
title('R2.e) Magnitude do espectro de x[n] (|X(w)|) e y[n] (|Y(w)|) (sinal filtrado pelo 1º método)');
legend('|Y(w)| (filtrado)', '|X(w)| (original)');
xlabel('w (rad/s)');
ylabel('Magnitude');
grid on;


%% R2.f)
%soundsc(y(1:int64(length(y)/20)), Fs)
%pause(length(x)/20*1/Fs);

%% R2.g)

H = fft(h,length(x));
X_ = fft(x);
Y_ = H.*X_;
y_ = ifft(Y_);

figure(6);
plot(t,y_)
hold on;
plot(t, x)


title('R2.g) Gráfico de x(t) e do sinal filtrado y(t) pelo 2º método');
xlabel('t (s)');
ylabel('Ampitude');
legend('y(t) (filtrado)','x(t) (original)');

figure(7);

magnitude_Y_ = abs(fftshift(Y_))/length(y_);
semilogy(w, magnitude_Y_)
hold on;
semilogy(w, magnitude_X)
title('R2.g) Magnitude do espectro de x[n] (|X(w)|) e y[n] (|Y(w)|) (sinal filtrado pelo 2º método');
legend('|Y(w)| (filtrado)', '|X(w)| (original)');
xlabel('w (rad/s)');
ylabel('Magnitude');
grid on;

%soundsc(y_(1:int64(length(y)/20)), Fs)
%pause(length(x)/20*1/Fs);




%% R3.b)

y3 = medfilt1(x,3);

figure(8)
plot(x);
hold on
plot(y3);
legend('Original','Filtrado')
title('R3.b) Sinal original vs Sinal filtrado por um filtro de mediana');
xlabel('t (s)');
ylabel('Amplitude');

% Comentários no relatório

%% R3.c)
figure(9);
Y3 = fftshift(fft(y3));
magnitude_Y3 = abs(Y3)/length(y3);

semilogy(w, magnitude_X)
hold on;
semilogy(w, magnitude_Y3)
title('R3.c) Magnitude do espectro de x[n] (|X(w)|) e y[n] (|Y(w)|) (sinal filtrado)');
legend('|X(w)| (original)', '|Y(w)| (filtrado)');
xlabel('w (rad/s)');
ylabel('Magnitude');
grid on;
% Comentários no relatório

%% R3.d)
% Sinal original
% soundsc(x(1:int64(length(x)/20)), Fs)

% Sinal filtrado
% soundsc(y3(1:int64(length(x)/20)), Fs)

% Comentários no relatório
%% R3.e)

% Filtro de ordem 4
y4 = medfilt1(x,4);
figure(10)
plot(x);
hold on
plot(y4);
legend('Original','Filtrado')
title('R3.e) Sinal original vs Sinal filtrado por um filtro de mediana (ordem 4)');
xlabel('t (s)');
ylabel('Amplitude');

% soundsc(y4(1:int64(length(x)/20)), Fs)

% Filtro de ordem 6
y10 = medfilt1(x,6);
figure(11)
plot(x);
hold on
plot(y10);
legend('Original','Filtrado')
title('R3.e) Sinal original vs Sinal filtrado por um filtro de mediana (ordem 6)');
xlabel('t (s)');
ylabel('Amplitude');

% soundsc(y10(1:int64(length(x)/20)), Fs)

% Filtro de ordem 150
y150 = medfilt1(x,150);
figure(13)
plot(x);
hold on
plot(y150);
legend('Original','Filtrado')
title('R3.e) Sinal original vs Sinal filtrado por um filtro de mediana (ordem 150)');
xlabel('t (s)');
ylabel('Amplitude');

%soundsc(y150(1:int64(length(x)/20)), Fs)

% Comentários no relatório

%% R3.f) 
% Sinal original
% soundsc(x(1:int64(length(x)/20)), Fs)

% Sinal resultante do filtro gaussiano
% soundsc(y(1:int64(length(y)/20)), Fs)

% Sinal resultante do filtro de mediana de ordem 4
% soundsc(y4(1:int64(length(x)/20)), Fs)

% Comentários no relatório
