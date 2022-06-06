function change_contour_level(this, app, value)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
this.cl = value;

app.ContourLevelLabel.Text = sprintf('Contour Level: %i', this.cl);

if length(this.hODF.CPFs{this.pf}.cls) < value
    this.hODF.CPFs{this.pf}.newContourLevel(0);
    this.set_contour_value_from_height(app);
else
    this.set_contour_value_from_height(app);
end
end

