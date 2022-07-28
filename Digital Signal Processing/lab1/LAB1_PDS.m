%LAB 1 PDS

%% R.1a)

F_0 = 300;
final_time = 0.5;
samples_per_second = 3000;
number_samples = final_time * samples_per_second;
t = 1:number_samples;
t = t * final_time/number_samples;

x = cos(2* pi * F_0 * t);

figure();
plot(t,x)
title('R1.a) Sinal x(t) amostrado a 300 Hz');


%% R.1b)

N=512; 
figure();
spectrogram(x, hann(N), 3*N/4, 4*N, 3000, 'yaxis');
title('R1.b) Espectrograma do sinal amostrado a 300 Hz');



%% R.2a)

F_0 = 2700;

x = cos(2* pi * F_0 * t);

figure();
plot(t,x)
title('R2.a) Sinal x(t) amostrado a 2700 Hz');

N=512; 
figure();
spectrogram(x, hann(N), 3*N/4, 4*N, 3000, 'yaxis');
title('R2.a) Espectrograma do sinal amostrado a 2700 Hz');

%% R.3a)
[x, Fs] = audioread('Happier.mp3'); 

% Ouvir
soundsc(x, Fs)

% Ler apenas os primeiros 15 segundos
samples = [1,15*Fs];
clear x Fs
[x, Fs] = audioread('Happier.mp3', samples);
soundsc(x, Fs)

% Dois canais e fazer a média
x1 = x(:,1);
x2 = x(:,2);
xm = (x1 + x2)/2;

% Espectrograma
samplesv = [256, 512, 1024, 2048, 4096];
for i=1:length(samplesv)
    figure(2);
    N = samplesv(i)
    spectrogram(xm, hann(N), 3*N/4, 4*N, Fs, 'yaxis');
    title('R3.a) Espectrograma para o áudio');
    pause;
end

% Espectrograma final
figure()
N = 1024;
spectrogram(xm, hann(N), 3*N/4, 4*N, Fs, 'yaxis');
title('R3.a) Espectrograma para o áudio');

%% R4.a)
% Ler apenas os primeiros 15 segundos
samples = [1, 15*Fs];

clear x Fs
[x, Fs] = audioread('Happier.mp3', samples);

x1 = x(:,1);
x2 = x(:,2);

% Dois canais e fazer a média
y1 = x1(1:5:end);
y2 = x2(1:5:end);
y = (y1 + y2)/2;
soundsc(y, Fs/5);

% Espectrograma
figure()
N = 1024;
spectrogram(y, hann(N), 3*N/4, 4*N, Fs/5, 'yaxis');
title('R4.a) Espectrograma para o áudio subamostrado com Fs/5');
%% R5.a)
clear x Fs

[x, Fs] = audioread('Happier.mp3');

xf = filter(fir1(100, 0.2), 1, x);
soundsc(xf, Fs);

% Dois canais e fazer a média
y1 = xf(1:5:end);
y2 = xf(1:5:end);
y = (y1 + y2)/2;
soundsc([y1 y2], Fs/5);

figure()
N = 1024;
spectrogram(y, hann(N), 3*N/4, 4*N, Fs/5, 'yaxis');
title('R5.a) Espectrograma para o áudio subamostrado e filtrado pelo FIR');