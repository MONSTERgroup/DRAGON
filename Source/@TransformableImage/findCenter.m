function bc = findCenter(this)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

%invokeTutorial('1');
debug_info = struct;
ax = gca;

% get center
[cx,cy] = ginput(1);
cx = round(cx);
cy = round(cy);
debug_info.c = [cx cy];

hold on;
center = plot(ax, cx, cy, 'ro', 'MarkerSize', 10, 'Color', [1 0 0]);
hold off;

[ex,ey] = ginput(1);
ex = round(ex);
ey = round(ey);
debug_info.e = [ex ey];

hold on;
edge = plot(ax, ex, ey, 'ro', 'MarkerSize', 10, 'Color', [1 0 0]);
hold off;

radius = round(norm([cx cy] - [ex ey]));
debug_info.r = radius;

%bc = BoundaryCircle(cx,cy,radius,0:0.01:2*pi);
%bc.plot(ax);

delete(center);
delete(edge);

pad = round(1.2*radius);

debug_info.size = size(this.im);
debug_info.crop = [cx-pad cy-pad 2*pad 2*pad];

image_size = size(this.im);
crop_pad_pre  = [0 0];
crop_pad_post = [0 0];

if (cx-pad) < 0
    crop_pad_pre(2) = abs(cx-pad);
end
if (cy-pad) < 0
    crop_pad_pre(1) = abs(cy-pad);
end
if image_size(1)-(cx+pad) < 0
    crop_pad_post(2) = abs(image_size(1)-(cx+pad));
end
if image_size(2)-(cy+pad) < 0
    crop_pad_post(1) = abs(image_size(2)-(cy+pad));
end

debug_info.pre = crop_pad_pre;
debug_info.post = crop_pad_post;

this.im = padarray(this.im, crop_pad_pre, 240, 'pre');
this.im = padarray(this.im, crop_pad_post, 240, 'post');

cx = cx+crop_pad_pre(2);
cy = cy+crop_pad_pre(1);

close;
ax = this.plot();

% rectangle('Position', [cx-pad cy-pad 2*pad 2*pad])
% hold on
% plot(ax, cx, cy, 'ro', 'MarkerSize', 10, 'Color', [1 0 0]);
% hold off

this.im = imcrop(this.im, [cx-pad cy-pad 2*pad 2*pad]);

%this.im = flip(this.im, 1);
debug_info.V = size(this.im);
disp(debug_info);
close;
%delete(bc.handle);

ax = this.plot();
%xlim(ax,[cx-pad cx+pad])
%ylim(ax,[cy-pad cy+pad])

bc = BoundaryCircle(cx,cy,radius,0:0.01:2*pi);
bc.plot(ax);

%debug_info = [(cx+pad)-(cx-pad) (cy+pad)-(cy-pad)]

%app.bc.plot(app.ax);

%invokeTutorial('2');

% get center
% [cx,cy] = ginput(1)
% 
% hold on;
% center = plot(ax, cx, cy, 'ro', 'MarkerSize', 10, 'Color', [1 0 0]);
% hold off;
% 
% [ex,ey] = ginput(1);
% hold on;
% edge = plot(ax, ex, ey, 'ro', 'MarkerSize', 10, 'Color', [1 0 0]);
% hold off;
% 
% radius = norm([cx cy] - [ex ey]);
% 
% bc = BoundaryCircle(cx,cy,radius,0:0.01:2*pi);
% bc.plot(ax);

end

