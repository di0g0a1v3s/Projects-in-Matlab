%15/12/2017
%Diogo Martins Alves Nº 86980
%João Santiago Silva Nº 84081
%André Lopes Nº 84004

display('Insira os dados de entrada (função f:[a,b]->IR e um natural n):');
str = (input('Função f(x) = ', 's'));%função a estudar (string) ex: x.^-2
f = inline(str, 'x');%converte a string para uma função do matlab
a = input('Extremo inferior do intervalo a = ');
b = input('Extremo superior do intervalo b = ');
n = input('Número natural n = ');

h = (b-a)/n;
sum = f(a) + f(b);
for i = 1:n-1
    sum = sum + 2*f(a + i*h);
end
integral = sum *(h/2); %regra dos trapézios composta
fprintf('Integral = %.20f\n', integral);

