function change_pole_figure(this, app, value)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

this.pf = value;

app.PoleFigureLabel.Text = sprintf('Pole Figure: %i', this.pf);

if length(this.hODF.CPFs) < this.pf
    this.hODF.CPFs{this.pf} = ComponentPoleFigure;
    this.set_pole_miller_from_options(app);
    this.set_baseline_value_from_pf(app);
    this.change_contour_level(app, 1);
else
    this.change_contour_level(app, 1);
    this.set_miller_option_from_pole(app);
    this.set_baseline_value_from_pf(app);
end

    

end

