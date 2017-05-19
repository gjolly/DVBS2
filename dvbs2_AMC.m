function [TEB, nbIncorrectFrames] = dvbs2_AMC(modOrd, nbFrame, LDPCRate, roff, EsNo)

%% Parameters
RowInterleave = 21600;
ColumnInterleave = 3;

%% BCH encoder
[kBCH, nBCH] = BCHCoeffs(LDPCRate);
BCHEncoder = comm.BCHEncoder(nBCH, kBCH);

%% LDPC encoder
parityCheckMatrix = dvbs2ldpc(LDPCRate);
LDPCEncoder = comm.LDPCEncoder('ParityCheckMatrix', parityCheckMatrix);

%% Modulation
gamma = gamma_dvbs2(LDPCRate, modOrd);

%% shape filter emetter
txfilter = comm.RaisedCosineTransmitFilter('RolloffFactor', roff);
delay = txfilter.FilterSpanInSymbols; % Delay of the filter

%% shape filter receiver
rxfilter = comm.RaisedCosineReceiveFilter('RolloffFactor', roff);

%% LDPC decoder
LDPCDecoder = comm.LDPCDecoder('ParityCheckMatrix', parityCheckMatrix, 'IterationTerminationCondition', 'Parity check satisfied');

%% BCH decoder
BCHDecoder = comm.BCHDecoder(nBCH, kBCH);

%% Error rateuntitled
%errorRate = comm.ErrorRate;
nbErrorsFrame = zeros(1, nbFrame);

%% Simulation
for frame = 1:nbFrame
    data                  = randi([0 1], kBCH,1); % Data generation
    BCHEncodedData        = step(BCHEncoder, data); % BCH encoding
    LDPCEncodedData       = step(LDPCEncoder, BCHEncodedData); % LDCP encoding
    interleavedData       = matintrlv(LDPCEncodedData, ColumnInterleave, RowInterleave); % Interleaving
    modData               = modulation(interleavedData, modOrd, gamma);
    modDataZP             = [modData; zeros(delay, 1)]; % Zero padding 
    filteredData          = step(txfilter, modDataZP); % Pulse shaping filter
    rayChannelOutput      = raychannel(filteredData);
    [channelOutput, noiseVar] = AWGNChannel(rayChannelOutput, EsNo, txfilter, var(modData));
    filteredReceivedData  = step(rxfilter, channelOutput); % Adaptated filter
    demodulatedData       = soft_demod(filteredReceivedData(delay+1:end), modOrd, gamma, noiseVar); % Demapping
    deinterleavedData     = matintrlv(demodulatedData, RowInterleave, ColumnInterleave); % Deinterleaving
    LDPCDecodedData       = step(LDPCDecoder, deinterleavedData); % LDPC decoding
    BCHDecodedData        = step(BCHDecoder, LDPCDecodedData); % BCH decoding
    nbErrorsFrame(frame)  = sum(data ~= BCHDecodedData);
end

nbIncorrectFrames = sum(nbErrorsFrame>0);
TEB = sum(nbErrorsFrame)/(kBCH*nbFrame);

%% View
%scatterplot(modData)
%scatterplot(filteredReceivedData(delay+1:end))
%fprintf('Error rate       = %1.2f\nNumber of errors = %d\n', errorStats(1), errorStats(2))

end