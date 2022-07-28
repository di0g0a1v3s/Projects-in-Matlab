%% Runing Simulink from the command line
% Here are just illustrated linear systems, but one can improve as needed
% the Simulink system

% Oct2018, JG

%% First simulation
num= 1;
den= [1 1 1];
[t,~,y]= sim( 'simulink_demo_diagr' );
figure(101)
plot(t,y, '.-')
title('Step response along time')

%% Second simulation, multiple wn values
figure(102); clf; hold on
csi= sqrt(2)/2;
for wn= [1 2 10]
    % define variables for the simulink file
    num= wn^2;
    den= [1 2*csi*wn wn^2];
    [t,~,y]= sim( 'simulink_demo_diagr' );
    plot(t,y, '.-')
end
title('Step response along time')
