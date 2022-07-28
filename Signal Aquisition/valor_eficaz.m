function valor_eficaz = valor_eficaz( data, numero_amostras_usaveis )
%valor_eficaz Esta função calcula e retorna uma estimativa do valor eficaz
%de um sinal
    data_2 = data(1:numero_amostras_usaveis); %apenas usar numero_amostras_usaveis amostras
    Q = sum(data_2.^2);
    valor_eficaz = sqrt(Q/length(data_2));

end

