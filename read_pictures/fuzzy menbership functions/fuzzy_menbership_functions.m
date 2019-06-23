x = linspace(-15, 15, 1000);
mu = trimf(x, [-2,3,6]);
plot(x, mu)
mu = trimf(x, [-2,0,6]);
plot(x, mu)
xlabel('trimf , P=[-2, 0, 6]');
