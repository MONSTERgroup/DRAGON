function [items, itemsdata] = get_miller_options_from_lattice(CS, varargin)
%SET_MILLER_OPTIONS_FROM_LATTICE Summary of this function goes here
%   Detailed explanation goes here

m = CS.basicHKL.unique;

items = cell(size(m));
itemsdata = cell(size(m));

for ii = 1:length(m)
    items{ii} = m(ii).char;
    itemsdata{ii} = m(ii);
end

end

