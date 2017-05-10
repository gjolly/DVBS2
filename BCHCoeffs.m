function [k, n] = BCHCoeffs(LDPCRate)
switch LDPCRate
    case 1/2
        k = 32208;
        n = 32400;
    case 2/3
        k = 43040;
        n = 43200;
    case 3/4
        k = 48408;
        n = 48600;
    case 5/6
        k = 53840;
        n = 54000;
    case 8/9 
        k = 57472;
        n = 57600;
    otherwise
        k = 0;
        n = 0;
end 