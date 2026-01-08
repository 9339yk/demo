function cfg = config_local()
% config_local
% Local machine configuration (ignored by git)

    cfg = struct();

    % My local data directory
    cfg.data_root = "/Users/alex/data/lfp_project";

    % Where figures are saved
    cfg.figure_root = "figures";

    cfg.fs_default = 500;
end
