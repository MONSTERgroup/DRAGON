function startup_DRAGON()

if ~(isdeployed || ismcc)
    addpath("source\")
    addpath(genpath("source\Functions\"));


cfg = load_config;
killApp = initialize_mtex;

if killApp
    return;
end

end

app = DRAGON;

end