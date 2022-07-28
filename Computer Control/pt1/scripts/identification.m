clear
clc
close all
warning('off')
count = 0;
load('barrassmodel.mat');
T = 120;
f = 0.4;

for fs = [50 100 200]; 
    t = (0:1/fs:T)';
    
    u = idinput(length(t),'prbs',[0 0.01]);
    
    sim('SYS');
    us2 = simout.signals.values(:,2);
    ys2 = simout.signals.values(:,1);
    ts2 = simout.time;

    u = square(2*pi*f*t);
    sim('SYS');
    us1 = simout.signals.values(:,2);
    ys1 = simout.signals.values(:,1);
    ts1 = simout.time;

    utrend1=us1;
    ytrend1=ys1;

    utrend2=us2;
    ytrend2=ys2;
    
    t1 = ts1;
    t2 = ts2;

    % burn in and detrend
    ytrend1(1:10*fs)=[];
    ytrend2(1:10*fs)=[];
    utrend1(1:10*fs)=[];
    utrend2(1:10*fs)=[];
    t1(1:10*fs)=[];
    t2(1:10*fs)=[];

    u1 = detrend(utrend1);
    u2 = detrend(utrend2);
    y1 = detrend(ytrend1);
    y2 = detrend(ytrend2);

    for af = [0.85 0.9 0.95]
        Afilt = [1 -af];
        Bfilt = (1-af)*[1 -1];
        % Filtering
        yf1 = filter(Bfilt,Afilt,y1);
        yf2 = filter(Bfilt,Afilt,y2);
        z1 = [yf1 u1];
        z2 = [yf2 u2];

        for na = [1 2 3 4]
            for nb = [1 2 3] 
                for nk = [1 2 3]
                    nc = na;
                    count = count +1;
                    if na < nk+nb-1
                        continue;
                    end
                    nn = [na nb nc nk];
                    th = armax(z1,nn); % th is a structure in identification toolbox format
                    [den1,num1] = polydata(th);
                    [num,den] = eqtflength(num1,conv(den1,[1 -1]));

                    [A,B,C,D] = tf2ss(num,den);

                    [~,fit_train] = compare(z1,th);
                    [~,fit_test] = compare(z2,th);
                    yfsim1 = filter(num1,den1,u1); % Equivalent to idsim(u1,th);
                    yfsim2 = filter(num1,den1,u2); % Equivalent to idsim(u1,th);

                    if(fit_test > 78)
                        fprintf('----->');
                        
                        s1=sprintf('%d fit test = %.2f, fit train = %.2f, f_s = %d, lambda = %.2f, nA = %d ,nB = %d, nC= %d, nK = %d\n',count,fit_test,fit_train,fs,af,na,nb,nc,nk);
                        s=sprintf('f_s = %d, lambda = %.2f, nA = %d ,nB = %d, nC= %d, nK = %d',fs,af,na,nb,nc,nk);
                        fprintf(s1);
                        figure()
                        
                        
                        subplot(3,1,1);
                        zplane(num1,den1);
                        
                        title(s);
                        
                        subplot(3,1,2);
                        hold on;
                        gg=plot(t1,yf1,'b');
                        set(gg,'LineWidth',1.5);
                        gg=plot(t1,yfsim1,'r');
                        set(gg,'LineWidth',1.5);
                        hold off;
                        
                        title('Train Signal');
                        legend('Real Output','Model Output');

                        subplot(3,1,3);
                        hold on;
                        gg=plot(t2,yf2,'b');
                        set(gg,'LineWidth',1.5);
                        gg=plot(t2,yfsim2,'r');
                        set(gg,'LineWidth',1.5);
                        hold off;

                        title('Test Signal');
                        legend('Real Output','Model Output');
                        
                        

                        
                        
                        
                    end

                end
            end
        end
    end
end


