function predict = shortTermPrediction(time_series_data, coefficients, P)
%retorna o sinal predito através do modelo a curto prazo, do sinal de
%entrada "time_series_data". O modelo tem como coeficientes os "coefficients"
%e como atraso "P"
predict = zeros(length(time_series_data),1);
    for n = P+1:length(time_series_data)
        for k = 1:P
            predict(n) = predict(n) + coefficients(k) * time_series_data(n-k);
        end
    end
end

