%15/12/2017
%Diogo Martins Alves Nº 86980
%João Santiago Silva Nº 84081
%André Lopes Nº 84004

function r = Romberg( j , k , f , a , b )
    
    if k == 0 %condição de paragem
        m = 2.^j;
        h = (b-a)/m;
        sum = f(a) + f(b);
        for i = 1:m-1
            sum = sum + 2*f(a + i*h);
        end
        r = sum *(h/2); %regra dos trapézios composta
    else
        r = (4.^k * Romberg( j , k-1 , f , a , b ) - Romberg( j-1 , k-1 , f , a , b ))/(4.^k - 1); %chamadas recursivas à função
    end


end

