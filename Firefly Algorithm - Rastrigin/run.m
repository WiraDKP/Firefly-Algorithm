clear;
clf;

problem = @(x) problemfunc(x);
nvar = 2;

bound.xmin = -5;
bound.xmax = 5;

param.itermax = 75;
param.npop = 50;
param.gamma = 1;
param.beta0 = 1;
param.alpha = 0.2;
param.damp = 0.9;
param.scale = (bound.xmax-bound.xmin);

FA(problem, nvar, bound, param)

% [X,Y] = meshgrid(bound.xmin:0.01:bound.xmax, bound.xmin:0.01:bound.xmax);
% A = 10;
% surf(X,Y,A*nvar + X.^2 - A*cos(2*pi.*X) + Y.^2 - A*cos(2*pi.*Y), 'EdgeColor','none');
% view(-65,-20); saveas(gcf, 'Rastrigin2.png');