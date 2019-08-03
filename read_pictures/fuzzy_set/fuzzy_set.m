udark = @(z) 1 - sigmf(z, [0.35 0.5]);
% ugray = @(z) trimf(z, 0.35, 0.5, 0.65);
% ubright = @(z) sigmf(z, 0.5, 0.65);

fplot(udark, [0 1], 20)

