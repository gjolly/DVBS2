function y = nonlinearity(vec,ibo_dB,alpha_a,beta_a,alpha_phi,beta_phi)
% Non linear transFormation of the input vector following Saleh's model
% Inputs : 
%     Vec : The vector to be transformed by the nonlinearity 
%     ibo_dB : The input backoff towrads the saturation power. 
%     alpha_a, beta_a : The AM/AM parameters 
%     alpha_phi, beta_phi : The AM/PM parameters 
% Outputs : 
%     y = AM_AM(vec).*exp(1j.*( AM_PM(vec) + angle(vec))); 

% The Input gain 
ibo = 10^(ibo_dB/10); 
Gi = 1./(ibo*mean(abs(vec).^2)); 
r = sqrt(Gi).*abs(vec); 

% AM_AM and AM_PM responses 
AM_AM  = (alpha_a.*r)./(1 + (beta_a.*r.^2)); 
AM_PM  = (alpha_phi.*(r.^2))./(1 + (beta_phi.*r.^2)); 

% Normalized Output vector 
y  = AM_AM.*exp(1j.*( AM_PM + angle(vec))); 
y = y./mean(abs(y).^2); 
 
 
 
  
 
  