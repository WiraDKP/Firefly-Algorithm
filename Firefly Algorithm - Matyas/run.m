clear;
clf;

problem = @(x) problemfunc(x);
nvar = 2;

bound.xmin = -10;
bound.xmax = 10;

param.itermax = 75;
param.npop = 50;
param.gamma = 1;
param.beta0 = 1;
param.alpha = 0.2;
param.damp = 0.9;
param.scale = (bound.xmax-bound.xmin);

FA(problem, nvar, bound, param)

% [X,Y] = meshgrid(bound.xmin:0.01:bound.xmax, bound.xmin:0.01:bound.xmax);
% surf(X,Y,0.26*(X.^2 + Y.^2)-0.48*X.*Y, 'EdgeColor','none');
% view(-15,15); saveas(gcf, 'Matyas2.png');