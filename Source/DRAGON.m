classdef DRAGON < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        PFDigitizerUIFigure             matlab.ui.Figure
        ProjectionDropDown              matlab.ui.control.DropDown
        ProjectionDropDownLabel         matlab.ui.control.Label
        MillerIndexDropDown             matlab.ui.control.DropDown
        MillerIndexDropDownLabel        matlab.ui.control.Label
        ComputeODFButton                matlab.ui.control.Button
        NextButton_2                    matlab.ui.control.Button
        PreviousButton_2                matlab.ui.control.Button
        AddPolygonButton                matlab.ui.control.Button
        ValueMRDEditField               matlab.ui.control.EditField
        ValueMRDEditFieldLabel          matlab.ui.control.Label
        PreviewPoleFigureButton         matlab.ui.control.Button
        BaselineLevelEditField          matlab.ui.control.EditField
        BaselineLevelEditFieldLabel     matlab.ui.control.Label
        ImportImageButton               matlab.ui.control.Button
        NextButton                      matlab.ui.control.Button
        PreviousButton                  matlab.ui.control.Button
        ContourLevelLabel               matlab.ui.control.Label
        ResolutiondegreeEditField       matlab.ui.control.NumericEditField
        ResolutiondegreeEditFieldLabel  matlab.ui.control.Label
        KernelDropDown                  matlab.ui.control.DropDown
        KernelDropDownLabel             matlab.ui.control.Label
        LatticeTypeDropDown             matlab.ui.control.DropDown
        LatticeTypeDropDownLabel        matlab.ui.control.Label
        PoleFigureLabel                 matlab.ui.control.Label
        ODFLabel                        matlab.ui.control.Label
        ContextMenu                     matlab.ui.container.ContextMenu
        Menu                            matlab.ui.container.Menu
        Menu2                           matlab.ui.container.Menu
    end

    
    properties (Access = private)
        hODF; % Hierarchical ODF Object
        t; % Tutorial Object
        c; % GUI Context Manager
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.hODF = HierarchicalODF();
            app.c = GUIContextManager(app.hODF);

            %p1n = uitreenode(app.Tree,'Text', 'Pole Figure 1');
            %uitreenode(p1n, 'Text', 'Contour Level 1');
            
            app.c.set_CS_from_lattice(app);
            app.c.set_miller_options_from_lattice(app);
            app.c.set_resolution_from_value(app.ResolutiondegreeEditField.Value);
            app.c.set_projection_from_value(app.ProjectionDropDown.Value);
            
            app.c.set_pole_miller_from_options(app)
            app.c.change_pole_figure(app, 1);
            
        end

        % Value changed function: LatticeTypeDropDown
        function LatticeTypeDropDownValueChanged(app, event)
           app.c.set_miller_options_from_lattice(app);            
        end

        % Button pushed function: NextButton
        function NextButtonPushed(app, event)
            app.c.change_pole_figure(app, app.c.pf + 1)
        end

        % Button pushed function: PreviousButton
        function PreviousButtonPushed(app, event)
            if (app.c.pf - 1 >= 1)
                app.c.change_pole_figure(app, app.c.pf-1)
            end
        end

        % Value changed function: MillerIndexDropDown
        function MillerIndexDropDownValueChanged(app, event)
            app.c.set_pole_miller_from_options(app);
        end

        % Value changed function: BaselineLevelEditField
        function BaselineLevelEditFieldValueChanged(app, event)
            app.c.set_pf_baseline_from_value(app);
        end

        % Button pushed function: ImportImageButton
        function ImportImageButtonPushed(app, event)
            app.c.import_image;
        end

        % Button pushed function: AddPolygonButton
        function AddPolygonButtonPushed(app, event)
            app.c.add_polygon;
        end

        % Value changed function: ValueMRDEditField
        function ValueMRDEditFieldValueChanged(app, event)
            app.c.set_contour_height_from_value(app)
        end

        % Button pushed function: PreviousButton_2
        function PreviousButton_2Pushed(app, event)
            if (app.c.cl - 1 >= 1)
                app.c.change_contour_level(app, app.c.cl-1)         
            end
        end

        % Button pushed function: NextButton_2
        function NextButton_2Pushed(app, event)
            app.c.change_contour_level(app, app.c.cl + 1)
        end

        % Button pushed function: PreviewPoleFigureButton
        function PreviewPoleFigureButtonPushed(app, event)
            app.c.preview_current_pole_figure;
        end

        % Button pushed function: ComputeODFButton
        function ComputeODFButtonPushed(app, event)
           app.c.hODF.computeODF(app.c.proj);
           
           outvar = app.c.hODF;
           
           [file, path] = uiputfile('*.mat', 'Save ODF as Matlab Variable', 'untitled.mat');
           fp = fullfile(path,file);
           save(fp ,'outvar','-mat');
        end

        % Value changed function: ResolutiondegreeEditField
        function ResolutiondegreeEditFieldValueChanged(app, event)
            app.c.set_resolution_from_value(app.ResolutiondegreeEditField.Value);
        end

        % Value changed function: ProjectionDropDown
        function ProjectionDropDownValueChanged(app, event)
            app.c.set_projection_from_value(app.ProjectionDropDown.Value);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create PFDigitizerUIFigure and hide until all components are created
            app.PFDigitizerUIFigure = uifigure('Visible', 'off');
            app.PFDigitizerUIFigure.Color = [1 1 1];
            app.PFDigitizerUIFigure.Position = [100 100 248 570];
            app.PFDigitizerUIFigure.Name = 'PF Digitizer';

            % Create ODFLabel
            app.ODFLabel = uilabel(app.PFDigitizerUIFigure);
            app.ODFLabel.BackgroundColor = [0 0.1294 0.6471];
            app.ODFLabel.HorizontalAlignment = 'center';
            app.ODFLabel.VerticalAlignment = 'top';
            app.ODFLabel.FontName = 'Gentona Heavy';
            app.ODFLabel.FontSize = 20;
            app.ODFLabel.FontWeight = 'bold';
            app.ODFLabel.FontColor = [1 1 1];
            app.ODFLabel.Position = [1 539 250 32];
            app.ODFLabel.Text = 'ODF';

            % Create PoleFigureLabel
            app.PoleFigureLabel = uilabel(app.PFDigitizerUIFigure);
            app.PoleFigureLabel.BackgroundColor = [0 0.1294 0.6471];
            app.PoleFigureLabel.HorizontalAlignment = 'center';
            app.PoleFigureLabel.VerticalAlignment = 'top';
            app.PoleFigureLabel.FontName = 'Gentona Heavy';
            app.PoleFigureLabel.FontSize = 20;
            app.PoleFigureLabel.FontWeight = 'bold';
            app.PoleFigureLabel.FontColor = [1 1 1];
            app.PoleFigureLabel.Position = [1 377 250 32];
            app.PoleFigureLabel.Text = 'Pole Figure:';

            % Create LatticeTypeDropDownLabel
            app.LatticeTypeDropDownLabel = uilabel(app.PFDigitizerUIFigure);
            app.LatticeTypeDropDownLabel.BackgroundColor = [1 1 1];
            app.LatticeTypeDropDownLabel.FontName = 'Quadon Medium';
            app.LatticeTypeDropDownLabel.FontSize = 14;
            app.LatticeTypeDropDownLabel.Position = [9 509 91 22];
            app.LatticeTypeDropDownLabel.Text = 'Lattice Type';

            % Create LatticeTypeDropDown
            app.LatticeTypeDropDown = uidropdown(app.PFDigitizerUIFigure);
            app.LatticeTypeDropDown.Items = {'cubic', 'hexagonal', 'tetragonal', 'trigonal', 'orthorhombic', 'monoclinic', 'triclinic'};
            app.LatticeTypeDropDown.ValueChangedFcn = createCallbackFcn(app, @LatticeTypeDropDownValueChanged, true);
            app.LatticeTypeDropDown.Tooltip = {'Set the crystal symmetry of the pole figure. Add additional through the Symmetry menu or the config file.'};
            app.LatticeTypeDropDown.FontName = 'Quadon Medium';
            app.LatticeTypeDropDown.FontSize = 14;
            app.LatticeTypeDropDown.BackgroundColor = [1 1 1];
            app.LatticeTypeDropDown.Position = [99 509 144 22];
            app.LatticeTypeDropDown.Value = 'cubic';

            % Create KernelDropDownLabel
            app.KernelDropDownLabel = uilabel(app.PFDigitizerUIFigure);
            app.KernelDropDownLabel.BackgroundColor = [1 1 1];
            app.KernelDropDownLabel.FontName = 'Quadon Medium';
            app.KernelDropDownLabel.FontSize = 14;
            app.KernelDropDownLabel.Position = [9 479 75 22];
            app.KernelDropDownLabel.Text = 'Kernel';

            % Create KernelDropDown
            app.KernelDropDown = uidropdown(app.PFDigitizerUIFigure);
            app.KernelDropDown.Items = {'deLaValeePoussin', ''};
            app.KernelDropDown.Tooltip = {'Only option...for now.'};
            app.KernelDropDown.FontName = 'Quadon Medium';
            app.KernelDropDown.FontSize = 14;
            app.KernelDropDown.BackgroundColor = [1 1 1];
            app.KernelDropDown.Position = [99 479 144 22];
            app.KernelDropDown.Value = 'deLaValeePoussin';

            % Create ResolutiondegreeEditFieldLabel
            app.ResolutiondegreeEditFieldLabel = uilabel(app.PFDigitizerUIFigure);
            app.ResolutiondegreeEditFieldLabel.FontName = 'Quadon Medium';
            app.ResolutiondegreeEditFieldLabel.FontSize = 14;
            app.ResolutiondegreeEditFieldLabel.Position = [8 449 135 22];
            app.ResolutiondegreeEditFieldLabel.Text = 'Resolution (degree)';

            % Create ResolutiondegreeEditField
            app.ResolutiondegreeEditField = uieditfield(app.PFDigitizerUIFigure, 'numeric');
            app.ResolutiondegreeEditField.ValueChangedFcn = createCallbackFcn(app, @ResolutiondegreeEditFieldValueChanged, true);
            app.ResolutiondegreeEditField.FontName = 'Quadon Medium';
            app.ResolutiondegreeEditField.FontSize = 14;
            app.ResolutiondegreeEditField.Tooltip = {'Halfwidth for deLaValeePoussin kernel (in degrees). Default is 10.'};
            app.ResolutiondegreeEditField.Position = [143 449 100 22];
            app.ResolutiondegreeEditField.Value = 10;

            % Create ContourLevelLabel
            app.ContourLevelLabel = uilabel(app.PFDigitizerUIFigure);
            app.ContourLevelLabel.BackgroundColor = [0 0.1294 0.6471];
            app.ContourLevelLabel.HorizontalAlignment = 'center';
            app.ContourLevelLabel.VerticalAlignment = 'top';
            app.ContourLevelLabel.FontName = 'Gentona Heavy';
            app.ContourLevelLabel.FontSize = 20;
            app.ContourLevelLabel.FontWeight = 'bold';
            app.ContourLevelLabel.FontColor = [1 1 1];
            app.ContourLevelLabel.Position = [1 167 250 32];
            app.ContourLevelLabel.Text = 'Contour Level:';

            % Create PreviousButton
            app.PreviousButton = uibutton(app.PFDigitizerUIFigure, 'push');
            app.PreviousButton.ButtonPushedFcn = createCallbackFcn(app, @PreviousButtonPushed, true);
            app.PreviousButton.IconAlignment = 'center';
            app.PreviousButton.BackgroundColor = [0.9804 0.2745 0.0863];
            app.PreviousButton.FontName = 'Quadon Medium';
            app.PreviousButton.FontSize = 14;
            app.PreviousButton.FontColor = [1 1 1];
            app.PreviousButton.Position = [8 209 100 22];
            app.PreviousButton.Text = '<< Previous';

            % Create NextButton
            app.NextButton = uibutton(app.PFDigitizerUIFigure, 'push');
            app.NextButton.ButtonPushedFcn = createCallbackFcn(app, @NextButtonPushed, true);
            app.NextButton.IconAlignment = 'center';
            app.NextButton.BackgroundColor = [0.9804 0.2745 0.0863];
            app.NextButton.FontName = 'Quadon Medium';
            app.NextButton.FontSize = 14;
            app.NextButton.FontColor = [1 1 1];
            app.NextButton.Tooltip = {'Next Pole Figure (or new'; ' if you are at the end of the list.)'};
            app.NextButton.Position = [143 209 100 22];
            app.NextButton.Text = 'Next >>';

            % Create ImportImageButton
            app.ImportImageButton = uibutton(app.PFDigitizerUIFigure, 'push');
            app.ImportImageButton.ButtonPushedFcn = createCallbackFcn(app, @ImportImageButtonPushed, true);
            app.ImportImageButton.IconAlignment = 'center';
            app.ImportImageButton.BackgroundColor = [0.9804 0.2745 0.0863];
            app.ImportImageButton.FontName = 'Quadon Medium';
            app.ImportImageButton.FontSize = 14;
            app.ImportImageButton.FontColor = [1 1 1];
            app.ImportImageButton.Position = [8 311 235 22];
            app.ImportImageButton.Text = 'Import Image';

            % Create BaselineLevelEditFieldLabel
            app.BaselineLevelEditFieldLabel = uilabel(app.PFDigitizerUIFigure);
            app.BaselineLevelEditFieldLabel.FontName = 'Quadon Medium';
            app.BaselineLevelEditFieldLabel.FontSize = 14;
            app.BaselineLevelEditFieldLabel.Position = [9 279 105 22];
            app.BaselineLevelEditFieldLabel.Text = 'Baseline Level';

            % Create BaselineLevelEditField
            app.BaselineLevelEditField = uieditfield(app.PFDigitizerUIFigure, 'text');
            app.BaselineLevelEditField.ValueChangedFcn = createCallbackFcn(app, @BaselineLevelEditFieldValueChanged, true);
            app.BaselineLevelEditField.FontName = 'Quadon Medium';
            app.BaselineLevelEditField.Tooltip = {'Basically'; ' the contour that covers the most area or most intersects with the boundary. If this is wrong'; ' you''ll know when you digitize or preview.'};
            app.BaselineLevelEditField.Position = [113 279 130 22];

            % Create PreviewPoleFigureButton
            app.PreviewPoleFigureButton = uibutton(app.PFDigitizerUIFigure, 'push');
            app.PreviewPoleFigureButton.ButtonPushedFcn = createCallbackFcn(app, @PreviewPoleFigureButtonPushed, true);
            app.PreviewPoleFigureButton.IconAlignment = 'center';
            app.PreviewPoleFigureButton.BackgroundColor = [0.9804 0.2745 0.0863];
            app.PreviewPoleFigureButton.FontName = 'Quadon Medium';
            app.PreviewPoleFigureButton.FontSize = 14;
            app.PreviewPoleFigureButton.FontColor = [1 1 1];
            app.PreviewPoleFigureButton.Position = [8 244 235 22];
            app.PreviewPoleFigureButton.Text = 'Preview Pole Figure';

            % Create ValueMRDEditFieldLabel
            app.ValueMRDEditFieldLabel = uilabel(app.PFDigitizerUIFigure);
            app.ValueMRDEditFieldLabel.FontName = 'Quadon Medium';
            app.ValueMRDEditFieldLabel.FontSize = 14;
            app.ValueMRDEditFieldLabel.Position = [9 132 88 22];
            app.ValueMRDEditFieldLabel.Text = 'Value (MRD)';

            % Create ValueMRDEditField
            app.ValueMRDEditField = uieditfield(app.PFDigitizerUIFigure, 'text');
            app.ValueMRDEditField.ValueChangedFcn = createCallbackFcn(app, @ValueMRDEditFieldValueChanged, true);
            app.ValueMRDEditField.FontName = 'Quadon Medium';
            app.ValueMRDEditField.Tooltip = {'Change the Miller (or Miller-Bravais) index of the current pole figure. Use 3 (or 4) numbers with spaces'; ' no brackets or parentheses.'};
            app.ValueMRDEditField.Position = [99 132 144 22];

            % Create AddPolygonButton
            app.AddPolygonButton = uibutton(app.PFDigitizerUIFigure, 'push');
            app.AddPolygonButton.ButtonPushedFcn = createCallbackFcn(app, @AddPolygonButtonPushed, true);
            app.AddPolygonButton.IconAlignment = 'center';
            app.AddPolygonButton.BackgroundColor = [0.9804 0.2745 0.0863];
            app.AddPolygonButton.FontName = 'Quadon Medium';
            app.AddPolygonButton.FontSize = 14;
            app.AddPolygonButton.FontColor = [1 1 1];
            app.AddPolygonButton.Position = [8 101 235 22];
            app.AddPolygonButton.Text = 'Add Polygon';

            % Create PreviousButton_2
            app.PreviousButton_2 = uibutton(app.PFDigitizerUIFigure, 'push');
            app.PreviousButton_2.ButtonPushedFcn = createCallbackFcn(app, @PreviousButton_2Pushed, true);
            app.PreviousButton_2.IconAlignment = 'center';
            app.PreviousButton_2.BackgroundColor = [0.9804 0.2745 0.0863];
            app.PreviousButton_2.FontName = 'Quadon Medium';
            app.PreviousButton_2.FontSize = 14;
            app.PreviousButton_2.FontColor = [1 1 1];
            app.PreviousButton_2.Position = [8 68 100 22];
            app.PreviousButton_2.Text = '<< Previous';

            % Create NextButton_2
            app.NextButton_2 = uibutton(app.PFDigitizerUIFigure, 'push');
            app.NextButton_2.ButtonPushedFcn = createCallbackFcn(app, @NextButton_2Pushed, true);
            app.NextButton_2.IconAlignment = 'center';
            app.NextButton_2.BackgroundColor = [0.9804 0.2745 0.0863];
            app.NextButton_2.FontName = 'Quadon Medium';
            app.NextButton_2.FontSize = 14;
            app.NextButton_2.FontColor = [1 1 1];
            app.NextButton_2.Tooltip = {'Next Pole Figure (or new'; ' if you are at the end of the list.)'};
            app.NextButton_2.Position = [143 68 100 22];
            app.NextButton_2.Text = 'Next >>';

            % Create ComputeODFButton
            app.ComputeODFButton = uibutton(app.PFDigitizerUIFigure, 'push');
            app.ComputeODFButton.ButtonPushedFcn = createCallbackFcn(app, @ComputeODFButtonPushed, true);
            app.ComputeODFButton.IconAlignment = 'center';
            app.ComputeODFButton.BackgroundColor = [0 0.1294 0.6471];
            app.ComputeODFButton.FontName = 'Quadon Medium';
            app.ComputeODFButton.FontSize = 14;
            app.ComputeODFButton.FontColor = [1 1 1];
            app.ComputeODFButton.Tooltip = {'Next Pole Figure (or new'; ' if you are at the end of the list.)'};
            app.ComputeODFButton.Position = [8 12 235 45];
            app.ComputeODFButton.Text = 'Compute ODF';

            % Create MillerIndexDropDownLabel
            app.MillerIndexDropDownLabel = uilabel(app.PFDigitizerUIFigure);
            app.MillerIndexDropDownLabel.BackgroundColor = [1 1 1];
            app.MillerIndexDropDownLabel.FontName = 'Quadon Medium';
            app.MillerIndexDropDownLabel.FontSize = 14;
            app.MillerIndexDropDownLabel.Position = [9 344 87 22];
            app.MillerIndexDropDownLabel.Text = 'Miller Index';

            % Create MillerIndexDropDown
            app.MillerIndexDropDown = uidropdown(app.PFDigitizerUIFigure);
            app.MillerIndexDropDown.Items = {};
            app.MillerIndexDropDown.ValueChangedFcn = createCallbackFcn(app, @MillerIndexDropDownValueChanged, true);
            app.MillerIndexDropDown.Tooltip = {'Set the crystal symmetry of the pole figure. Add additional through the Symmetry menu or the config file.'};
            app.MillerIndexDropDown.FontName = 'Quadon Medium';
            app.MillerIndexDropDown.FontSize = 14;
            app.MillerIndexDropDown.BackgroundColor = [1 1 1];
            app.MillerIndexDropDown.Position = [99 344 144 22];
            app.MillerIndexDropDown.Value = {};

            % Create ProjectionDropDownLabel
            app.ProjectionDropDownLabel = uilabel(app.PFDigitizerUIFigure);
            app.ProjectionDropDownLabel.BackgroundColor = [1 1 1];
            app.ProjectionDropDownLabel.FontName = 'Quadon Medium';
            app.ProjectionDropDownLabel.FontSize = 14;
            app.ProjectionDropDownLabel.Position = [8 417 75 22];
            app.ProjectionDropDownLabel.Text = 'Projection';

            % Create ProjectionDropDown
            app.ProjectionDropDown = uidropdown(app.PFDigitizerUIFigure);
            app.ProjectionDropDown.Items = {'Equal Angle', 'Equal Area', 'Equal Distance', ''};
            app.ProjectionDropDown.ValueChangedFcn = createCallbackFcn(app, @ProjectionDropDownValueChanged, true);
            app.ProjectionDropDown.Tooltip = {'Only option...for now.'};
            app.ProjectionDropDown.FontName = 'Quadon Medium';
            app.ProjectionDropDown.FontSize = 14;
            app.ProjectionDropDown.BackgroundColor = [1 1 1];
            app.ProjectionDropDown.Position = [98 417 144 22];
            app.ProjectionDropDown.Value = 'Equal Area';

            % Create ContextMenu
            app.ContextMenu = uicontextmenu(app.PFDigitizerUIFigure);

            % Create Menu
            app.Menu = uimenu(app.ContextMenu);
            app.Menu.Text = 'Menu';

            % Create Menu2
            app.Menu2 = uimenu(app.ContextMenu);
            app.Menu2.Text = 'Menu2';

            % Show the figure after all components are created
            app.PFDigitizerUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = DRAGON

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.PFDigitizerUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.PFDigitizerUIFigure)
        end
    end
end