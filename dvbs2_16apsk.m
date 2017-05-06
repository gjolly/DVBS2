close all;
clear all;
clc;

%% Parameters
modOrd = 16; % Modulation order
bitPerSymbol = log2(modOrd); % Nombre de bits par symbole 
nbSymb = 2000; %Nombre de symboles à générer
roff = 0.35; % Rolloff shape filter
nbsamples = 8; % Samples per symbols
LDPCRate = 3/4;
nbFrame = 10; % number of frame to send
EbNo = 2; % Eb/No
RowInterleave = 16200;
ColumnInterleave = 4;

%% BCH encoder
[kBCH, nBCH] = BCHCoeffs(LDPCRate);
BCHEncoder = comm.BCHEncoder(nBCH, kBCH);

%% LDPC encoder
parityCheckMatrix = dvbs2ldpc(LDPCRate);
LDPCEncoder = comm.LDPCEncoder('ParityCheckMatrix', parityCheckMatrix);

%% Modulation
gamma = gamma_dvbs2(LDPCRate);

%% shape filter emetter
txfilter = comm.RaisedCosineTransmitFilter('RolloffFactor', roff);
delay = txfilter.FilterSpanInSymbols; % Delay of the filter

%% Canal
channel = comm.AWGNChannel('EbNo', EbNo,'BitsPerSymbol', bitPerSymbol);

%% shape filter receiver
rxfilter = comm.RaisedCosineReceiveFilter('RolloffFactor', roff);

%% Demodulator
demodulator = comm.PSKDemodulator(modOrd, 'BitOutput',true, 'DecisionMethod','Approximate log-likelihood ratio', 'Variance', 1/10^(channel.SNR/10));

%% LDPC decoder
LDPCDecoder = comm.LDPCDecoder('ParityCheckMatrix', parityCheckMatrix);

%% BCH decoder
BCHDecoder = comm.BCHDecoder(nBCH, kBCH);

%% Error rate
errorRate = comm.ErrorRate;

%% Simulation
for frame = 1:nbFrame
    data                = randi([0 1], kBCH,1);
    BCHEncodedData      = step(BCHEncoder, data);
    LDPCEncodedData     = step(LDPCEncoder, BCHEncodedData);
    interleavedData     = matintrlv(LDPCEncodedData, ColumnInterleave, RowInterleave);
    modData             = mod_16apsk(interleavedData, gamma);
    %modDataZP          = [modData; zeros(delay, 1)];
    %filterData         = step(txfilter, modDataZP);
    channelOutput       = step(channel, modData);
    %filterDataReceiver = step(rxfilter, channelOutput);
    demodulatedData     = demod_16apskllr(channelOutput, gamma);
    deinterleavedData   = matintrlv(demodulatedData, RowInterleave, ColumnInterleave);
    LDPCDecodedData     = step(LDPCDecoder, deinterleavedData);
    BCHDecodedData      = step(BCHDecoder, LDPCDecodedData);
    errorStats          = step(errorRate, logical(data), BCHDecodedData);
end

%% View
%scatterplot(modData)
%scatterplot(filterDataReceiver(delay+1:end))
fprintf('Error rate       = %1.2f\nNumber of errors = %d\n', errorStats(1), errorStats(2))