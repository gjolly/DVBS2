
%% Simulation parameters
modulationOrder = 4; % 4 = QPSK, 8 = 8PSK, 16 = 16APSK, 32 = 32APSK
nbFrame = 10; % Number of frames that will be send
LDPCRate = 3/4; % Be sure that the rate exist for the specified modulation
roff = 0.35; % Roll-off of the pulse shaping filter
X = 0:0.5:5; % Variable of the simutaion, can be the modulation order, Es/No or the LDPC rate

%% Simutations
BER = zeros(1, length(X));
i = 1;

for EbNo = X
    BER(i) = dvbs2(modulationOrder, nbFrame, LDPCRate, roff, EbNo);
    i = i + 1;
end
plotBER(modulationOrder, EsNoPas, LDPCRate, roff, BER);
    