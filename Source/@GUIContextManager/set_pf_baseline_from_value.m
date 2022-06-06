function set_pf_baseline_from_value(this,app)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
this.hODF.CPFs{this.pf}.baseline = str2num(app.BaselineLevelEditField.Value);
end

