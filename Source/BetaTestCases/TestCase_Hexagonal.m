plotx2east;

CS = crystalSymmetry('hexagonal');
SS = specimenSymmetry('-1');

pole_1 = orientation.byEuler(0,0,0,CS)*rotation.byAxisAngle(vector3d.Y, 20*degree);
pole_2 = orientation.byEuler(0,0,0,CS)*rotation.byAxisAngle(vector3d.Y, -20*degree);

transverse = fibre(Miller(1,1,-2,0,CS), vector3d.Y);
basal = fibre(Miller(0,0,0,1,CS), vector3d.Z);

p1f = fibre(Miller(0,0,0,1,CS), rotation.byAxisAngle(vector3d.Y, 20*degree)*vector3d.Z);
p2f = fibre(Miller(0,0,0,1,CS), rotation.byAxisAngle(vector3d.Y, -20*degree)*vector3d.Z);


hw = 16*degree;

h = Miller(...
    {0,0,0,1},...
    {1,1,-2,0},...
    CS,SS);

tv_odf = fibreODF(transverse, CS, SS, 'halfwidth', hw);
bs_odf = fibreODF(basal, CS, SS, 'halfwidth', hw);
p1f_odf = fibreODF(p1f, CS, SS, 'halfwidth', hw);
p2f_odf = fibreODF(p2f, CS, SS, 'halfwidth', hw);
p1_odf = unimodalODF(pole_1, CS, SS, 'halfwidth', hw);
p2_odf = unimodalODF(pole_2, CS, SS, 'halfwidth', hw);
r_odf = uniformODF(CS, specimenSymmetry('1'), 'halfwidth', hw);

odf = (2*tv_odf + 0.1*bs_odf + 0.5*p1_odf + 0.5*p2_odf + p1f_odf + p2f_odf+ 2*r_odf)/4;
odf = rotation.byAxisAngle(vector3d.Z, 7.5*degree)*odf;

figure;
plotPDF(odf,h, 'projection', 'eangle')
mtexColorMap LaboTeX;
hold on
plotPDF(odf, h, 'contour', 1:2:13, 'linecolor', 'black', 'ShowText', 'on', 'upper', 'projection', 'eangle');
hold off
mtexColorbar;