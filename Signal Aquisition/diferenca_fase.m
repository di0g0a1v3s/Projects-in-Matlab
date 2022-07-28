function diferenca_fase = diferenca_fase(data_1, data_2)
%diferenca_fase Calcula a diferença de fase (em graus) entre duas
%sinusoides com a mesma frequência
    %o ângulo é dado pelo arccos do produto interno entre os sinais,
    %dividido pelos módulos
    y_rad=acos(dot(data_1,data_2)/(norm(data_1)*norm(data_2))); %diferença de fase em radianos
    diferenca_fase=y_rad*360/(2*pi); %passagem para graus
    
end

