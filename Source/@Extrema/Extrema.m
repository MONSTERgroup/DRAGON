classdef Extrema
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        pos (1,2) double {mustBeReal, mustBeFinite}
        bounds (1,2) double {mustBeReal, mustBeNonnegative}
    end

    properties(Hidden)
        isMaximum logical
    end

    properties (Dependent)
        sign
        x
        y
    end

    methods
        function e = Extrema(namedArgs)
            %constructor
            arguments
                namedArgs.copy Extrema
                namedArgs.x (1,1) double
                namedArgs.y (1,1) double
                namedArgs.pos (1,2) double
                namedArgs.bounds (1,2) double {mustBeReal, mustBeFinite, mustBeNonnegative}
                namedArgs.step (1,1) double {mustBeReal, mustBeFinite, mustBePositive}
                namedArgs.lowerbound (1,1) double {mustBeReal, mustBeFinite, mustBeNonnegative}
                namedArgs.upperbound (1,1) double {mustBeReal, mustBeFinite, mustBePositive}
                namedArgs.type {isValidExtremaType(namedArgs.type)}
            end

            if isfield(namedArgs, 'copy')
                e.pos = namedArgs.copy.pos;
                e.bounds = namedArgs.copy.bounds;
                e.isMaximum = namedArgs.copy.isMaximum;
                return;
            end

            if isfield(namedArgs, 'pos')
                e.pos = namedArgs.pos;
            end

            if isfield(namedArgs, 'x') && isfield(namedArgs, 'y') && ~isfield(namedArgs, 'pos')
                e.pos = [namedArgs.x namedArgs.y];
            end

            if isfield(namedArgs, 'bounds')
                e.bounds = namedArgs.bounds;
            end

            if isfield(namedArgs, 'lowerbound') && ~isfield(namedArgs, 'bounds')
                if isfield(namedArgs, 'step')
                    e.bounds = [namedArgs.lowerbound namedArgs.lowerbound+namedArgs.step];
                else
                    e.bounds = [namedArgs.lowerbound inf];
                end
            end

            if isfield(namedArgs, 'upperbound') && ~isfield(namedArgs, 'bounds')
                if isfield(namedArgs, 'step')
                    e.bounds = [namedArgs.upperbound-namedArgs.step namedArgs.upperbound];
                else
                    e.bounds = [0 namedArgs.upperbound];
                end
            end

            if isfield(namedArgs, 'type')
                switch lower(namedArgs.type)
                    case {'maximum', 'max', '1'}
                        e.isMaximum = true;
                    case {'minimum', 'min', '-1'}
                        e.isMaximum = false;
                end
            else
            end



        end

        function sign = get.sign(e)
            if isempty(e.isMaximum)
                sign = 0;
            elseif e.isMaximum
                sign = 1;
            elseif ~e.isMaximum
                sign = -1;
            end
        end

        function x = get.x(e)
            x = e.pos(1);
        end

        function y = get.y(e)
            y = e.pos(2);
        end
    end
end

function isValidExtremaType(a)
if ~ismember(lower(a), {'maximum', 'minimum', 'max', 'min', '1', '-1'})
    eidType = 'isValidExtremaType:notValidExtremaType';
    msgType = "Valid extrema types are: {'maximum', 'minimum', 'max', 'min', '1', '-1', 1, -1}";
    throwAsCaller(MException(eidType,msgType))
end
end