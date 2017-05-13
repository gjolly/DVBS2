clear all;
close all;

%% Simulation parameters
modulationOrder = 32; % 4 = QPSK, 8 = 8PSK, 16 = 16APSK, 32 = 32APSK
nbFrameMin = 15; % Number of frames that will be send
nbFrameMax = 60;
LDPCRate = 4/5; % Be sure that the rate exist for the specified modulation
roff = 0.35; % Roll-off of the pulse shaping filter
EsNo = 13:0.01:14; % Variable of the simutaion, can be the modulation order, Es/No or the LDPC rate

%% Simutations
Xsize = length(EsNo);
BER = zeros(1, Xsize);
nbFrame = nbFrameMin;
nbIncorrectFramesRequire = 10;

for i_EsNo = 1:Xsize 
    nbIncorrectFrames = 0;
    while nbIncorrectFrames < nbIncorrectFramesRequire && nbFrame < nbFrameMax
        [BER(i_EsNo), nbIncorrectFrames] = dvbs2(modulationOrder, nbFrame, LDPCRate, roff, EsNo(i_EsNo));
        if nbIncorrectFrames < nbIncorrectFramesRequire
            nbFrame = nbFrame + 2;
        end
    end
end
%plotBER(modulationOrder, EsNo, LDPCRate, roff, BER);

save 'results.mat' 'BER' 'EsNo' 'roff' 'LDPCRate' 'modulationOrder';
