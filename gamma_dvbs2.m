function g = gamma_dvbs2(rate, modOrd) 
if any(modOrd == [4 8]) 
    g = 0;
elseif modOrd == 16
    if rate == 2/3
        g = 3.1;
    elseif rate == 3/4
        g = 2.85;
    elseif rate == 4/5
        g = 2.75;
    elseif rate == 5/6
        g = 2.6;
    elseif rate == 8/9 
        g = 2.58;
    else g = 2;
    end 
elseif modOrd == 32
    if rate == 3/4
        g = [2.84 5.27];
    elseif rate == 4/5
        g = [2.72, 4.87];
    elseif rate == 5/6
        g = [2.64 4.64];
    elseif rate == 9/10 
        g = [2.53 4.30];
    else g = [2.84 5.27];
   end 
end
    