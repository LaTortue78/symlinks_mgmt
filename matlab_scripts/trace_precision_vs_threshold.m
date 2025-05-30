function trace_precision_vs_threshold(f_values, y_true, alpha)
    if nargin < 3
        alpha = 0.9; % pondération par défaut
    end

    % Vecteurs colonnes
    f_values = f_values(:);
    y_true = y_true(:);

    thresholds = unique(f_values);
    N = length(thresholds);

    precision0 = zeros(N,1);
    precision1 = zeros(N,1);
    score = zeros(N,1);

    % Calcul des précisions et du score pour chaque seuil
    for i = 1:N
        tau = thresholds(i);
        y_pred = double(f_values >= tau);

        [p0, p1] = compute_precisions(y_true, y_pred);
        precision0(i) = p0;
        precision1(i) = p1;
        score(i) = alpha * p0 + (1 - alpha) * p1;
    end

    % Seuil optimal
    [~, idx_best] = max(score);
    tau_best = thresholds(idx_best);

    % Tracé
    figure;
    plot(thresholds, precision0, 'b-', 'LineWidth', 2); hold on;
    plot(thresholds, precision1, 'r--', 'LineWidth', 2);
    plot(tau_best, precision0(idx_best), 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b');
    plot(tau_best, precision1(idx_best), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');

    legend('Précision classe 0', 'Précision classe 1', 'Location', 'best');
    xlabel('Seuil \tau');
    ylabel('Précision');
    title(sprintf('Précision des classes selon le seuil (\\alpha = %.2f)', alpha));
    grid on;
end

function [prec0, prec1] = compute_precisions(y_true, y_pred)
    TP = sum((y_true == 1) & (y_pred == 1));
    TN = sum((y_true == 0) & (y_pred == 0));
    FP = sum((y_true == 0) & (y_pred == 1));
    FN = sum((y_true == 1) & (y_pred == 0));

    if (TN + FP) > 0
        prec0 = TN / (TN + FP);
    else
        prec0 = 0;
    end

    if (TP + FN) > 0
        prec1 = TP / (TP + FN);
    else
        prec1 = 0;
    end
end

