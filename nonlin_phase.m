function y = nonlin_phase(IBO_dB, alpha_phi,beta_phi) 
% Provides the phase value at a certain input back-off based on the Am-PM
% parameters 
ibo = 10^(-IBO_dB/20); 
y = (alpha_phi.*(ibo.^2))./(1 + (beta_phi.*ibo.^2)); 
