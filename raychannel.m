function outputSignal = raychannel(inputSignal)
ray = sqrt(0.5*((randn(1, length(inputSignal))).^2+(randn(1, length(inputSignal))).^2)).';
outputSignal = inputSignal.*ray;
end