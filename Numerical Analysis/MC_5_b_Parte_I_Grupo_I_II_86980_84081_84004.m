%15/12/2017
%Diogo Martins Alves N� 86980
%Jo�o Santiago Silva N� 84081
%Andr� Lopes N� 84004

%A imagem � constituida por quatro quadrantes, todos eles sim�tricos entre si, pelo que s� � preciso calcular valores para um
r_max = 10E-6; %dist�ncia do centro da imagem at� �s bordas
lambda = 500E-9; %comprimento de onda
step = 200; %n�mero de pixels em horizontal/verticalmente num quadrante
i_m = 0.00000015; %vari�vel para a fun��o de escala
i_M = 0.01; %vari�vel para a fun��o de escala
K = 2*pi/lambda;
l = @(r)(J(1, K * r)/(K*r)).^2; %fun��o de difra��o da luz
y = zeros(2*step, 2*step, 3); %inicializa��o da matriz rgb
for i=0:step
    for j=0:step
		%quandrante superior esquerdo
        r = sqrt((r_max*(step-i)/step).^2 + (r_max*(step-j)/step).^2); %dist�ncia ao centro da imagem
        y(i+1,j+1,1) = log(l(r)/i_m)/log(i_M/i_m); %fun��o de escala
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