function a = getLongTermCoef(time_series_data,N)
% O coeficiente 'a' � calculado atrav�s do m�todo de m�nimos
% quadradaos. Ao derivar a fun��o de custo, a soma dos erros quadr�ticos,
% em ordem a 'a', consegue-se obter o coeficiente como sendo a raz�o
% entre a soma de (N+1) a M de x(n)*x(n-N) e a soma  de (N+1) a M de 
% (x(n-N))^2.

M = length(time_series_data);
sum_num = 0;
sum_den = 0;

for n = N+1:M
    sum_num = sum_num + time_series_data(n)*time_series_data(n-N);
    sum_den = sum_den + time_series_data(n-N)^2;
end

a = sum_num/sum_den;
end
