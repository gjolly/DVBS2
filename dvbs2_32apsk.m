function TEB = dvbs2_32apsk(nbFrame, LDPCRate, roff, EbNo)

%% Parameters
modOrd = 16; % Modulation order
bitPerSymbol = log2(modOrd); % Nombre de bits par symbole 
RowInterleave = 16200;
ColumnInterleave = 4;

%% BCH encoder
[kBCH, nBCH] = BCHCoeffs(LDPCRate);
BCHEncoder = comm.BCHEncoder(nBCH, kBCH);

%% LDPC encoder
parityCheckMatrix = dvbs2ldpc(LDPCRate);
LDPCEncoder = comm.LDPCEncoder('ParityCheckMatrix', parityCheckMatrix);

%% Modulation
gamma = gamma_dvbs2(LDPCRate, '32APSK');

%% shape filter emetter
txfilter = comm.RaisedCosineTransmitFilter('RolloffFactor', roff);
delay = txfilter.FilterSpanInSymbols; % Delay of the filter

%% Canal
channel = comm.AWGNChannel('EbNo', EbNo,'BitsPerSymbol', bitPerSymbol);

%% shape filter receiver
rxfilter = comm.RaisedCosineReceiveFilter('RolloffFactor', roff);

%% LDPC decoder
LDPCDecoder = comm.LDPCDecoder('ParityCheckMatrix', parityCheckMatrix);

%% BCH decoder
BCHDecoder = comm.BCHDecoder(nBCH, kBCH);

%% Error rate
errorRate = comm.ErrorRate;

%% Simulation
for frame = 1:nbFrame
    data                  = randi([0 1], kBCH,1); % Data generation
    BCHEncodedData        = step(BCHEncoder, data); % BCH encoding
    LDPCEncodedData       = step(LDPCEncoder, BCHEncodedData); % LDCP encoding
    interleavedData       = matintrlv(LDPCEncodedData, ColumnInterleave, RowInterleave); % Interleaving
    modData               = mod_32apsk(interleavedData, gamma);
    modDataZP             = [modData; zeros(delay, 1)]; % Zero padding 
    filteredData          = step(txfilter, modDataZP); % Pulse shaping filter
    channelOutput         = step(channel, filteredData); % Channel
    filteredReceivedData  = step(rxfilter, channelOutput); % Adaptated filter
    demodulatedData       = demod_32apskllr(filteredReceivedData(delay+1:end), gamma); % Demapping
    deinterleavedData     = matintrlv(demodulatedData, RowInterleave, ColumnInterleave); % Deinterleaving
    LDPCDecodedData       = step(LDPCDecoder, deinterleavedData); % LDPC decoding
    BCHDecodedData        = step(BCHDecoder, LDPCDecodedData); % BCH decoding
    errorStats            = step(errorRate, logical(data), BCHDecodedData); % BER computing
end

TEB = errorStats(1);

%% View
%scatterplot(modData)
%scatterplot(filterDataReceiver(delay+1:end))
%fprintf('Error rate       = %1.2f\nNumber of errors = %d\n', errorStats(1), errorStats(2))

end