function [handles] = showImage(IM,varargin)
%SHOWIMAGE Summary of this function goes here
%   Detailed explanation goes here

opts = {'Border', 'tight', 'InitialMagnification', 'fit'};

if nargin > 1
    opts = varargin{:};
end

handles.himage = imshow(IM, opts{:});
handles.ax = ancestor(handles.himage, 'axes');
handles.fig = ancestor(handles.himage, 'figure');

end

