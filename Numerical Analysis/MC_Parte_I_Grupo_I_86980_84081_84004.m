%20/11/2017
%Diogo Martins Alves N� 86980
%Jo�o Santiago Silva N� 84081
%Andr� Lopes N� 84004

display('Insira os dados de entrada:');
str = (input('Fun��o de x: ', 's'));%fun��o a estudar (string) ex: 35*tan(x) - 35.^2 * 9.81/(800*(cos(x)).^2) + 1
f = inline(str, 'x');%converte a string para uma fun��o do matlab
delta = input('Valor de delta: ');%valor do par�metro delta
x_0 = input('Aproxima��o inicial x_0: ');%iterada inicial
n_max_iter = input('N�mero m�ximo de itera��es: ');%n�mero m�ximo de itera��es
epsilon = input('Toler�ncia de erro: ');%toler�ncia de erro pretendida

x(1) = x_0;
n = 1;
while( n <= n_max_iter ) %ciclo que corre at� serem produzidas n_max_iter iteradas
    x(n+1) = x(n) - (delta * f( x(n) )) / (f(x(n) + delta) - f(x(n))); %m�todo quasi-Newton
    n = n+1;
    fprintf('Iterada %d: %.20f, Diferen�a entre iteradas: %d\n', n-1,x(n),abs(x(n) - x(n-1)));
    if(epsilon >= abs(x(n) - x(n-1))) %no caso de alguma das iteradas ter um erro abaixo ou igual ao pretendido, o ciclo para
        break;
    end
end