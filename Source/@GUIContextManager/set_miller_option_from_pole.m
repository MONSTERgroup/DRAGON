function set_miller_option_from_pole(this,app)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

temp = this.hODF.CPFs{this.pf}.pole.char;

if any(strcmp(app.MillerIndexDropDown.Items, temp))
    app.MillerIndexDropDown.Value = temp;
end

end

