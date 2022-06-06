function preview_current_pole_figure(this)
%PREVIEW_CURRENT_POLE_FIGURE Summary of this function goes here
%   Detailed explanation goes here

this.hODF.CPFs{this.pf}.computePoleFigure(this.proj);

setMTEXpref('xAxisDirection','east');
setMTEXpref('zAxisDirection','outOfPlane');

figure(this.figpv);
this.hODF.CPFs{this.pf}.pf.plot('minmax','scatter'); 
mtexColorbar parula;


end

