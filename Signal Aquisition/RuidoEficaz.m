function ruidoEficaz = RuidoEficaz(single_sided_power_spectrum )
%ruidoEficaz Esta função calcula uma estimativa do ruido eficaz de um sinal
ruido = 0;
avg = mean(single_sided_power_spectrum);
for i=1:length(single_sided_power_spectrum)
    if(single_sided_power_spectrum(i) < avg)
        ruido = ruido + single_sided_power_spectrum(i);
    end
end

ruidoEficaz = sqrt(ruido);
