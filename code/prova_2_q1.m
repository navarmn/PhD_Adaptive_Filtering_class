clc; close all; clear all
addpath('utils')
%%
N = 10000
M =  4; 
data = randi([0 1],N*2,1);
y = qammod(data,M ,'InputType','bit','UnitAveragePower',true);


Numerators1 =  [-0.27 0.34] ;
Denominator1 = [1];

Numerators2 =  [0.43 0.87] ;
Denominator2 = [1];

Numerators3 =  [-0.21 0.34] ;
Denominator3 = [1];

yF = filter(Numerators1,Denominator1,y,[],2);
yF2 = filter(Numerators2,Denominator2,yF,[],2);
DesiredSignal = filter(Numerators3,Denominator3,yF2,[],2);

[U,S,V] = svd(autocorr(DesiredSignal));

FilterSize = 10 

C = U(1:FilterSize,1:FilterSize,1);

NoiseSignal = awgn(DesiredSignal,20,'measured'); 

rls1 = dsp.RLSFilter(FilterSize, 'ForgettingFactor', 0.97,'InitialInverseCovariance',C);

[SystemOutput,e] = rls1(NoiseSignal,DesiredSignal);

mean(abs(e))


%% Plots:
% Signal with noise:
% figure_preset()

scatterplot(NoiseSignal)

figure_postset('In-phase', 'Quadrature', 'Title', 'Noise signal')

saveFig_eps(['q01-noised-' num2str(N)])
%%

% Signal with noise:
% figure_preset()

scatterplot(SystemOutput)

figure_postset('In-phase', 'Quadrature', 'Title', 'Output')

saveFig_eps(['q01-output-' num2str(N)])
%%
% Signal with noise:
% figure_preset()
 
fig = scatterplot(DesiredSignal)

figure_postset('In-phase', 'Quadrature', 'Title', 'Desired signal')

saveFig_eps(['q01-desired-' num2str(N)])

%%
% Error
figure_preset()

plot(abs(e)) 

figure_postset('Iteration', '$E^2$', 'Title', 'Error')

saveFig_eps(['q01-error-' num2str(N)])












