%15/12/2017
%Diogo Martins Alves Nº 86980
%João Santiago Silva Nº 84081
%André Lopes Nº 84004

x_max = 20; %valor máximo do eixo das abcissas do gráfico da função
step = 0.01; %distância entre os pontos onde irá ser calculado o valor da função
x = zeros(x_max/step,1); %inicialização do vetor de abcissas
y = zeros(x_max/step,1); %inicialização do vetor de ordenadas

for m=0:2 %3 gráficos: J_0, J_1, J_2
    
    x_i = 0;
    i = 1; %variável de iteração
    while(x_i <= x_max)
        x(i) = x_i; %construção do vetor de abcissas
        y(i) = J(m,x_i); %construção do vetor de oredenadas
        x_i = x_i + step;
        i = i+1;
    end
    figure
    plot(x,y) %desenho do gráfico J_m(x)
end
