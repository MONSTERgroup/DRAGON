classdef ComponentPoleFigure <handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        pf; %MTEX PoleFigure
        pole;
        tim = TransformableImage; %TransformableImage
        cls = {}; %cell array of contour levels
        extrema = {}; %cell array of extrema
        baseline;
        bc; %boundary circle
    end
    
    methods
        function this = ComponentPoleFigure()
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            this.cls{end+1} = ContourLevel(0);
            this.baseline = 0;
        end
        
        ax = importImage(this)
        requireTransform(this)
        newContourLevel(this,value)
        [fname, h] = computePoleFigure(this, CS)
        
    end
end

