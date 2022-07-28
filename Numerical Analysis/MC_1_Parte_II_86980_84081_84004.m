%27/12/2017
%Diogo Martins Alves N� 86980
%Jo�o Santiago Silva N� 84081
%Andr� Lopes N� 84004

display('Insira os dados de entrada (f:[a,b]xIR^d->IR^d, y(a) em IR^d, n em IN):');
a = input('In�cio do intervalo a = ');
b = input('Fim do intervalo b = ');
d = input('N�mero de equa��es d = ');
str = (input('f(t, y_1, y_2,..., y_d) = ', 's'));%fun��o a estudar (string) NOTA: todas as vari�veis t, y_1, ..., y_d t�m que
%aparecer na express�o da fun��o, nem que seja multiplicadas por 0 ex: [-0.001*y_1*y_2 + t*0,  0.001*y_1*y_2-0.3*y_2]
f = inline(str);%converte a string para uma fun��o do matlab
n = input('N�mero de itera��es n = ');
y = zeros(n+1,d); %inicializa��o do(s) vetor(es) que ir�o guardar as sucessivas iteradas
y(1,:) = input('Condi��o inicial y(a) = '); %ex: [799, 1]

h = (b-a)/n; %dist�ncia entre os pontos nos quais ir� ser aproximada a fun��o

for i = 1:n
    t_i = a + i*h; 
    q = num2cell(y(i,:)); % vetor ((y_1)_i, (y_2)_i, ..., (y_d)_i)
    p = num2cell(y(i,:) + h*f(t_i,q{:})); %vetor (...,(y_a)_i + h * f(t_i, (y_a)_i),...) com a=1:d
    y(i+1,:) = y(i,:) + (h/2)*( f(t_i,q{:}) + f(t_i, p{:}) ); %M�todo de Heun
    %impress�o das sucessivas iteradas:
    fprintf('y_%d = ( ', i);
    for j = 1:d
        fprintf(' %.10f, ', y(i,j));
    end
    fprintf(')\n');
        
end

    
    
    