function a = getShortTermCoefs(time_series_data,P)
% Os P coeficientes 'a' (um vetor) são calculados através do método de
% mínimos quadrados residuais. Assim os P coeficientes, a serem estimados é
% dados pela expressão 'a_est' = ((H'*H)^-1) * H'*x, onde H é uma matriz
% de dimensão (P x M-P).
M = length(time_series_data); 
x = time_series_data;

H = zeros(M-P, P);

for m = 1:M-P
    for p = 1:P
        H(m,p) = x(P-p+1+m-1);
    end
end

a = ((H.'*H)^-1) * H.' * x(P+1:end);

end