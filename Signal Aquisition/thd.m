function thd = thd(single_sided_power_spectrum )
%thd Esta função calcula e retorna o valor de Total Harmonic Distortion de
%um sinal, com base no seu espectro

    [maximum, indice_max] = max(single_sided_power_spectrum); %máximo do espectro
    sum = 0;
    for i = 1:length(single_sided_power_spectrum)
         if(i ~= indice_max)
             sum = sum + single_sided_power_spectrum(i);
         end
    end
     
    thd = 20*log10(sqrt(sum/maximum));
    
            
        
end

