function set_resolution_from_value(this, value)
%SET_RESOLUTION_FROM_VALUE Summary of this function goes here
%   Detailed explanation goes here
    this.hODF.psi = deLaValleePoussinKernel('halfwidth', value*degree);
end

