function [vert_x, vert_y, h_markers] = click_at_level(h_fig, rgb_triplet, ext)
%CLICK_AT_LEVEL Summary of this function goes here
%   Detailed explanation goes here

vert_x = [];
vert_y = [];
h_markers = [];

if ext.isMax
    marker_symbol = '^';
elseif ext.isMin
    marker_symbol = 'v';
else
    marker_symbol = 'o';
end

n = 1;

while n == true
    
    [x, y, button] = ginput(1);
    
    if button == 1
        
        h_markers(end+1) = plot_marker(h_fig, x, y, 150, rgb_triplet, marker_symbol, 'LineWidth', 1.5);
        vert_x(end+1) = x;
        vert_y(end+1) = y;
        
    elseif any(ismember(button, [8,28]))
        
        delete(h_markers(end));
        h_markers(end) = [];
        vert_x(end) = [];
        vert_y(end) = [];
        
    else
        n = false;
    end
end

end

