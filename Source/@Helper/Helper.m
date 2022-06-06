classdef Helper
    %UNTITLED6 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        currentCPF = 1;
        currentCL = 1;
        currentPgon = 1;
    end
    
    methods
        function this = Helper()
            ...
        end
    
        
    end
    
    methods(Static)
        handle = plotDot(ax, x, y, size, rgb_triplet)
        quadrant = findQuadrant(x,y)
        [x,y] = findQuadrantCorner(quadrant, xLim, yLim)
        bool = isQuadrantNeighbor(q1, q2)
    end
end

