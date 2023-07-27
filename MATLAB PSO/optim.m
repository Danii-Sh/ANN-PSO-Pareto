clear;
clc;


% fun2 = @(x) (x(3)-x(1)-x(2)-5).^2;
% rng default  % For reproducibility
% nvars = 3;
% lb = [-10;-10;-10];
% ub = [12;72;108];
% x = particleswarm(fun2,nvars,lb,ub)


% load 'dadehanet.mat';

% fun3 = @(x)(sim(netgear,[x(1);x(2);x(3)]));
% zz = sim (netgear,[50;325;0.085])
% zz(1)



nvars = 3;
lb = [45;300;0.08];
ub = [100;500;0.12];
options = optimoptions('particleswarm');
options.Display = 'iter';
options.MaxIter = 10;
%options.PlotFcn = {@optimplotfval;@optimplotx};


[x,fval]= particleswarm(@fun,nvars,lb,ub,options);
x,fval

save optbfc