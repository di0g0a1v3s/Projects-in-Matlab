%20/11/2017
%Diogo Martins Alves Nº 86980
%João Santiago Silva Nº 84081
%André Lopes Nº 84004

display('Insira os dados de entrada:');
str = (input('Função de x: ', 's'));%função a estudar (string) ex: 35*tan(x) - 35.^2 * 9.81/(800*(cos(x)).^2) + 1
f = inline(str, 'x');%converte a string para uma função do matlab
delta = input('Valor de delta: ');%valor do parâmetro delta
x_0 = input('Aproximação inicial x_0: ');%iterada inicial
n_max_iter = input('Número máximo de iterações: ');%número máximo de iterações
epsilon = input('Tolerância de erro: ');%tolerância de erro pretendida

x(1) = x_0;
n = 1;
while( n <= n_max_iter ) %ciclo que corre até serem produzidas n_max_iter iteradas
    x(n+1) = x(n) - (delta * f( x(n) )) / (f(x(n) + delta) - f(x(n))); %método quasi-Newton
    n = n+1;
    fprintf('Iterada %d: %.20f, Diferença entre iteradas: %d\n', n-1,x(n),abs(x(n) - x(n-1)));
    if(epsilon >= abs(x(n) - x(n-1))) %no caso de alguma das iteradas ter um erro abaixo ou igual ao pretendido, o ciclo para
        break;
    end
end