function set_contour_value_from_height(this,app)
%SET_CONTOUR_VALUE_FROM_HEIGHT Summary of this function goes here
%   Detailed explanation goes here
app.ValueMRDEditField.Value = num2str(this.hODF.CPFs{this.pf}.cls{this.cl}.contourLevel); 
end

