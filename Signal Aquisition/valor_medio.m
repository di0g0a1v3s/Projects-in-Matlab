function valor_medio = valor_medio( data, numero_amostras_usaveis )
%valor_medio Esta função calcula e retorna uma estimativa do valor medio
%de um sinal
    data_2 = data(1:numero_amostras_usaveis); %apenas usar numero_amostras_usaveis amostras
    Q = sum(data_2);
    valor_medio = Q/(length(data_2));

end

