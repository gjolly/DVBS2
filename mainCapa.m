ordre = [4, 8, 16, 32];
LDPCRate = 8/9;
X = [-10:25];
figure();
hold on;
titleTxt = strcat('LDPC rate : ' , sprintf('%f', LDPCRate));
title(titleTxt);
xlabel('Es/No (dB)');
ylabel('Capacity (bits/s/Hz)');
%% Capacité de Shanon
    shannon = log2(1 + 10.^(X/10));
    plot(X, shannon);
for i = 1:length(ordre)
    capa = capaTh(ordre(i), LDPCRate, X(1), X(end));
    plot(X, capa);
end
legend('Shannon', 'QPSK', '8PSK', '16APSK', '32APSK');