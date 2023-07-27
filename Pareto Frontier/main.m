clear 
close all
clc

% Problem preparation 
problem.nVar = 3;
%problem.ub = 50 * ones(1, 3);
problem.lb = [45,300,0.08];
problem.ub = [100,500,0.12];



problem.fobj = @ObjectiveFunction;

% PSO parameters 
noP = 3;
maxIter = 20;
visFlag = 0; % set this to 0 if you do not want visualization

RunNo  = 30; 
BestSolutions_PSO = zeros(1 , RunNo);


load 'dadehanet.mat';
resolution = 50;
dim = 1;
points = zeros(3*resolution,3);
problem.fobj = @Objective1;
for res = 1 : resolution
[ GBEST  , cgcurve ] = PSO( noP , maxIter, problem , visFlag ) ;
%disp('Best solution found');
GBEST.X;
%disp('Best objective value');
GBEST.O;
hkk = sim(netgear,[GBEST.X(1);GBEST.X(2);GBEST.X(3)]);
points(res,1) = hkk(1);
points(res,2) = hkk(2);
points(res,3) = hkk(3);
end
disp('first dimension ended');
dim = 2;
problem.fobj = @Objective2;
for res = 1 : resolution
[ GBEST  , cgcurve ] = PSO( noP , maxIter, problem , visFlag ) ;
%disp('Best solution found');
GBEST.X;
%disp('Best objective value');
GBEST.O;
hkk = sim(netgear,[GBEST.X(1);GBEST.X(2);GBEST.X(3)]);
points(res+resolution,1) = hkk(1);
points(res+resolution,2) = hkk(2);
points(res+resolution,3) = hkk(3);
end
disp('second dimension ended');
dim = 3;
problem.fobj = @Objective3;
 for res = 1 : resolution
[ GBEST  , cgcurve ] = PSO( noP , maxIter, problem , visFlag ) ;
%disp('Best solution found');
GBEST.X;
%disp('Best objective value');
GBEST.O;
hkk = sim(netgear,[GBEST.X(1);GBEST.X(2);GBEST.X(3)]);
points(res+2*resolution,1) = hkk(1);
points(res+2*resolution,2) = hkk(2);
points(res+2*resolution,3) = hkk(3);
end
disp('third dimension ended');
 figure
 %points(:,1)
 scatter3(points(:,1),points(:,2),points(:,3))
 

 figure
 %points(:,1)
 scatter(points(:,1),points(:,2))
 
  figure

 scatter(points(:,1),points(:,3))
 
  figure

 scatter(points(:,2),points(:,3))
 
%figure
%[X,Y,Z] = sphere(16);
%x = [0.5; 0.75; 1];
%y = [1.5; 0.75; 2];
%z = [0.3; 0.9; 1.5];
%scatter3(x,y,z)
%a = [1,1,1]
%scatter3(a(1),a(2),a(3))
 
 
