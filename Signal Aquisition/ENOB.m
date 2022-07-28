function num_Bits = ENOB( single_sided_power_spectrum )
%ENOB esta função calcula uma estimativa do numero eficaz de bits

%média do espetro
avg = mean(single_sided_power_spectrum);
%potencia do sinal
potencia_sinal = 0;
%potência total do sinal restante
noise_and_distortion = 0;

for i = 1:length(single_sided_power_spectrum)
    if(single_sided_power_spectrum(i) < avg)
        noise_and_distortion = noise_and_distortion + single_sided_power_spectrum(i);
    else
        potencia_sinal = potencia_sinal + single_sided_power_spectrum(i);
    end
end

SINAD = 10*log10((potencia_sinal + noise_and_distortion)/noise_and_distortion);
ENOB = (SINAD-1.76)/6.02;

num_Bits = ENOB;

end
