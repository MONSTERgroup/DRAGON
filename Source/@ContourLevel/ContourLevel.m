classdef ContourLevel < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        contourLevel = 0;
        polygons = {};
        contourVertX = [];
        contourVertY = [];
        dotHandles = [];
    end
    
    methods
        function this = ContourLevel(contourLevel)
            this.contourLevel = contourLevel;
        end
        
        addPolygon(this)
        
        %         function addPolygon(obj, polygon)
        %             obj.contourVertX(:,end+1) = polygon.Vertices(:,1);
        %             obj.contourVertY(:,end+1) = polygon.Vertices(:,2);
        %             disp(polygon);
        %             obj.contourLevel = polygon(1,1);
        %         end
        
        function isInLayer = isInLayer(this, x,y)
            isInLayer = false;
            for i = 1:length(this.polygons)
                pgon = this.polygons{i};
                TFin = isinterior(pgon, x, y);
                if TFin
                    isInLayer = true;
                end
            end
        end
        
        function plot(this)
            for i = 1:length(this.polygons)
                hold on
                plot(this.polygons{i})
                hold off
            end
        end
        
    end
end



