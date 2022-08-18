function killApp = initialize_mtex
%INITIALIZE_MTEX Summary of this function goes here
%   Detailed explanation goes here

if ~(isdeployed || ismcc)

    cfg = load_config;

    if isempty(char(cfg.mtex_path))
        question = "Save MTEX path for future use or start MTEX externally.";
        title = "MTEX not found.";
        btn1 = 'Save MTEX Path';
        btn2 = 'Start Externally (Once)';
        btn3 = 'Start Externally (Always)';
        defbtn = 'Save MTEX Path';
        answer = questdlg(question, title, btn1, btn2, btn3, defbtn);

        switch answer
            case 'Save MTEX Path'
                cfg.mtex_path = uigetdir(pwd, 'Select base MTEX directory');
                write_config(cfg);
            case 'Start Externally (Once)'
                cfg.mtex_path = 'session';
                write_config(cfg);
            case 'Start Externally (Always)'
                cfg.mtex_path = 'never';
                write_config(cfg);
            case ''

        end
    end

    if test_mtex && strcmp(cfg.mtex_path, 'session')
        cfg = load_config;
        cfg.mtex_path = '';
        write_config(cfg);
        killApp = false;
        return;
    end

    if test_mtex
        killApp = false;
        return;
    end

    if ~test_mtex && strcmp(cfg.mtex_path, 'session')
        warndlg('MTEX is not active. Activate MTEX then restart DRAGON.')
        killApp = true;
        return;
    end

    if ~test_mtex && strcmp(cfg.mtex_path, 'never')
        warndlg('MTEX is not active. Activate MTEX then restart DRAGON.')
        killApp = true;
        return;
    end

    if ~test_mtex
        old_wd = cd(cfg.mtex_path);
        startup;
        cd(old_wd);
        clear('old_wd');
        killApp = false;
        return;
    end

end

end