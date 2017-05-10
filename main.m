
%% Simulation parameters
modulationOrder = 4; % 4 = QPSK, 8 = 8PSK, 16 = 16APSK, 32 = 32APSK
nbFrame = 50; % Number of frames that will be send
LDPCRate = 1/2; % Be sure that the rate exist for the specified modulation
roff = 0.35; % Roll-off of the pulse shaping filter
EsNoPas = 2; % Variable of the simutaion, can be the modulation order, Es/No or the LDPC rate

%% Simutations
Xsize = length(EsNoPas);
BER = zeros(1, Xsize);
i = 1;
previousBER = 1; % use for the end condition

while i <= Xsize && previousBER > 0
    EbNo = EsNoPas(i);
    BER(i) = dvbs2(modulationOrder, nbFrame, LDPCRate, roff, EbNo);
    previousBER = BER(i);
    i = i + 1;
end
plotBER(modulationOrder, EsNoPas, LDPCRate, roff, BER);

save 'results.mat' 'BER'; 
