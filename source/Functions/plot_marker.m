function handle = plot_marker(ax, x, y, varargin)
hold(ax, 'on')
handle = scatter(ax, x, y, varargin{:});
hold(ax, 'off')
end

