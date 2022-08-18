classdef BoundaryCircle < handle
    %UNTITLED11 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x0
        y0
        a
        t
        LineWidth = 2;
        Color = [0 0 1];
        handle
    end
    
    methods
        function obj = BoundaryCircle(x0, y0, a, t)
            %UNTITLED11 Construct an instance of this class
            %   Detailed explanation goes here
            obj.x0 = x0;
            obj.y0 = y0;
            obj.a  = a;
            obj.t  = t;
        end
        
        function plot(obj,axes)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            x=obj.x0+obj.a*cos(obj.t);
            y=obj.y0+obj.a*sin(obj.t);
            hold(axes, 'on')
            obj.handle(1) = plot(axes,x,y, 'LineWidth', obj.LineWidth,'Color',obj.Color);
            obj.handle(2) = plot(axes,obj.x0, obj.y0, 'ro', 'MarkerSize', 5, 'Color', obj.Color);
            hold(axes, 'off')
        end
    end
end

