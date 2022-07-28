function predict = longTermPrediction(time_series_data, coefficient, N)
%retorna o sinal predito através do modelo a longo prazo, do sinal de
%entrada "time_series_data". O modelo tem como coeficiente o "coefficient"
%e como atraso "N"
predict = zeros(length(time_series_data),1);
    for n = N+1:length(time_series_data)
        predict(n) = coefficient * time_series_data(n-N);
    end
end

    