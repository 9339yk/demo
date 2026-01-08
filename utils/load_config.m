function cfg = load_config()
% load_config
%
% Loads local config if available, otherwise falls back to template.
% This keeps code portable across machines.

    if exist("config_local.m", "file") == 2
        cfg = config_local();
        src = "config_local.m";
    else
        cfg = config_template();
        src = "config_template.m";
        warning("Using config_template.m — please create config_local.m for your machine.");
    end

    fprintf("[Config] Loaded from %s\n", src);

    % Basic sanity checks
    if isfield(cfg, "data_root")
        if ~isfolder(cfg.data_root)
            warning("Data folder does not exist: %s", cfg.data_root);
        end
    end
end
