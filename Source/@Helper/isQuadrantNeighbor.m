function bool = isQuadrantNeighbor(q1, q2)
%ISQUADRANTNEIGHBOR Summary of this function goes here
%   Detailed explanation goes here

bool = false;
if (q1 == 1 && (q2 == 2 || q2 == 4))
    bool = true;
end
if (q1 == 2 && (q2 == 1 || q2 == 3))
    bool = true;
end
if (q1 == 3 && (q2 == 2 || q2 == 4))
    bool = true;
end
if (q1 == 4 && (q2 == 3 || q2 == 1))
    bool = true;
end

