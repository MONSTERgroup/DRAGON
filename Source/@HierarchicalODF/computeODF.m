function computeODF(this, proj)
%COMPUTEODF Summary of this function goes here
%   Detailed explanation goes here

h = cell(1,length(this.CPFs));
intensities = cell(1,length(this.CPFs));
r = cell(1,length(this.CPFs));

for iPFs = 1:length(this.CPFs)
    this.CPFs{iPFs}.computePoleFigure(proj)
    disp(this.CPFs{iPFs}.pf)
    h{iPFs} = this.CPFs{iPFs}.pole;
    intensities{iPFs} = this.CPFs{iPFs}.pf.intensities;
    r{iPFs} = this.CPFs{iPFs}.pf.r;
end

% this.pf = PoleFigure.load(fnames,h,this.CS,...
%     'ColumnNames',{'polar angle','azimuth angle','intensity'},...
%     'Columns',[1 2 3]);

this.pf = PoleFigure(h,r,intensities);

this.ODF = calcODF(this.pf, this.psi);

this.ODF.plotPDF(h, this.CS);

end

