function [outputArg1,outputArg2] = set_contour_height_from_value(this,app)
%SET_CONTOUR_HEIGHT_FROM_VALUE Summary of this function goes here
this.hODF.CPFs{this.pf}.cls{this.cl}.contourLevel = str2num(app.ValueMRDEditField.Value);
end

