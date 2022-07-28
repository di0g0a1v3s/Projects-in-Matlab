%15/12/2017
%Diogo Martins Alves Nº 86980
%João Santiago Silva Nº 84081
%André Lopes Nº 84004

function b= J(m,x)
    %Função de Bessel
    g = @(t) cos(x*sin(t)-m*t); %função a integrar
    b=(1/pi)*Romberg(10,1,g,0,pi); %aproximação do integral pelo método de Simpson (k=1) com 2^10 = 1024 sub-intervalos
end