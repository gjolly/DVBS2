clear all;
close all;

%% Simulation parameters
modulationOrder = 4; % 4 = QPSK, 8 = 8PSK, 16 = 16APSK, 32 = 32APSK
nbFrameMin = 10; % Number of frames that will be send
nbFrameMax = 11;
LDPCRate = 4/5; % Be sure that the rate exist for the specified modulation
roff = 0.35; % Roll-off of the pulse shaping filter
EsNo = 20; % Variable of the simutaion, can be the modulation order, Es/No or the LDPC rate
channel = 're';

%% Simutations
Xsize = length(EsNo);
BER = zeros(1, Xsize);
nbFrame = nbFrameMin;
nbIncorrectFramesRequire = 10;

if strcmp(channel, 'AWGN')
    for i_EsNo = 1:Xsize 
        nbIncorrectFrames = 0;
        while nbIncorrectFrames < nbIncorrectFramesRequire && nbFrame < nbFrameMax
            [BER(i_EsNo), nbIncorrectFrames] = dvbs2(modulationOrder, nbFrame, LDPCRate, roff, EsNo(i_EsNo));
            if nbIncorrectFrames < nbIncorrectFramesRequire
                nbFrame = nbFrame + 2;
            end
        end
        fprintf('Es/No :         %f\nNb Frame send : %i\n\n', EsNo(i_EsNo), nbFrame);
    end
else
    for i_EsNo = 1:Xsize 
        nbIncorrectFrames = 0;
        while nbIncorrectFrames < nbIncorrectFramesRequire && nbFrame < nbFrameMax
            [BER(i_EsNo), nbIncorrectFrames] = dvbs2_AMC(modulationOrder, nbFrame, LDPCRate, roff, EsNo(i_EsNo));
            if nbIncorrectFrames < nbIncorrectFramesRequire
                nbFrame = nbFrame + 2;
            end
        end
        fprintf('Es/No :         %f\nNb Frame send : %i\n\n', EsNo(i_EsNo), nbFrame);
    end
end
%plotBER(modulationOrder, EsNo, LDPCRate, roff, BER);

save 'results.mat' 'BER' 'EsNo' 'roff' 'LDPCRate' 'modulationOrder';
