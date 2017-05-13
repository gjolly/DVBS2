function plotBER(modOrd, EbNoPas, LDPCRate, roff, TEB)
    
    switch modOrd
        case 4
            modulation = 'QPSK';
        case 8
            modulation = '8PSK';
        case 16
            modulation = '16APSK';
        case 32
            modulation = '32APSK';
    end

    semilogy(EbNoPas, TEB, '+');
    legend(modulation);
        
    grid on;
    xlabel('Es/No(dB)');
    ylabel('BER');
    titleTxt = strcat('LDPC rate : ' , sprintf('%f', LDPCRate), ', Rolloff : ', sprintf('%f', roff));
    title(titleTxt);
end