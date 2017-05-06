function [k, n] = BCHCoeffs(LDPCRate)
if LDPCRate == 2/3
    k = 43040;
    n = 43200;
elseif LDPCRate == 3/4
    k = 48408;
    n = 48600;
elseif LDPCRate == 5/6
    k = 53840;
    n = 54000;
elseif LDPCRate == 8/9 
    k = 57472;
    n = 57600;
else
    k = 0;
    n = 0;
end 