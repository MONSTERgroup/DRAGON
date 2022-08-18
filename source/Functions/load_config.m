function cfg = load_config()
%LOAD_CONFIG Summary of this function goes here
%   Detailed explanation goes here

if ~exist('DRAGON.cfg', 'file')
    cfg = struct;
    cfg.DRAGON_version = fileread('VERSION');
    cfg.matlab_version = ['R' version('-release')];
    cfg.mtex_version = '';
    cfg.mtex_path = '';

    writestruct(cfg, 'DRAGON.cfg','FileType','xml');
else
    cfg = readstruct('DRAGON.cfg', 'FileType','xml');
end

end