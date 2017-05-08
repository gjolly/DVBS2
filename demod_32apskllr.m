function y = demod_32apskllr(symb,gamma) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Demodulates the stream of symbols accrording to the 32apsk mapping
% defined for a certain gamma value. 
% Inputs : 
%     symb : The stream of 32 apsk modulated symbols 
%     gamma : The 32 apsk radii ratio 
% Outputs : 
%     y : The stream of the 32apsk demapped bits 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Constellationa and bitMapping of the 32apsk 
[constellation, bitMapping] = DVBS2Constellation('32APSK',gamma); 

N=length(symb);
bitextention=fliplr(de2bi(bitMapping));

llr=zeros(5,N);
for n=1:N
    pyx=exp(-abs(symb(n)-constellation).^2);
    for ii=1:5
        llr(ii,n)=log(sum(pyx'.*(1-bitextention(:,ii))))-log(sum(pyx'.*bitextention(:,ii)));
    end
end

% The final 32apsk demmaped bit stream 
y = reshape(llr, length(llr)*5, 1);