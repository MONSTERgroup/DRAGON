function quadrant = findQuadrant(x,y)
%FINDQUADRANT Summary of this function goes here
%   Detailed explanation goes here

if (x >= 0 && y >= 0)
    quadrant = 1;
end

if (x < 0 && y >= 0)
    quadrant = 2;
end

if (x < 0 && y < 0)
    quadrant = 3;
end

if (x >= 0 && y < 0)
    quadrant = 4;
end

end
