% Générer des données simulées
f_values = randn(200, 1);
y_true = double(f_values > 0.5);  % Label 1 si f(x) > 0.5

% Tracer les courbes de précision
trace_precision_vs_threshold(f_values, y_true, 0.9);

