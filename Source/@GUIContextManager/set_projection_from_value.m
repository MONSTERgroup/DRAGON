function set_projection_from_value(this, value)
%SET_PROJECTION_FROM_VALUE Summary of this function goes here
%   Detailed explanation goes here

switch value
    case 'Equal Angle'
        this.proj = eangleProjection();
    case 'Equal Area'
        this.proj = eareaProjection();
    case 'Equal Distance'
        this.proj = edistProjection();
    otherwise
        warning('How did you even do this? I manually set the possible cases in the GUI and this is not one of them.')
end

end

