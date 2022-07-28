%15/12/2017
%Diogo Martins Alves N� 86980
%Jo�o Santiago Silva N� 84081
%Andr� Lopes N� 84004

function r = Romberg( j , k , f , a , b )
    
    if k == 0 %condi��o de paragem
        m = 2.^j;
        h = (b-a)/m;
        sum = f(a) + f(b);
        for i = 1:m-1
            sum = sum + 2*f(a + i*h);
        end
        r = sum *(h/2); %regra dos trap�zios composta
    else
        r = (4.^k * Romberg( j , k-1 , f , a , b ) - Romberg( j-1 , k-1 , f , a , b ))/(4.^k - 1); %chamadas recursivas � fun��o
    end


end

