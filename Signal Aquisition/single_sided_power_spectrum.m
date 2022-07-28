function [freq,amplitude] = single_sided_power_spectrum( freq_amostragem, dados )
%single_sided_power_spectrum Esta função calcula e retorna o single sided
%power spectrum do sinal amostrado

n = length(dados);  % número de amostras
Y = fft(dados);
Y2 = (abs(Y/n)).^2;  %two-sided power spectrum
Y1 = Y2(1:n/2+1);
Y1(2:end-1) = 2*Y1(2:end-1); %single sided power spectrum
amplitude = Y1;
freq(:,1) = freq_amostragem*(0:(n/2))/n; %vetor de frequências
end

