%15/12/2017
%Diogo Martins Alves N� 86980
%Jo�o Santiago Silva N� 84081
%Andr� Lopes N� 84004

function b= J(m,x)
    %Fun��o de Bessel
    g = @(t) cos(x*sin(t)-m*t); %fun��o a integrar
    b=(1/pi)*Romberg(10,1,g,0,pi); %aproxima��o do integral pelo m�todo de Simpson (k=1) com 2^10 = 1024 sub-intervalos
end