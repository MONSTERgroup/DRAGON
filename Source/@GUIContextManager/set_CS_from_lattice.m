function set_CS_from_lattice(this, app)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
this.hODF.CS = crystalSymmetry(app.LatticeTypeDropDown.Value);
end

