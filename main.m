
%% Simulation parameters
modulationOrder = 4; % 4 = QPSK, 8 = 8PSK, 16 = 16APSK, 32 = 32APSK
nbFrame = 50; % Number of frames that will be send
LDPCRate = 3/4; % Be sure that the rate exist for the specified modulation
roff = 0.35; % Roll-off of the pulse shaping filter
X = 3; % Variable of the simutaion, can be the modulation order, Es/No or the LDPC rate

%% Simutations
Xsize = length(X);
BER = zeros(1, Xsize);
i = 1;
BER(i) = 1;

while i <= Xsize && BER(i) > 0
    EbNo = X(i);
    BER(i) = dvbs2(modulationOrder, nbFrame, LDPCRate, roff, EbNo);
    i = i + 1;
end
%plotBER(modulationOrder, X, LDPCRate, roff, BER);

save 'Results.mat' 'BER' 