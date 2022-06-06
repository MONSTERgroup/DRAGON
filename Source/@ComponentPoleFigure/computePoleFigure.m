function computePoleFigure(this, proj)
%COMPUTEPOLEFIGURE Summary of this function goes here
%   Detailed explanation goes here

r = equispacedS2Grid('resolution', 2*degree, 'upper');
scalingFactor = proj.project(vector3d(1,0,0));

[xsize, ysize] = size(r);

rPossibleContours = cell(xsize, ysize);
rContours = zeros(xsize, ysize);
xPos = zeros(xsize, ysize);
yPos = zeros(xsize, ysize);

clear iX iY;
for iX = 1:xsize
    for iY = 1:ysize
        rPossibleContours{iX,iY} = [this.baseline];
    end
end

clear iX iY;
for iX = 1:xsize
    for iY = 1:ysize
        
        vec = vector3d(r(iX,iY).xyz);
        
        [xPos(iX,iY), yPos(iX,iY)] = proj.project(vec);
        
        xPos(iX,iY) = xPos(iX,iY)*this.bc.a/scalingFactor;
        yPos(iX,iY) = yPos(iX,iY)*this.bc.a/scalingFactor;
                
        for iCLS = 1:length(this.cls)
            if this.cls{iCLS}.isInLayer(xPos(iX,iY),yPos(iX,iY))
                rPossibleContours{iX,iY}(end+1) = this.cls{iCLS}.contourLevel;
            end
        end
    end
end

clear iX iY;
for iX = 1:xsize
    for iY = 1:ysize
        
        minimum = min(rPossibleContours{iX,iY});
        maximum = max(rPossibleContours{iX,iY});
        
       % if minimum < this.baseline && maximum > this.baseline
       %     rContours(iX,iY) = this.baseline;
        if minimum < this.baseline
            rContours(iX,iY) = minimum;
        elseif maximum > this.baseline
            rContours(iX,iY) = maximum;
        else
            rContours(iX,iY) = this.baseline;
        end
    end
end

this.pf = PoleFigure(this.pole,r, rContours);


end

