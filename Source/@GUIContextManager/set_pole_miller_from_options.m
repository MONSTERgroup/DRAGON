function set_pole_miller_from_options(this, app)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    

    this.hODF.CPFs{this.pf}.pole = string2Miller(app.MillerIndexDropDown.Value,this.hODF.CS);
    
end

