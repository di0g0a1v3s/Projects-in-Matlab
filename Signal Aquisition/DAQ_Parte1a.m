% https://www.mathworks.com/help/daq/transition-your-code-to-session-based-interface.html
% Para ver qual � o ID do dispositivo correr:
%          devices = daq.getDevices
clear %limpar vari�veis do workspace

% Defini��o da frequ�ncia de amostragem e do n�mero de pontos 
frequencia_amostragem = 100000;
numero_pontos = 40000;
% Nome do dispositivo
nome_dispositivo = 'Dev1';
% Defini��o do canal a utilizar
canal = 0;
alcance_canal = [-5 5];

% Cria��o de uma sess�o e defini��o dos par�metros de amostragem
%s = daq.createSession('ni'); 
%ch = addAnalogInputChannel(s,nome_dispositivo,canal,'Voltage');
%ch(1).Range = alcance_canal;
%s.Rate = frequencia_amostragem;
%frequencia_amostragem = s.Rate; %atualiza��o da frequ�ncia de amostragem para o valor real da placa
%s.DurationInSeconds = numero_pontos/frequencia_amostragem; 

% Aquisi��o dos dados
%[data,timestamps] = startForeground(s);

% exemplo de teste
timestamps(:,1) = (0: 1/frequencia_amostragem: (numero_pontos-1)/frequencia_amostragem);
data(:,1) = 2*square(2*pi*400*timestamps,20);
%load('situacao1_parte1.mat');

numero_amostras = length(data);

%c�lculo do espetro (single sided power spectrum) do sinal
[freq_array, amplitude_ssps] = single_sided_power_spectrum(frequencia_amostragem, data);


%c�lculo da estimativa da frequ�ncia do sinal
freq_sinal = freq_sinal(data,frequencia_amostragem);

%c�lculo do n�mero m�ximo de periodos inteiros do sinal e n�mero de amostras nesse espa�o de tempo 
numero_pontos_por_periodo = frequencia_amostragem/freq_sinal;
numero_periodos = floor(numero_amostras/numero_pontos_por_periodo);
numero_amostras_usaveis = round(numero_pontos_por_periodo * numero_periodos);

%c�lculo do valor m�dio e valor eficaz do sinal
valor_medio = valor_medio(data, numero_amostras_usaveis);
valor_eficaz = valor_eficaz(data, numero_amostras_usaveis);

%plot do gr�fico do sinal no tempo
subplot(2,1,1);
plot(timestamps,data)

%c�lculo do limite temporal de modo a serem mostrados no m�ximo 5 periodos
numero_de_periodos_a_mostrar = 5;
if(length(data)/frequencia_amostragem < numero_de_periodos_a_mostrar/freq_sinal)
    x_max = length(data)/frequencia_amostragem;
else
    x_max = numero_de_periodos_a_mostrar/freq_sinal;
end

axis([0 x_max alcance_canal(1) alcance_canal(2)]);

%titulo do gr�fico
title(sprintf('Frequ�ncia do sinal: %.6f Hz | Valor medio: %.6f V | Valor eficaz: %.6f V_{RMS} |\n Numero de amostras: %d | Frequ�ncia de amostragem: %.2f S/s |\n Alcance: [%.2f, %.2f] V',freq_sinal, valor_medio, valor_eficaz, length(data), frequencia_amostragem, alcance_canal(1), alcance_canal(2)));
xlabel('tempo (s)')
ylabel('Amplitude (V)')

%plot do espectro em escala semi-logaritmica
subplot(2,1,2);
semilogy(freq_array,(amplitude_ssps))
xlabel('frequ�ncia (Hz)')
ylabel('Magnitude (V_{RMS}^2)')

%C�lculo do THD
thd(amplitude_ssps)

%Guardar os dados num ficheiro
%fileName = 'situacao3_parte1.mat';
%save(fileName,'timestamps','data')