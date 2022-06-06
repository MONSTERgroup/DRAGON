function ax = moveToOrigin(this,bc)
%MOVETOORIGIN Summary of this function goes here
%   Detailed explanation goes here

%vector = [0-bc.x0, 0-bc.y0];
% this.im = imtranslate(this.im, vector, 'FillValues',255,'OutputView','full');
% %ax = this.plot();
% delete(bc.handle);
% ax = gca;
% xlim(ax, [0-bc.a, 0+bc.a])
% ylim(ax, [0-bc.a, 0+bc.a])

%x = xlim;
%y = ylim;

%this.im = imcrop(this.im, [0 0 x(2) y(2)]);

close;

bc.x0 = 0;
bc.y0 = 0;

V = size(this.im);

x = [0-V(1)/2 0+V(1)/2]
y = [0-V(2)/2 0+V(2)/2]

%this.im = flip(this.im, 1);
this.im = imagesc(x,y, this.im);

ax = gca;
axis(ax, 'image');
set(ax, 'Ydir','normal')

bc.plot(ax);

end

