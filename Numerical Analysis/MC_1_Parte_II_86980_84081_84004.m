%27/12/2017
%Diogo Martins Alves Nº 86980
%João Santiago Silva Nº 84081
%André Lopes Nº 84004

display('Insira os dados de entrada (f:[a,b]xIR^d->IR^d, y(a) em IR^d, n em IN):');
a = input('Início do intervalo a = ');
b = input('Fim do intervalo b = ');
d = input('Número de equações d = ');
str = (input('f(t, y_1, y_2,..., y_d) = ', 's'));%função a estudar (string) NOTA: todas as variáveis t, y_1, ..., y_d têm que
%aparecer na expressão da função, nem que seja multiplicadas por 0 ex: [-0.001*y_1*y_2 + t*0,  0.001*y_1*y_2-0.3*y_2]
f = inline(str);%converte a string para uma função do matlab
n = input('Número de iterações n = ');
y = zeros(n+1,d); %inicialização do(s) vetor(es) que irão guardar as sucessivas iteradas
y(1,:) = input('Condição inicial y(a) = '); %ex: [799, 1]

h = (b-a)/n; %distância entre os pontos nos quais irá ser aproximada a função

for i = 1:n
    t_i = a + i*h; 
    q = num2cell(y(i,:)); % vetor ((y_1)_i, (y_2)_i, ..., (y_d)_i)
    p = num2cell(y(i,:) + h*f(t_i,q{:})); %vetor (...,(y_a)_i + h * f(t_i, (y_a)_i),...) com a=1:d
    y(i+1,:) = y(i,:) + (h/2)*( f(t_i,q{:}) + f(t_i, p{:}) ); %Método de Heun
    %impressão das sucessivas iteradas:
    fprintf('y_%d = ( ', i);
    for j = 1:d
        fprintf(' %.10f, ', y(i,j));
    end
    fprintf(')\n');
        
end

    
    
    