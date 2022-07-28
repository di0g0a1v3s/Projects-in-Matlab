%% -- script: nonlinear_vs_linearized_main.m
% Oct2018 JG

% Basic parameters (do not change)
parA =  10;
parG =  10;
parC =  1e-03;

%% Particular equilibrium point (edit at your own will)

% equilibrium point
parHeq = 5;
parMeq = .25;
parPeq = 5;

% transfer functions G1=K1*p/(s+p), G2=K2*p/(s+p)
par_p = 1/400;
parK1 = -4;
parK2 = 40;

% define the step inputs
if ~exist('delta_r','var'), delta_r= 0.1; end
if ~exist('delta_d','var'), delta_d= 0.0; end

% run the simulation
[t,~,y] = sim('nonlinear_vs_linearized');

% do the plot (do not forget to add commands xlabel, ylabel, legend)
plot( t, y, '.-' );
