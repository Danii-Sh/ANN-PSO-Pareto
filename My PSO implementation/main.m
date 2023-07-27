clear 
close all
clc

% Problem preparation 
problem.nVar = 3;
%problem.ub = 50 * ones(1, 3);
problem.ub = [50,50,50];
problem.lb = [-50,-50,-50];

problem.fobj = @ObjectiveFunction;

% PSO parameters 
noP = 10;
maxIter = 50;
visFlag = 1; % set this to 0 if you do not want visualization

RunNo  = 30; 
BestSolutions_PSO = zeros(1 , RunNo);


 [ GBEST  , cgcurve ] = PSO( noP , maxIter, problem , visFlag ) ;
 
 disp('Best solution found')
 GBEST.X
 disp('Best objective value')
 GBEST.O
