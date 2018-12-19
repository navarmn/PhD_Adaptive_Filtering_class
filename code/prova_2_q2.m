clc; close all; clear all
addpath('utils')
addpath(genpath('kernelfiltering-toolbox'))
%% SIMULATION PARAMETERS

KERNEL = 'gauss'
KERNEL_WIDTH = 2

%% Create signal
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

%%
%
% This file is part of the Kernel Adaptive Filtering Toolbox for Matlab.
% https://github.com/steven2358/kafbox/

% [X,Y] = kafbox_data(struct('name','Lorenz','embedding',6));
X = NoiseSignal
Y = DesiredSignal

% make a kernel adaptive filter object of class krls with options: 
% ALD threshold 1E-4, Gaussian kernel, and kernel width 32
kaf = krls(struct('nu',1E-4, 'kerneltype','gauss','kernelpar', KERNEL_WIDTH));

%% RUN ALGORITHM
N = size(X,1);
Y_est = zeros(N,1);
for i=1:N,
    if ~mod(i,floor(N/10)), fprintf('.'); end % progress indicator, 10 dots
    Y_est(i) = kaf.evaluate(X(i,:)); % predict the next output
    kaf.train(X(i,:),Y(i)); % train with one input-output pair
end
fprintf('\n');
SE = (Y-Y_est).^2; % test error

%% OUTPUT
fprintf('MSE after first 10000 samples: %.2fdB\n\n',10*log10(mean(SE(1001:end))));


%% Plot images:

%Input:
% 
% scatterplot(Y)
% 
% figure_postset('In-phase', 'Quadrature', 'Title', 'Output')
% 
% saveFig_eps(['q02-output-' num2str(N),'-' num2str(KERNEL), '-', num2str(KERNEL_WIDTH)])

% Predicted
scatterplot(Y_est)

figure_postset('In-phase', 'Quadrature', 'Title', 'Estimated')

saveFig_eps(['q02-estimated-' num2str(N),'-' num2str(KERNEL), '-', num2str(KERNEL_WIDTH)])
















