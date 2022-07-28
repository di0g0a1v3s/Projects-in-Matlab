function freq_sinal = freq_sinal(dados,freq_amostragem )
%freq_sinal Esta função estima a frequência de um sinal, com base no seu
%espectro
    delta_f = freq_amostragem/length(dados);
    S = fft(dados);
    S = S(1:length(dados)/2+1); %single-sided dft
     
    %algoritmo IpDFT
    U = real(S);
    V = imag(S);
    
    [~,indice_max] = max(abs(S(2:length(dados)/2+1))); %máximo do espectro
    if(abs(S(indice_max+1)) > abs(S(indice_max-1)))
        L = indice_max;
    else
        L = indice_max - 1;
    end

    n = 2*pi/length(dados);
    k_opt = ((V(L+1) - V(L))*sin(n*L) + (U(L+1) - U(L))*cos(n*L))/(U(L+1) - U(L));
    Z_1 = V(L) * (k_opt - cos(n*L))/sin(n*L) + U(L);
    Z_2 = V(L+1) * (k_opt - cos(n*(L+1)))/sin(n*(L+1)) + U(L+1);
    lambda = 1/n * acos( (Z_2 * cos(n*(L+1)) - Z_1*cos(n*L))/(Z_2-Z_1));

    freq_sinal = (lambda-1) * delta_f;
 
end

