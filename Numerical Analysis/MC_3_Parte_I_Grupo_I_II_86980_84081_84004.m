%15/12/2017
%Diogo Martins Alves N� 86980
%Jo�o Santiago Silva N� 84081
%Andr� Lopes N� 84004

display('Insira os dados de entrada (fun��o f:[a,b]->IR, um natural n e uma estimativa para o erro):');
str = (input('Fun��o f(x) = ', 's'));%fun��o a estudar (string) ex: x.^-2
f = inline(str, 'x');%converte a string para uma fun��o do matlab
a = input('Extremo inferior do intervalo a = ');
b = input('Extremo superior do intervalo b = ');
n = input('N�mero natural n = ');
epsilon = input('Toler�ncia de erro = ');

k = 1;
while( abs(Romberg( k , k , f , a , b )-Romberg( k-1 , k-1 , f , a , b )) >= epsilon ) %enquanto a condi��o n�o for verificada, incrementar k
    k = k+1;
end

integral = Romberg( log2(n) , k , f , a , b ); %regra de Romberg
fprintf('Integral = %.20f\n', integral);

