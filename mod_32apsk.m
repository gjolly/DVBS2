function y = mod_32apsk(bits, gamma)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mdulates the stream of input bits according to the 32apsk mapping
% defined for a certain gamma value. 
% Inputs : 
%     symb : The stream of input bits 
%     gamma : The 32 apsk radii ratios 
% Outputs : 
%     y : The stream of 32apsk modulated symbols
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Constellation and 32APSK bitMapping  
[constellation, bitMapping] = DVBS2Constellation('32APSK',gamma); 

% Converting bits into decimal values for mapping 
matx = reshape(bits,5,length(bits)/5)'; 
mapp =  bi2de(fliplr(matx),2)';
symb= zeros(1,length(mapp)); 

% Mappinf the values onto the correspondant constellation points 
for i=1:length(mapp)
    [idx2,idx]= find(bitMapping == mapp(i)); 
    symb(i)= constellation(idx); 
end 

% The stream of 32apsk constellation symbols 
y = symb';
end