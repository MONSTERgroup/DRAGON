v_matlab = ['R' version('-release')];

CS = crystalSymmetry('cubic');
SS = specimenSymmetry('1');

hw = 16*degree;

o_s1 = orientation.SR(CS,SS);
o_s2 = orientation.SR2(CS,SS);
o_s3 = orientation.SR3(CS,SS);
o_s4 = orientation.SR4(CS,SS);

o_copper = orientation.copper(CS,SS);
o_copper2 = orientation.copper2(CS,SS);

o_brass = orientation.brass(CS,SS);
o_brass2 = orientation.brass2(CS,SS);

h = Miller(...
    {0,0,1},...
    {0,1,1},...
    {1,1,1},...
    CS,SS);

odf_s1 = unimodalODF(o_s1, CS,specimenSymmetry('1'),'halfwidth', hw);
odf_s2 = unimodalODF(o_s2, CS,specimenSymmetry('1'),'halfwidth', hw);
odf_s3 = unimodalODF(o_s3, CS,specimenSymmetry('1'),'halfwidth', hw);
odf_s4 = unimodalODF(o_s4, CS,specimenSymmetry('1'),'halfwidth', hw);

odf_copper = unimodalODF(o_copper, CS,specimenSymmetry('1'),'halfwidth', hw);
odf_copper2 = unimodalODF(o_copper2, CS,specimenSymmetry('1'),'halfwidth', hw);
odf_brass = unimodalODF(o_brass, CS,specimenSymmetry('1'),'halfwidth', hw);
odf_brass2 = unimodalODF(o_brass2, CS,specimenSymmetry('1'),'halfwidth', hw);

odf = odf_s1 + odf_s2 + odf_s3 + odf_s4 + 0.5*odf_copper + 0.5*odf_copper2 + odf_brass + odf_brass2;

figure;
plotPDF(odf,h, 'projection', 'eangle')
mtexColorMap LaboTeX;
hold on
plotPDF(odf, h, 'contour', 1:2.5:13, 'linecolor', 'black', 'ShowText', 'on', 'upper', 'projection', 'eangle');
hold off
mtexColorbar;
