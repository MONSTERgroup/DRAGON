classdef GUIContextManager < handle
    %GUICONTEXTMANAGER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        hODF
        pf = 1; %Index of CurrentPoleFigure
        cl = 1; %Index of CurrentContourLayer
        figwk; %working axes
        figpv = 2; %preview axes
        proj; %spherical projection
    end
    
    methods
        
        function this = GUIContextManager(hODF)
            %GUICONTEXTMANAGER Construct an instance of this class
            %   Detailed explanation goes here
            this.hODF = hODF;
        end
        
        set_CS_from_lattice(this,app)
        set_resolution_from_value(this, value)
        set_projection_from_value(this, value)
        set_pole_miller_from_options(this,app)
        set_miller_option_from_pole(this,app)
        change_pole_figure(this, app, value)
        change_contour_level(this, app, value)
        set_baseline_value_from_pf(this,app)
        set_pf_baseline_from_value(this,app)
        import_image(this)
        
        set_contour_value_from_height(this,app)
        set_contour_height_from_value(this,app)
        add_polygon(this)
        preview_current_pole_figure(this)
        
    end
    
    methods(Static)
        
        set_miller_options_from_lattice(app)
 
    end
end

