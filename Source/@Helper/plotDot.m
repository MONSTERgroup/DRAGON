function handle = plotDot(ax, x, y, size, rgb_triplet)
hold(ax, 'on')
handle = plot(ax, x, y, 'ro', 'MarkerSize', size, 'Color', rgb_triplet);
hold(ax, 'off')
end

