function plotTEB(modulation, EbNoPas, LDPCRate, roff, TEB)
    if strcmp(modulation, 'all')
        hold on;
        semilogy(EbNoPas, TEB(1), 'red');
        semilogy(EbNoPas, TEB(2), 'blue');
        semilogy(EbNoPas, TEB(3), 'green');
        
        legend('8PSK', '16APSK', '32APSK');
    else
        semilogy(EbNoPas, TEB);
        legend(modulation);
    end
        
    grid on;
    xlabel('Eb/No(dB)');
    ylabel('TEB');
    titleTxt = strcat('LDPC rate : ' , sprintf('%f', LDPCRate), ', Rolloff : ', sprintf('%f', roff));
    title(titleTxt);
end