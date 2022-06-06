function transform(this, bc)
%TRANSFORM Summary of this function goes here
%   Detailed explanation goes here

movingpoints(1,1) = bc.x0;
movingpoints(1,2) = bc.y0;
fixedpoints(1,1) = bc.x0;
fixedpoints(1,2) = bc.y0;

ax = gca;

for i = 1:1:4
    
    [x(i), y(i)] = ginput(1);
    
    if mod(i,2) ~= 0
        hold on;
        plot(ax, x(i), y(i), 'ro', 'MarkerSize', 10, 'Color', [0 0 1]);
        hold off;
    else
        hold on;
        plot(ax, x(i), y(i), 'ro', 'MarkerSize', 10, 'Color', [1 0 0]);
        hold off;
    end
end

for i = 1:2:length(x)-1
    movingpoints(i/2+0.5+1,1) = x(i);
    movingpoints(i/2+0.5+1,2) = y(i);
end

for i = 2:2:length(x)
    fixedpoints(i/2+1,1) = x(i);
    fixedpoints(i/2+1,2) = y(i);
end

tform = fitgeotrans(movingpoints, fixedpoints, 'affine');

this.im = imwarp(this.im, tform);

close;
%delete(bc.handle);

ax = this.plot();
bc.plot(ax);

end

