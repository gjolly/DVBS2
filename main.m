nbFrame = 10; % Number of frames that will be send
LDPCRate = 2/3; % Be sure that the rate exist for the specified modulation
roff = 0.35; % Roll-off of the pulse shaping filter
modulation = '8PSK'; % 8PSK, 16APSK, 32APSK or all (for the three ones)
EbNoPas = 0;

TEB_8 = zeros(1, length(EbNoPas));
TEB_16 = zeros(1, length(EbNoPas));
TEB_32 = zeros(1, length(EbNoPas));
i_8 = 1;
i_16 = 1;
i_32 = 1;

if strcmp(modulation, '8PSK')
    for EbNo = EbNoPas
        TEB_8(i_8) = dvbs2_8psk(nbFrame, LDPCRate, roff, EbNo);
        i_8 = i_8 + 1;
    end
    plotTEB(modulation, EbNoPas, LDPCRate, roff, TEB_8);
elseif strcmp(modulation, '16APSK')
    for EbNo = EbNoPas
        TEB_16(i_16) = dvbs2_16apsk(nbFrame, LDPCRate, roff, EbNo);
        i_16 = i_16 + 1;
    end
    plotTEB(modulation, EbNoPas, LDPCRate, roff, TEB_16);
elseif strcmp(modulation, '32APSK')
    for EbNo = EbNoPas
        TEB_32(i_32) = dvbs2_32apsk(nbFrame, LDPCRate, roff, EbNo);
        i_32 = i_32 + 1;
    end
    plotTEB(modulation, EbNoPas, LDPCRate, roff, TEB_32);
else
    for EbNo = EbNoPas
        TEB_8(i_8) = dvbs2_8psk(nbFrame, LDPCRate, roff, EbNo);
        i_8 = i_8 + 1;
    end
    for EbNo = EbNoPas
        TEB_16 = dvbs2_16apsk(nbFrame, LDPCRate, roff, EbNo);
        i_16 = i_16 + 1;
    end
    for EbNo = EbNoPas
        TEB_32(i_32) = dvbs2_16apsk(nbFrame, LDPCRate, roff, EbNo);
        i_32 = i_32 + 1;
    end
    
    plotTEB('all', EbNoPas, LDPCRate, roff, [TEB_8 TEB_16 TEB_32]);
end