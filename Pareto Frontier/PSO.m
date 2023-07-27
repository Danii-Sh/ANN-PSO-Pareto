
function [ GBEST ,  cgCurve ] = PSO ( noP, maxIter,  problem, dataVis )

% Define the details of the objective function
nVar = problem.nVar;
ub = problem.ub;
lb = problem.lb;
fobj = problem.fobj;

% Extra variables for data visualization
average_objective = zeros(1, maxIter);
cgCurve = zeros(1, maxIter);
FirstP_D1 = zeros(1 , maxIter);
position_history = zeros(noP , maxIter , nVar );

% Define the PSO's paramters
wMax = 0.9;
wMin = 0.2;
c1 = 2;
c2 = 2;
vMax = (ub - lb) .* 0.2;
vMin  = -vMax;

% The PSO algorithm

% Initialize the particles
for k = 1 : noP
    Swarm.Particles(k).X = (ub-lb) .* rand(1,nVar) + lb;
    Swarm.Particles(k).V = zeros(1, nVar);
    Swarm.Particles(k).PBEST.X = zeros(1,nVar);
    Swarm.Particles(k).PBEST.O = inf;
    
    Swarm.GBEST.X = zeros(1,nVar);
    Swarm.GBEST.O = inf;
end


% Main loop
for t = 1 : maxIter
    
    % Calcualte the objective value
    for k = 1 : noP
        
        currentX = Swarm.Particles(k).X;
        position_history(k , t , : ) = currentX;
        
        
        Swarm.Particles(k).O = fobj(currentX);
        average_objective(t) =  average_objective(t)  + Swarm.Particles(k).O;
        
        % Update the PBEST
        if Swarm.Particles(k).O < Swarm.Particles(k).PBEST.O
            Swarm.Particles(k).PBEST.X = currentX;
            Swarm.Particles(k).PBEST.O = Swarm.Particles(k).O;
        end
        
        % Update the GBEST
        if Swarm.Particles(k).O < Swarm.GBEST.O
            Swarm.GBEST.X = currentX;
            Swarm.GBEST.O = Swarm.Particles(k).O;
        end
    end
    
    % Update the X and V vectors
    w = wMax - t .* ((wMax - wMin) / maxIter);
    
    FirstP_D1(t) = Swarm.Particles(1).X(1);
    
    for k = 1 : noP
        Swarm.Particles(k).V = w .* Swarm.Particles(k).V + c1 .* rand(1,nVar) .* (Swarm.Particles(k).PBEST.X - Swarm.Particles(k).X) ...
            + c2 .* rand(1,nVar) .* (Swarm.GBEST.X - Swarm.Particles(k).X);
        
        
        % Check velocities
        index1 = find(Swarm.Particles(k).V > vMax);
        index2 = find(Swarm.Particles(k).V < vMin);
        
        Swarm.Particles(k).V(index1) = vMax(index1);
        Swarm.Particles(k).V(index2) = vMin(index2);
        
        Swarm.Particles(k).X = Swarm.Particles(k).X + Swarm.Particles(k).V;
        
        % Check positions
        index1 = find(Swarm.Particles(k).X > ub);
        index2 = find(Swarm.Particles(k).X < lb);
        
        Swarm.Particles(k).X(index1) = ub(index1);
        Swarm.Particles(k).X(index2) = lb(index2);
        
    end
    
    if dataVis == 1
        outmsg = ['Iteration# ', num2str(t) , ' Swarm.GBEST.O = ' , num2str(Swarm.GBEST.O)];
        disp(outmsg);
    end
    
    cgCurve(t) = Swarm.GBEST.O;
    average_objective(t) = average_objective(t) / noP;
    
    %fileName = ['Resluts after iteration # ' , num2str(t)];
    %save( fileName)
end

GBEST = Swarm.GBEST;

if dataVis == 1
    iterations = 1: maxIter;
    

%% Visualize the cgcurve    
    subplot(1,4,1);
    semilogy(iterations , cgCurve, 'r');
    title('Convergence curve')
    xlabel('Iteration#')
    ylabel('Weight')
    
%% Visualize the average objectives
    subplot(1,4,2)
    semilogy(iterations , average_objective , 'g')
    title('Average objecitves of all particles')
    xlabel('Iteration#')
    ylabel('Average objective')
    
 %% Visualize the fluctuations 
    subplot(1,4,3)   
    plot(iterations , FirstP_D1, 'k');
    title('First dimention in first Particle')
    xlabel('Iteration#')
    ylabel('Value of the first dimension')
    
 %% Visualize the search history
    subplot(1,4,4)
    hold on
    for p = 1 : noP
        for t = 1 : maxIter
            x = position_history(p, t , 1);
            y = position_history(p, t , 2);
            myColor = [0+t/maxIter  0 1-t/maxIter ];
            plot(x , y , '.' , 'color' , myColor );
        end
    end
%    contour(x_new , y_new , z);
    plot(Swarm.GBEST.X(1) , Swarm.GBEST.X(2) , 'og');
    xlim([lb(1) , ub(1)])
    ylim([lb(2) , ub(2) ])
    title('search history')
    xlabel('x')
    ylabel('y')
    box on
    
    set(gcf , 'position' , [128         372        1634         259])
    
    
    
    
end