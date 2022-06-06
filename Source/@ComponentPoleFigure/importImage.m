function fig = importImage(this)
%IMPORTIMAGE Summary of this function goes here
%   Detailed explanation goes here
this.tim.load();
[~,isValidImage] = this.tim.plot();
if isValidImage
    this.bc = this.tim.findCenter();
    this.requireTransform;
    this.tim.moveToOrigin(this.bc);
    fig = gcf;
else
    waitforbuttonpress;
    clear isValidImage;
    fig = this.importImage;
end
end


