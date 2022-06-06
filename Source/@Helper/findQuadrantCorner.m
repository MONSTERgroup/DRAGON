function [x,y] = findQuadrantCorner(quadrant, xLim, yLim)
%FINDQUADRANTCORNER Summary of this function goes here
%   Detailed explanation goes here

if (quadrant == 1)
    x = xLim(2);
    y = yLim(2);
end

if (quadrant == 2)
    x = xLim(1);
    y = yLim(2);
end

if (quadrant == 3)
    x = xLim(1);
    y = yLim(1);
end

if (quadrant == 4)
    x = xLim(2);
    y = yLim(1);
end

end

