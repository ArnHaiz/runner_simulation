function [d_new, v_new, e_new] = solve(f, v, e, d, t, tau, sigma)
% Euler implicite:
v_new = (v+f(t+1))/(1+1/tau);
e_new = e + sigma - v_new*f(t+1);


% On utilise la formule pour la vitesse instantanée v = delta(d)/delta(t)
d_new = d+v_new;
end

