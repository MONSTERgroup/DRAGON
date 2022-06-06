function requireTransform(this)
%REQUIRETRANSFORM Summary of this function goes here
%   Detailed explanation goes here
%x = input('Needs transform (y/n)', 's');

answer = questdlg('Does this require a scale/rotation transformation?', ...
	'Require Transform?', ...
	'Yes','No','No');

if strcmp(answer, 'Yes')
    this.tim.transform(this.bc);
    this.bc = this.tim.findCenter;
    this.requireTransform;
end

end

