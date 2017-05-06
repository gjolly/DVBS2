function y = demod_16apsk(symb,gamma) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Demodulates the stream of symbols accrording to the 16apsk mapping
% defined for a certain gamma value. 
% Inputs : 
%     symb : The stream of 16 apsk modulated symbols 
%     gamma : The 16 apsk radii ratio 
% Outputs : 
%     y : The stream of the 16APSK demapped bits 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Constellationa and bitMapping of the 16apsk 
[constellation, bitMapping] = DVBS2Constellation('16APSK',gamma); 

% Demapping 
demap = zeros(length(symb),4); 
for i=1:length(symb)
    [~,idx]= find(constellation == symb(i)); 
    demap(i,:)= fliplr((de2bi(bitMapping(idx),4))); 
end 

% The final 16apsk demmaped bit stream 
y = reshape(demap',1,length(symb)*4);





    
 