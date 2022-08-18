function isActive = test_mtex()
%TEST_MTEX Summary of this function goes here
%   Detailed explanation goes here
try
    crystalSymmetry('cubic');
    isActive = true;
    return;
catch
    isActive = false;
    return;
end
end