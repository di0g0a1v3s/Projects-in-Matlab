% Para ver qual é o ID do dispositivo correr:
%          devices = daq.getDevices

clear %limpar variàveis do workspace

% Nome do dispositivo
nome_dispositivo = 'Dev1';

% Definição da frequência de amostragem e do número de pontos
frequencia_amostragem = 500;
numero_pontos = 10000;

% Definição dos canais a utilizar (dos canais 0 e 1)
canais = [0 1];
alcance_canais = [-1 1];
ch = zeros(1,length(canais));

% Criação de uma sessão e definição do ritmo de amostragem
s = daq.createSession(nome_dispositvo);
s.Rate = frequencia_amostragem;
frequencia_amostragem = s.Rate; %atualização da frequência de amostragem para o valor real da placa
s.DurationInSeconds = numero_pontos/frequencia_amostragem; 

for i = 1:length(canais)
    ch(i) = addAnalogInputChannel(s,nome_dispositivo, canais(1), 'Voltage');
    ch(i).TerminalConfig = 'SingleEnded';
    ch(i).Range = alcance_canais;
end

% Aquisição dos dados
[data, timestamps] = s.startForeground();


%exemplo de teste
% timestamps(:,1) = (0: 1/frequencia_amostragem: (numero_pontos-1)/frequencia_amostragem);
% data(:,1) = sin(2*1*pi*timestamps);
% data(:,2) = 0.5*sin(2*1*pi*timestamps) + 0.001*sin(2*100*pi*timestamps);


% Para ver detalhes da aquisição:
display(s);

% Estimativas
numero_amostras_usaveis = zeros(1,length(canais));
frequencia_sinal = zeros(1,length(canais));
valores_eficazes = zeros(1,length(canais));
numero_amostras = length(data(:,1));
dif_fase = diferenca_fase(data(:,1), data(:,2));
for i = 1:length(canais)
    frequencia_sinal(i) = freq_sinal(data(:,i), frequencia_amostragem);
    
    numero_pontos_por_periodo = frequencia_amostragem/frequencia_sinal(i);
    numero_periodos = floor(numero_amostras/numero_pontos_por_periodo);
    numero_amostras_usaveis(i) = round(numero_pontos_por_periodo * numero_periodos);
    valores_eficazes(i) = valor_eficaz(data(:,i), numero_amostras_usaveis);
end

% Figura com os sinais temporais
%cálculo do limite temporal de modo a serem mostrados no máximo 5 periodos
numero_de_periodos_a_mostrar = 5;
if(length(data(:,1))/frequencia_amostragem < length(data(:,2))/frequencia_amostragem)
    if(length(data(:,1))/frequencia_amostragem < numero_de_periodos_a_mostrar/frequencia_sinal(1))
        x_max = length(data(:,2))/frequencia_amostragem;
    else
        x_max = numero_de_periodos_a_mostrar/frequencia_sinal(1);
    end
else
    if(length(data(:,2))/frequencia_amostragem < numero_de_periodos_a_mostrar/frequencia_sinal(2))
        x_max = length(data(:,2))/frequencia_amostragem;
    else
        x_max = numero_de_periodos_a_mostrar/frequencia_sinal(2);
    end
end
plot(timestamps, data); %%faz plot
axis([0 x_max alcance_canais(1) alcance_canais(2)]);
xlabel('Tempo (s)');
ylabel('Sinal adquirido (V)');
title(sprintf('Frequência do sinal 1: %.6f Hz | Frequência do sinal 2: %.6f Hz | Diferença de fase: %.2fº|\n Valor eficaz do sinal 1: %.6f V_{RMS} | Valor eficaz do sinal 2: %.6f V_{RMS} |\n Número de amostras do sinal 1: %d | Número de amostras do sinal 2: %d |\n Frequência de amostragem: %.2f S/s | Alcance: [%.2f, %.2f] V',frequencia_sinal(1),frequencia_sinal(2), dif_fase, valores_eficazes(1), valores_eficazes(2), length(data(:,1)), length(data(:,2)),  frequencia_amostragem, alcance_canais(1), alcance_canais(2)));

% ver exemplo em: https://www.mathworks.com/help/daq/examples/acquire-data-from-multiple-channels-using-mcc-devices.html