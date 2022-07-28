%15/12/2017
%Diogo Martins Alves Nº 86980
%João Santiago Silva Nº 84081
%André Lopes Nº 84004

%A imagem é constituida por quatro quadrantes, todos eles simétricos entre si, pelo que só é preciso calcular valores para um
r_max = 10E-6; %distância do centro da imagem até às bordas
lambda = 500E-9; %comprimento de onda
step = 200; %número de pixels em horizontal/verticalmente num quadrante
i_m = 0.00000015; %variável para a função de escala
i_M = 0.01; %variável para a função de escala
K = 2*pi/lambda;
l = @(r)(J(1, K * r)/(K*r)).^2; %função de difração da luz
y = zeros(2*step, 2*step, 3); %inicialização da matriz rgb
for i=0:step
    for j=0:step
		%quandrante superior esquerdo
        r = sqrt((r_max*(step-i)/step).^2 + (r_max*(step-j)/step).^2); %distância ao centro da imagem
        y(i+1,j+1,1) = log(l(r)/i_m)/log(i_M/i_m); %função de escala
        y(i+1,j+1,2) =  y(i+1,j+1,1); %green = red
        y(i+1,j+1,3) =  y(i+1,j+1,1); %blue = red
        %quadrante superior direito
        y(2*step - (i+1), j+1,1) = y(i+1,j+1,1);
        y(2*step - (i+1), j+1,2) = y(i+1,j+1,1);
        y(2*step - (i+1), j+1,3) = y(i+1,j+1,1);
        %quadrante inferior esquerdo
        y((i+1),2*step -  (j+1),1) = y(i+1,j+1,1);
        y((i+1),2*step -  (j+1),2) = y(i+1,j+1,1);
        y((i+1),2*step -  (j+1),3) = y(i+1,j+1,1);
        %quadrante inferior direito
        y(2*step - (i+1),2*step -  (j+1),1) = y(i+1,j+1,1);
        y(2*step - (i+1),2*step -  (j+1),2) = y(i+1,j+1,1);
        y(2*step - (i+1),2*step -  (j+1),3) = y(i+1,j+1,1);
    end
end
figure
imshow(y); %plot da imagem