function [ax, isValidImage] = plot(this)
%PLOT Summary of this function goes here
%   Detailed explanation goes here

switch size(this.im,3)
    case 1
        % Display the grayscale image
        imagesc('Cdata', this.im);
        isValidImage = true;
    case 3
        % Display the truecolor image
        imagesc('Cdata', this.im);
        isValidImage = true;
    otherwise
        % Error when image is not grayscale or truecolor
        msgbox('Image must be grayscale or true color, load a different image',...
            'Incorrect image type', 'warn', 'modal');
        isValidImage = false;
end

ax = gca;
axis(ax, 'image');

end

