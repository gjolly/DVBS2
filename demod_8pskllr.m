function y = demod_8pskllr(symb) 

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
[constellation, bitMapping] = DVBS2Constellation('8PSK'); 

N=length(symb);
bitextention=fliplr(de2bi(bitMapping));

llr=zeros(3,N);
for n=1:N
    pyx=exp(-abs(symb(n)-constellation).^2);
    for ii=1:3
        llr(ii,n)=log(sum(pyx'.*(1-bitextention(:,ii))))-log(sum(pyx'.*bitextention(:,ii)));
    end
end

% The final 16apsk demmaped bit stream 
y = reshape(llr, length(llr)*3, 1);


    
 