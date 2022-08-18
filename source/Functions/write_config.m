function write_config(cfg)
%WRITE_CONFIG Summary of this function goes here
%   Detailed explanation goes here

writestruct(cfg, 'DRAGON.cfg','FileType','xml');

end
