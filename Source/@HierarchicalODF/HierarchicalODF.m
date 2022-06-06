classdef HierarchicalODF < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ODF ODF
        pf PoleFigure
        CPFs = {}; %cell array of constituent pole figures
        CS crystalSymmetry
        psi kernel
        
    end
    
    methods
        function this = HierarchicalODF()
            %HierarchicalODF Construct an instance of this class
            %   Detailed explanation goes here
            this.CPFs{end+1} = ComponentPoleFigure();
        end
        
        computeODF(this, proj)
    end
end

