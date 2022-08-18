classdef Point < handle
    %POINT Summary of this class goes here
    %   Detailed explanation goes here

    properties
        x;
        y;
        val; %contour level, radius, whatever you want to call it
        ext; %min/max/non-extrema
        id;
    end

    methods

        function pt = Point(varargin)
            %POINT Construct an instance of this class
            %   Detailed explanation goes here
            
            if nargin < 1; return; end
            if nargin > 1 && nargin < 4
                error('Args are x, y, val, ext')
            end

            if nargin >= 4

                pt.x = varargin{1};
                pt.y = varargin{2};
                pt.val = varargin{3};
                pt.ext = varargin{4};
                pt.id = 1:1:length(varargin{1});

            end

        end
        function pt = append(pt,varargin)

            %append quick and dirty append
            %   Detailed explanation goes here
            gn = inputname(1);

            if nargin == 1
                warning('No data provided to append to Point(list): %s', upper(gn));
            end

            if nargin == 2 && isa(varargin{1}, 'Point')
                np_app = length(varargin{1}.x);
                last_id = 0;
                if ~isempty(pt.id)
                    last_id = max(pt.id);
                end
                pt.x(end+1:end+np_app) = varargin{1}.x;
                pt.y(end+1:end+np_app) = varargin{1}.y;
                pt.val(end+1:end+np_app) = varargin{1}.val;
                pt.ext(end+1:end+np_app) = varargin{1}.ext;
                pt.id(end+1:end+np_app) = ((1+last_id):1:(np_app+last_id)); %new ids that can't possibly overwrite old ids
            end

        end
        function s = size(pt, dim)
            s = size(pt.x, dim);
        end
    end
end

