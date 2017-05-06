function g = gamma_dvbs2(rate, modulation) 
if strcmp(modulation, '16APSK')
    if rate == 2/3
        g = 3.1;
    elseif rate == 3/4
        g = 2.85;
    elseif rate == 5/6
        g = 2.6;
    elseif rate == 8/9 
        g = 2.58;
    else g = 2;
    end 
else
    if rate == 3/4
        g = [2.81 5.27];
    elseif rate == 5/6
        g = [2.64 4.64];
    elseif rate == 9/10 
        g = [2.53 4.30];
    else g = [2.81 5.27];
   end 
end
    