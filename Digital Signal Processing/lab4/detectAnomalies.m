function anomalies =  detectAnomalies(time_series_data, model, model_coefficients, model_delay, min_relative_deviation, min_absolute_deviation)
%detecta anomalias entre o sinal de entrada e o sinal predito através do
%modelo "model", com coeficientes "model_coefficients" e atraso
%"model_delay". Nos instantes em que o sinal predito tem desvio relativo superior a 
%"min_relative_deviation" em relação ao sinal original e desvio absoluto superior a
%"min_absolute_deviation", o sinal de saída vale 1, caso contrário vale 0
    anomalies = zeros(length(time_series_data), 1);
    predicted_series_data = model(time_series_data, model_coefficients, model_delay);
    for i = model_delay+1:length(time_series_data)
        if abs(predicted_series_data(i) - time_series_data(i))/time_series_data(i) > min_relative_deviation && abs(predicted_series_data(i) - time_series_data(i)) > min_absolute_deviation
            anomalies(i) = 1;
        end
    end

end

