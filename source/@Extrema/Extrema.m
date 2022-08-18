classdef Extrema < int8
    %EXTREMUM Summary of this class goes here
    %   Detailed explanation goes here

    enumeration
        Not (0)
        Max (1)
        Min (-1)
    end

    methods

        function lg = isExtreme(ext)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            lg = logical(ext);
        end

        function lg = isMax(ext)
            lg = ext > 0;
        end

        function lg = isMin(ext)
            lg = ext < 0;
        end
    end
end

