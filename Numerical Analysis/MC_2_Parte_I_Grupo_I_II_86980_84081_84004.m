%15/12/2017
%Diogo Martins Alves N� 86980
%Jo�o Santiago Silva N� 84081
%Andr� Lopes N� 84004

display('Insira os dados de entrada (fun��o f:[a,b]->IR e um natural n):');
str = (input('Fun��o f(x) = ', 's'));%fun��o a estudar (string) ex: x.^-2
f = inline(str, 'x');%converte a string para uma fun��o do matlab
a = input('Extremo inferior do intervalo a = ');
b = input('Extremo superior do intervalo b = ');
n = input('N�mero natural n = ');

h = (b-a)/n;
sum = f(a) + f(b);
for i = 1:n-1
    sum = sum + 2*f(a + i*h);
end
integral = sum *(h/2); %regra dos trap�zios composta
fprintf('Integral = %.20f\n', integral);

