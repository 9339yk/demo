function cfg = config_template()
% config_template
%
% Copy this file to `config_local.m` and edit paths locally.
% DO NOT commit config_local.m to GitHub.

    cfg = struct();

    % ---- Data paths ----
    cfg.data_root = "/path/to/your/local/data";  % ← 修改這一行

    % ---- Output paths ----
    cfg.figure_root = "figures";

    % ---- Experiment parameters (optional) ----
    cfg.fs_default = 500;   % Hz

end
