function [noisedData, noiseVariance] = AWGNChannel(data, EsNo, shapingFilter, varSrc)
coeff = coeffs(shapingFilter);
noiseVariance = sum(abs(coeff.Numerator).^2)*varSrc/(2*10^(EsNo/10));
noisedData = data + normrnd(0, sqrt(noiseVariance), size(data)) + 1i*normrnd(0, sqrt(noiseVariance), size(data));