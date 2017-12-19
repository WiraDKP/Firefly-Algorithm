function [bestff, mincost] = FA(problem, nvar, bound, param)

    func = problem;
    varsize = [1 nvar]; 
    
    itermax = param.itermax;
    npop = param.npop;
    gamma = param.gamma;
    b0 = param.beta0;
    alpha = param.alpha;
    damp = param.damp;
    scale = param.scale;
    
    xmin = bound.xmin;
    xmax = bound.xmax;
    
    globest.cost = inf;
    
    init.loc = [];
    init.cost = [];

    ff = repmat(init, npop, 1);

    % Initiate fireflies
    for i = 1:npop
        ff(i).loc = unifrnd(xmin, xmax, varsize);
        ff(i).cost = func(ff(i).loc);

        if ff(i).cost < globest.cost
            globest = ff(i);
        end
    end

    bestcost = zeros(itermax,1);
    
    tempX = zeros(itermax,npop);
    tempY = zeros(itermax,npop);
    
    for iter = 1:itermax
        [X,Y] = meshgrid(xmin:0.1:xmax, xmin:0.1:xmax);
        contour(X,Y,3*(1-X).^2.*exp(-(X.^2) - (Y+1).^2) - 10*(X/5 - X.^3 - Y.^5).*exp(-X.^2-Y.^2) ... 
                - 1/3*exp(-(X+1).^2 - Y.^2), 25); hold on;
        scatter(0.2283,-1.6255,35,'ok','filled');
        title('MATLAB Peaks Function');
        
        for i = 1:npop
            newff(i).cost = inf;
            for j = 1:npop
                if ff(j).cost < ff(i).cost
                    distance = norm (ff(i).loc - ff(j).loc);                 
                    new.loc = min(max(ff(i).loc + b0*exp(-gamma*distance.^2).*(ff(j).loc-ff(i).loc) + alpha*scale*unifrnd(-1,1,varsize),xmin),xmax);
                    new.cost = func(new.loc);
                    if new.cost < newff(i).cost
                        newff(i).loc = new.loc;
                        newff(i).cost = new.cost;                        
                        if newff(i).cost < globest.cost
                            globest = newff(i);
                        end
                    end
                end
            end          
        end
        
        % Choose first npop of best fireflies
        ff=[ff ; newff'];
        [~, order]=sort([ff.cost]);
        ff=ff(order);
        ff=ff(1:npop);
        
        for i = 1:npop
            tempX(iter,i) = ff(i).loc(1);
            tempY(iter,i) = ff(i).loc(2);  
        end
        scatter(tempX(iter,:),tempY(iter,:),'or','filled');
        frame(iter) = getframe(gcf); pause(0.0001);
        hold off;
        
        bestcost(iter) = globest.cost;


        disp(['Iteration ' num2str(iter) ' | Minimum cost = ' num2str(bestcost(iter))] );
        alpha = alpha.*damp;
    end
    
    name = ['Peaks pop=' num2str(npop)];
    video = VideoWriter(name,'MPEG-4');
    video.FrameRate = 24;
    open(video)
    writeVideo(video,frame);
    close(video)
    
    clf
    for iter = 1:itermax
        plot(1:iter,bestcost(1:iter));
        axis([1 itermax -6.6 -4.1 ]);
        title(['Minimum Value Plot | Population = ' num2str(npop) ' | MinVal = ' num2str(bestcost(iter))] );
        framec(iter) = getframe(gcf); pause(0.0001);        
    end
    
    name = ['Convergence pop=' num2str(npop)];
    video = VideoWriter(name,'MPEG-4');
    video.FrameRate = 24;
    open(video)
    writeVideo(video,framec);
    close(video)
    
    bestff = globest;
    mincost = bestcost;
end