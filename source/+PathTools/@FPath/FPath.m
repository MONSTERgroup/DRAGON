classdef FPath
    %FILE Simple class to represent a file path
    %   Wraps fileparts/fullfile and path validation.

    properties
        location char;
        path char;
        name char;
        extension char;
    end

    properties(Dependent)
        type char;
        isEmpty logical;
    end

    properties(Hidden)
        exists logical;
        isFile logical;
        isFolder logical;
    end


    methods
        function F = FPath(varargin)
            %FILE Construct an instance of this class
            %   1-arg: assume full path
            %   n-arg: fullfile args together in order
            import PathTools.FPath
            if nargin == 0
                %warning('No path given to constructor. Will return empty file object!');
                return;
            end

            F = FPath.from_parts(varargin{:});
        end

        function t = get.type(F)
            if F.isFile
                t = 'File';
                return;
            end

            if F.isFolder
                t = 'Folder';
                return;
            end

            if ~isempty(F.extension) && ~F.exists
                t = 'Nonexistant File';
                return;
            end

            if isempty(F.extension) && ~F.exists
                t = 'Nonexistant Folder';
                return;
            end

            t = 'Undefined';

        end

        function emp = get.isEmpty(F)
            if F.isFolder
                emp = ~logical(length(dir(F.location))-2);
            end
        end

        function local = localName(F)
            local = F';
            local = extractAfter(local, [pwd filesep]);
        end

        function f = char(F)
            f = char(F.location);
        end

        function s = size(F)
            s = size(F.location);
        end

        function l = length(F)
            l = length(F.location);
        end

        % overloading ctranspose (the ' operator) to give a convenient way to type the
        % full path without having to use F.location or F.char or char(F)
        function f = ctranspose(F)
            f = F.char;
        end
    end

    methods(Static)

        function isAbsolutePath = isAbsolute(str)
            jfo = java.io.File(str);
            isAbsolutePath = jfo.isAbsolute();
        end

        function fp = rel2abs(fp)
            if ~PathTools.FPath.isAbsolute(fp)
                fp = fullfile(pwd, fp);
            end
        end

        function F = from_parts(varargin)
            import PathTools.FPath;
            
            F = FPath();
            if nargin < 1; return; end

            args = {};
            for ii = 1:length(varargin)
                if iscell(varargin{ii})
                    args = horzcat(args, varargin{ii});
                else
                    args{end+1} = varargin{ii};
                end
            end

            isFPath = cellfun(@(x) isa(x, 'PathTools.FPath'), args);
            if any(isFPath)
                F = args{isFPath};
                args(isFPath) = [];
            end
            clear('isFPath');

            isSepExt = matches(args, '-SeparateExtension');
            if any(isSepExt)
                args(isSepExt) = [];
                if contains(args{end}, '.') && ~endsWith(args{end-1}, filesep)
                    args{end-1} = args(varargin{end-1}, args{end});
                    args(end) = [];
                end
            end
            clear('isSepExt');

            fp = FPath.rel2abs(args{1});

            if nargin >= 1
                for ii = 2:length(args)
                    fp = fullfile(fp,args{ii});
                end
            end

            fp = FPath.rel2abs(fp);
            F.location = fp;
            [F.path, F.name, F.extension] = fileparts(F.location);

            F.isFile = isfile(F.location);
            F.isFolder = isfolder(F.location);

            if F.isFile || F.isFolder
                F.exists = true;
            else
                F.exists = false;
            end
        end

    end
end