%LAB 4 PDS
%86980   Diogo Martins Alves
%87136	Xavier Abreu Dias

close all
clear all
clc
%% R1.a) (ver função getLongTermCoef.m)
%% R1.b)
% Carregamento do sinal de treino
x_train = load('energy_train.mat');
x_train = x_train.x_train;
t = 1:length(x_train);
figure();
plot(t*15/60,x_train);

hold on 

% Previsão com base em amostras anteriores (correspondentes a um dia/24h)
N = 96;
a = getLongTermCoef(x_train,N);
x_pred = longTermPrediction(x_train,a,N);
plot(t*15/60,x_pred);

r = x_train - x_pred;
plot(t*15/60,r);
xlabel('Tempo [h]');
ylabel('Energia');
title('R1.b) Dados treino vs Previsão');
legend('Dados de treino', 'Previsão', 'Energia residual, r(n)')


%% R1.c)

Er = 0;
for i=N:length(r)
    Er = Er + r(i)^2;
end


%% R1.d) (ver função getShortTermCoefs.m)
%% R1.e) 

% Previsão da energia residual
P = 6;
a = getShortTermCoefs(r,P);
r_pred = shortTermPrediction(r,a,P);
figure();
hold on
plot(t*15/60, r);
plot(t*15/60,r_pred);
title('R1.e) Energia residual vs Energia residual prevista');
legend('Energia residual, r(n)','Energia residual prevista, r_{pred}(n)');

% Nova previsão da energia usando o modelo de longo termo e a energia 
% residual prevista.
x_new_pred = x_pred + r_pred;
e = r - r_pred;
figure();
plot(t*15/60, x_train, t*15/60, x_new_pred, t*15/60, e);
xlabel('Tempo [h]');
ylabel('Energia');
title('R1.e) Dados treino vs Previsão');
legend('Dados de treino', 'Energia prevista, x(n)', 'Energia residual, e(n)')

%% R1.f) 

Ee = 0;
for i=P:length(e)
    Ee = Ee + e(i)^2;
end

%% R2.a) (ver função detectAnomalies.m)

%% R2.b)
%Carregamento do sinal de teste
x_test = load('energy_test.mat');
x_test = x_test.x_test;
t = 1:length(x_test);

N = 96;
a_long_term = getLongTermCoef(x_train,N); %utilizar o coeficiente obtido para o conjunto de treino

anomalies_longTerm = detectAnomalies(x_test, @longTermPrediction, a_long_term, N, 0.5, 0.05);

figure();
hold on
plot(t*15/60,x_test);
plot(t*15/60,longTermPrediction(x_test,a_long_term,N));
plot(t*15/60,anomalies_longTerm*0.2);
title('R2.b) Anomalias em dados de teste vs dados previstos com modelo a longo prazo (N=96)');
legend('Dados de teste', 'Dados previstos', 'Anomalias (\Deltax/x > 50% e \Deltax > 0.05)');
xlabel('Tempo [h]');
ylabel('Energia');

p = 96;
a_short_term = getShortTermCoefs(x_train,p); %utilizar o vetor de coeficientes obtido para o conjunto de treino

anomalies_shortTerm = detectAnomalies(x_test, @shortTermPrediction, a_short_term, p, 0.5, 0.05);

figure();
hold on
plot(t*15/60,x_test);
plot(t*15/60,shortTermPrediction(x_test,a_short_term,p));
plot(t*15/60,anomalies_shortTerm*0.2);
title('R2.b) Anomalias em dados de teste vs dados previstos com modelo a curto prazo (p=96)');
legend('Dados de teste', 'Dados previstos', 'Anomalias (\Deltax/x > 50% e \Deltax > 0.05)');
xlabel('Tempo [h]');
ylabel('Energia');


%% R2.c)

p = 6;
a_short_term = getShortTermCoefs(x_train,p); %utilizar o vetor de coeficientes obtido para o conjunto de treino

anomalies_shortTerm = detectAnomalies(x_test, @shortTermPrediction, a_short_term, p, 0.5, 0.05);

figure();
hold on
plot(t*15/60,x_test);
plot(t*15/60,shortTermPrediction(x_test,a_short_term,p));
plot(t*15/60,anomalies_shortTerm*0.2);
title('R2.c) Anomalias em dados de teste vs dados previstos com modelo a curto prazo (p=6)');
legend('Dados de teste', 'Dados previstos', 'Anomalias (\Deltax/x > 50% e \Deltax > 0.05)');
xlabel('Tempo [h]');
ylabel('Energia');


