%https://www.mathworks.com/help/daq/transition-your-code-to-session-based-interface.html
%daq.getDevices para ver dispositivos
clear %limpar variáveis do workspace
nome_dispositivo = 'Dev1';
canal = 1;
numero_pontos = 5000;
alcance_canal = [-1 1];
frequencia_amostragem = 500;
aquisicoes = 6;

%criar sessão
s = daq.createSession('ni'); 

%adicionar canal de entrada analógica
ch = addAnalogInputChannel(s,nome_dispositivo,canal,'Voltage');
%ch(1).TerminalConfig = 'SingleEnded';
ch(1).Range = alcance;

s.Rate = frequencia_amostragem;
frequencia_amostragem = s.Rate; %atualização da frequência de amostragem para o valor real da placa
s.DurationInSeconds = numero_pontos/frequencia_amostragem;
% 
% %iniciar recolha de dados
for i = 1 : aquisicoes
    [data(:,i),timestamps(:,i)] = startForeground(s);
end

%exemplo de teste
% timestamps(:,1) = (0: 1/frequencia_amostragem: (numero_pontos-1)/frequencia_amostragem);
% sinal = sin(2*10*pi*timestamps);
% data(:,1) = awgn(sinal,100,'measured');
% data(:,2) = awgn(sinal,100,'measured');
% data(:,3) = awgn(sinal,100,'measured');
% data(:,4) = awgn(sinal,100,'measured');
% data(:,5) = awgn(sinal,100,'measured');
% data(:,6) = awgn(sinal,100,'measured');

numero_amostras = zeros();
frequencias_sinais = zeros();
valores_eficazes = zeros();
valores_medios = zeros();

for i = 1 : aquisicoes
    [freq_array(:,i), amplitudes_ssps(:,i)] = single_sided_power_spectrum(frequencia_amostragem, data(:,i));
    numero_amostras(i) = length(data(:,i));

    frequencias_sinais(i) = freq_sinal(data(:,i),frequencia_amostragem);
    
    numero_pontos_por_periodo = frequencia_amostragem/frequencias_sinais(i);
    numero_periodos = floor(numero_amostras(i)/numero_pontos_por_periodo);
    numero_amostras_usaveis = round(numero_pontos_por_periodo * numero_periodos);
    
    valores_eficazes(i) = valor_eficaz(data(:,i), numero_amostras_usaveis);
    valores_medios(i) = valor_medio(data(:,i), numero_amostras_usaveis);
end

amplitude_media = mean(amplitudes_ssps,2); %valor médio das colunas da matriz
frequencia_sinal_media = mean(frequencias_sinais);
valor_eficaz_medio = mean(valores_eficazes);
valor_medio_medio = mean(valores_medios);

sinal_RMS = RuidoEficaz( amplitude_media );
ENOB = ENOB(amplitude_media);

%plot do gráfico do sinal no tempo
subplot(2,1,1);
plot(timestamps,data(:,1));
%cálculo do limite temporal de modo a serem mostrados no máximo 5 periodos
numero_de_periodos_a_mostrar = 5;
if(length(data)/frequencia_amostragem < numero_de_periodos_a_mostrar/frequencias_sinais(1))
    x_max = length(data)/frequencia_amostragem;
else
    x_max = numero_de_periodos_a_mostrar/frequencias_sinais(1);
end

axis([0 x_max alcance_canal(1) alcance_canal(2)]);

%titulo do gráfico
title(sprintf('Valor eficaz: %.6f V | Ruido eficaz: %.6f V_{RMS} | Número efetivo de bits: %.6f |\n Numero de amostras: %d | Frequência de amostragem: %.2f S/s |\n Alcance: [%.2f, %.2f] V', valor_eficaz_medio, sinal_RMS  , ENOB  , length(data(:,1)), frequencia_amostragem, alcance_canal(1), alcance_canal(2)));
xlabel('tempo (s)')
ylabel('Amplitude (V)')

%plot do espectro em escala semi-logaritmica
subplot(2,1,2);
semilogy(freq_array(:,1),amplitude_media)
xlabel('frequência (Hz)')
ylabel('Magnitude (V_{RMS}^2)')


%fileName = 'data.mat';
%save(fileName,'timestamps','data')