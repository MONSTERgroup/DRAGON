function import_image(this)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

try
close(this.figwk);
catch
    warning('Figure does not exist at this handle');
end

this.figwk = this.hODF.CPFs{this.pf}.importImage;

end

