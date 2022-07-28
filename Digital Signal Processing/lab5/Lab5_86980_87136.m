%LAB 5 PDS
%86980   Diogo Martins Alves
%87136	Xavier Abreu Dias

close all
clear all
clc
%% R1.b)
image = load('sar_image.mat');
figure()
imagesc(image.I)
colormap default
title('R1.b) Imagem "sar-image", onde s�o visiveis zonas de �gua e de gelo');

%% R1.c)
water = imcrop(image.I,[280 0 280 320]);
figure()
imagesc(water)
colormap default
title('R1.c) "Crop" da imagem original a uma zona com �gua');

count = 0;
sum_sq = 0;
avg = mean(mean(water));
mu_water = avg;
beta_water = avg;
sigma_sq_water = 0;
for row = 1:size(water,1)
    for col = 1:size(water,2)
        count = count + 1;
        sum_sq = sum_sq + water(row,col)^2;
        sigma_sq_water = sigma_sq_water + (water(row,col) - mu_water)^2;
    end
end
f_water = (sum_sq/count)/2;
sigma_sq_water = sigma_sq_water/count;

fprintf('Par�metros para �gua: \n(Exponencial) beta=%d \n(Rayleigh) f=%d \n(Normal) mu=%d, sigma_squared=%d\n\n',beta_water,f_water,mu_water,sigma_sq_water)

ice = imcrop(image.I,[0 220 220 160]);
figure()
imagesc(ice)
colormap default
title('R1.c) "Crop" da imagem original a uma zona com gelo');

count = 0;
sum_sq = 0;
avg = mean(mean(ice));
mu_ice = avg;
beta_ice = avg;
sigma_sq_ice = 0;
for row = 1:size(ice,1)
    for col = 1:size(ice,2)
        count = count + 1;
        sum_sq = sum_sq + ice(row,col)^2;
        sigma_sq_ice = sigma_sq_ice + (ice(row,col) - mu_ice)^2;
    end
end
f_ice = (sum_sq/count)/2;
sigma_sq_ice = sigma_sq_ice/count;
fprintf('Par�metros para gelo: \n(Exponencial) beta=%d \n(Rayleigh) f=%d \n(Normal) mu=%d, sigma_squared=%d\n',beta_ice,f_ice,mu_ice,sigma_sq_ice)


%% R1.d)
x = [0:1:40000];
figure()
histogram(water,'Normalization','pdf', 'BinLimits',[0,40000])
hold on
plot(x,exppdf(x,beta_water),'LineWidth',2);
hold on
plot(x,raylpdf(x,sqrt(f_water)),'LineWidth',2);
hold on
plot(x,normpdf(x,mu_water,sqrt(sigma_sq_water)),'LineWidth',2);
legend('Histograma','Exponencial','Rayleigh','Normal');
title('R1.d) Histograma e distribui��es para �gua');


x = [0:1:450000];
figure()
histogram(ice,'Normalization','pdf', 'BinLimits',[0,450000])
hold on
plot(x,exppdf(x,beta_ice),'LineWidth',2);
hold on
plot(x,raylpdf(x,sqrt(f_ice)),'LineWidth',2);
hold on
plot(x,normpdf(x,mu_ice,sqrt(sigma_sq_ice)),'LineWidth',2);
legend('Histograma','Exponencial','Rayleigh','Normal');
title('R1.d) Histograma e distribui��es para gelo');

%% R2.a) Segmenta��o da imagem

% Probabilidade de um pixel para a distribui��o Rayleigh:
% p(xi,f) = (xi/f) * e^(-xi^2/(2f))
% Vai-se comparar a probabilidade de um pixel ser da �gua ou do gelo.
% Ser� feita a segmenta��o para o gelo e �gua.

ice_region1 = zeros(size(image.I,1),size(image.I,2));
water_region1 = zeros(size(image.I,1),size(image.I,2));

for row = 1:size(image.I,1)    
    for col = 1:size(image.I,2)
        
        pixel = image.I(row,col);
        
        p_ice = pixel/f_ice * exp(-pixel^2/(2*f_ice));
        p_water = pixel/f_water * exp(-pixel^2/(2*f_water));
        if(p_ice > p_water)
            ice_region1(row,col) = pixel;
        else
            water_region1(row,col) = pixel;
        end     
    end
end

figure()
imagesc(image.I)
hold on
colormap default
imcontour(ice_region1);
hold on 
imcontour(water_region1);
title('R2.a) Imagem "sar-image", com segmenta��o da regi�o do gelo e da �gua');

%% R2.b)

% Extra��o dos pacotes de 9x9
patchSize = [9 9];
ice_region2 = zeros(size(image.I,1),size(image.I,2));
water_region2 = zeros(size(image.I,1),size(image.I,2));

for row = 1:patchSize(2):length(image.I(:,1))-patchSize(2)
    for col = 1:patchSize(1):length(image.I(1,:))-patchSize(1)
        patch = imcrop(image.I,[col, row, patchSize(1)-1, patchSize(2)-1]);
        hold on
        
        % S^2
        S_sq = 0;
        for row_p = 1:size(patch,1)
            for col_p = 1:size(patch,2)
              S_sq = S_sq + patch(row_p,col_p)^2;
            end        
        end 
        S_sq = S_sq/patchSize(1)^2;
        
        % Probabilidade de um conjunto de pixeis para a distribui��o Rayleigh
        % l(xi,f) = C - N*log(f) - (N*S^2)/(2*f)
        p_ice = -log(f_ice) - S_sq/(2*f_ice);
        p_water = -log(f_water) - S_sq/(2*f_water);
        if(p_ice > p_water)
            ice_region2(row:row+patchSize(1)-1,col:col+patchSize(1)-1) = patch;
        else
            water_region2(row:row+patchSize(1)-1,col:col+patchSize(1)-1) = patch;
        end    
        
    end 
end

figure()
imagesc(image.I)
hold on
colormap default
imcontour(ice_region2);
hold on 
imcontour(water_region2);
ttl = sprintf('R2.b) Imagem "sar-image", com segmenta��o da regi�o do gelo e da �gua,\n com patches de 9x9 px');
title(ttl);

%% R2.c)
% Para determinar o limiar de classifica��o de um pixel, recorreu-se �
% determina��o da interse��o das distribui��es das intensidades do gelo e
% da �gua
x = [10000:1:20000];
figure()
plot(x,raylpdf(x,sqrt(f_ice)),'LineWidth',2) 
hold on
plot(x,raylpdf(x,sqrt(f_water)),'LineWidth',2);
legend('Distribui��o Rayleigh para o gelo','Distribui��o Rayleigh para a �gua');
grid on
ttl = sprintf('R2.c) Determina��o da interse��o entre as distribui��es\n de intensidade da �gua e do gelo');
title(ttl);

% Ap�s a an�lise da figura, determinou-se a interse��o das duas 
% distribui��es. A interse��o ocorre em para um n�vel de intensidade 
% aproximadamente igual a 15880.
% Assim pode-se fazer a classifica��o com este limiar e fazer a
% segmenta��o.
threshold = 15880;

ice_region3 = zeros(size(image.I,1),size(image.I,2));
water_region3 = zeros(size(image.I,1),size(image.I,2));

for row = 1:size(image.I,1)    
    for col = 1:size(image.I,2)
        
        pixel = image.I(row,col);
        
        if(pixel > threshold)
            ice_region3(row,col) = pixel;
        else
            water_region3(row,col) = pixel;
        end        
    end
end

figure()
imagesc(image.I)
hold on
colormap default
imcontour(ice_region3);
hold on 
imcontour(water_region3);
ttl = sprintf('R2.c) Imagem "sar-image", com segmenta��o da regi�o do gelo e da �gua,\n com classifica��o atrav�s de um limar de intensidade de 15880');
title(ttl);

%% R2.d)

% Para determinar a frequ�ncia de decis�es corretas que cada abordagem de
% segmenta��o tem, � necess�rio fazer uma compara��o pixel a pixel entre a
% imagem original e a segmentada.
% Ora como se decidiu apenas fazer uma segmenta��o ao classificar os pixeis
% como sendo gelo ou �gua, o que implica ter na imagem segmentada 
% valores nulos para pixeis classificados como sendo 'n�o gelo' ou 'n�o �gua', ent�o � s�
% ness�rio verificar para os valores n�o nulos de cada imagem segmentada.

% N�mero de decis�es corretas
ndc1 = 0;
ndc2 = 0;
ndc3 = 0;

for row = 1:size(image.I,1)    
    for col = 1:size(image.I,2) 
        p = image.I(row,col);
        
        % Abordagem 1
        ice_p1 = ice_region1(row,col);
        water_p1 = water_region1(row,col);
        if(ice_p1 ~= 0)
            if(abs(ice_p1-p) < 0.0001)
                ndc1 = ndc1 + 1;
            end
        elseif(water_p1 ~= 0) 
            if(abs(water_p1-p) < 0.0001)
                ndc1 = ndc1 + 1;
            end
        end
        
        % Abordagem 2
        ice_p2 = ice_region2(row,col);
        water_p2 = water_region2(row,col);
        if(ice_p2 ~= 0)
            if(abs(ice_p2-p) < 0.0001)
                ndc2 = ndc2 + 1;
            end
        elseif(water_p2 ~= 0) 
            if(abs(water_p2-p) < 0.0001)
                ndc2 = ndc2 + 1;
            end
        end
        
        % Abordagem 3
        ice_p3 = ice_region3(row,col);
        water_p3 = water_region3(row,col);
        if(ice_p3 ~= 0)
            if(abs(ice_p3-p) < 0.0001)
                ndc3 = ndc3 + 1;
            end
        elseif(water_p3 ~= 0) 
            if(abs(water_p3-p) < 0.0001)
                ndc3 = ndc3 + 1;
            end
        end
    end
end
N = size(image.I,1)*size(image.I,2);
rdc1 = ndc1/N;
rdc2 = ndc2/N;
rdc3 = ndc3/N;
fprintf('\nFrequ�ncia de decis�es corretas: \n-Abordagem 1: %d \n-Abordagem 2: %d \n-Abordagem 3: %d\n',rdc1, rdc2, rdc3);
