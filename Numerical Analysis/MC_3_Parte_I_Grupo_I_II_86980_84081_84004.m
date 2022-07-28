%15/12/2017
%Diogo Martins Alves Nº 86980
%João Santiago Silva Nº 84081
%André Lopes Nº 84004

display('Insira os dados de entrada (função f:[a,b]->IR, um natural n e uma estimativa para o erro):');
str = (input('Função f(x) = ', 's'));%função a estudar (string) ex: x.^-2
f = inline(str, 'x');%converte a string para uma função do matlab
a = input('Extremo inferior do intervalo a = ');
b = input('Extremo superior do intervalo b = ');
n = input('Número natural n = ');
epsilon = input('Tolerância de erro = ');

k = 1;
while( abs(Romberg( k , k , f , a , b )-Romberg( k-1 , k-1 , f , a , b )) >= epsilon ) %enquanto a condição não for verificada, incrementar k
    k = k+1;
end

integral = Romberg( log2(n) , k , f , a , b ); %regra de Romberg
fprintf('Integral = %.20f\n', integral);

