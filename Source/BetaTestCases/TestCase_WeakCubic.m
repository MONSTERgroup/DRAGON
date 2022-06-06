cs = crystalSymmetry('cubic');
ss = specimenSymmetry('-1');

hw = 16*degree;

components = orientation.rand(20,cs,ss);

c = randi(1000, length(components), 1);
c = normalize(c, 'range');

h = Miller(...
    {0,0,1},...
    {0,1,1},...
    {1,1,1},...
    cs,ss);

odf = (unimodalODF(components, 'weights', c, cs,ss, 'halfwidth', hw) +...
    0.5*uniformODF(cs, ss, 'halfwidth', hw))/3;

figure;
plotPDF(odf,h, 'complete', 'upper', 'antipodal', 'projection', 'eangle')
mtexColorMap LaboTeX;
hold on
plotPDF(odf, h, 'contour', 1:1:122, 'linecolor', 'black', 'ShowText', 'on', 'complete', 'upper', 'antipodal', 'projection', 'eangle');
hold off
mtexColorbar;
setColorRange('tight', 'equal')