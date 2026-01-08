function demo_decoding()

    % ---- Load config ----
    cfg = load_config();

    % ---- Load or generate data ----
    dataPath = fullfile(cfg.data_root, "sample_lfp.mat");

    if exist(dataPath, "file")
        S = load(dataPath);
        raw = S.raw;
        labels = S.labels;
        fs = S.fs;
    else
        warning("Data not found, using synthetic demo data.");
        [raw, fs, labels] = load_or_generate_demo();
    end

    % ---- Shared preprocessing ----
    pp = preprocess_lfp(raw, fs);
    
    % ---- 3) Feature extraction (trial-like windows) ----
    X = features_rms(pp.zscored, fs);
    y = labels(:);

    % Align y to X rows (same number of windows)
    n = min(size(X,1), numel(y));
    X = X(1:n,:);
    y = y(1:n);

    % ---- 4) Simple classifier ----
    % Prefer fitclinear if available; fallback to a basic logistic using glmfit.
    if exist("fitclinear", "file") == 2
        mdl = fitclinear(X, y, "Learner", "logistic");
        yhat = predict(mdl, X);
    else
        % glmfit expects y in {0,1}
        b = glmfit(X, y, "binomial", "link", "logit");
        p = glmval(b, X, "logit");
        yhat = p >= 0.5;
    end

    acc = mean(yhat == y);

    fprintf("Decoding accuracy (toy demo): %.2f%%\n", acc*100);

    % ---- 5) Quick visualization ----
    figure("Name","Demo Decoding");
    histogram(X(y==0,1)); hold on;
    histogram(X(y==1,1));
    xlabel("Feature 1 (RMS, ch1)");
    ylabel("Count");
    legend("Class 0","Class 1");
    title(sprintf("Toy decoding | Acc = %.2f%%", acc*100));
    grid on;

end

function X = features_rms(x, fs)
% x: [T x C]  -> features per window: RMS per channel
    win_s = 0.5;
    hop_s = 0.5;
    win = max(1, round(win_s * fs));
    hop = max(1, round(hop_s * fs));

    T = size(x,1);
    C = size(x,2);
    n = floor((T - win) / hop) + 1;

    X = zeros(n, C);
    for i = 1:n
        idx = (1:win) + (i-1)*hop;
        seg = x(idx, :);
        X(i,:) = rms(seg, 1);
    end
end

function [raw, fs, labels] = load_or_generate_demo()
    fs = 500; % Hz
    dataPath = fullfile("data", "sample_lfp.mat");

    if exist(dataPath, "file")
        S = load(dataPath);
        raw = S.raw;
        labels = S.labels;
        if isfield(S, "fs"); fs = S.fs; end
        return;
    end

    % Synthetic LFP-like 2-class data
    rng(13);
    T = fs * 20;  % 20 seconds
    C = 4;
    t = (0:T-1)'/fs;

    raw = 0.25 * randn(T, C);

    % Make class-dependent power change in channel 1 (obvious for demo)
    winT = fs * 0.5;
    nWin = floor(T / winT);
    labels = zeros(nWin,1);
    labels(2:2:end) = 1; % alternating 0/1

    for i = 1:nWin
        idx = (1:winT) + (i-1)*winT;
        if labels(i) == 1
            raw(idx,1) = raw(idx,1) + 0.8*sin(2*pi*10*t(idx)); % add 10Hz oscillation
        else
            raw(idx,1) = raw(idx,1) + 0.2*sin(2*pi*10*t(idx));
        end
    end
end
