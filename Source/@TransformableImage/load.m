function load(this)
%LOAD Summary of this function goes here
%   Detailed explanation goes here

filterspec = {'*.jpg;*.tif;*.png;*.gif','All Image Files'};
[f, p] = uigetfile(filterspec);

% Make sure user didn't cancel uigetfile dialog
if (ischar(p))
    fname = [p f];
    try
        this.im = imread(fname);
    catch ME
        % If problem reading image, display error message
        uialert(app.UIFigure, ME.message, 'Image Error');
        return;
    end
    
    this.im = flip(this.im, 1);
    
end

end

