%15/12/2017
%Diogo Martins Alves N� 86980
%Jo�o Santiago Silva N� 84081
%Andr� Lopes N� 84004

x_max = 20; %valor m�ximo do eixo das abcissas do gr�fico da fun��o
step = 0.01; %dist�ncia entre os pontos onde ir� ser calculado o valor da fun��o
x = zeros(x_max/step,1); %inicializa��o do vetor de abcissas
y = zeros(x_max/step,1); %inicializa��o do vetor de ordenadas

for m=0:2 %3 gr�ficos: J_0, J_1, J_2
    
    x_i = 0;
    i = 1; %vari�vel de itera��o
    while(x_i <= x_max)
        x(i) = x_i; %constru��o do vetor de abcissas
        y(i) = J(m,x_i); %constru��o do vetor de oredenadas
        x_i = x_i + step;
        i = i+1;
    end
    figure
    plot(x,y) %desenho do gr�fico J_m(x)
end
