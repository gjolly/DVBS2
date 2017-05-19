%% Calcul Capa Théorique
function capa = capaTh(ordre, LDPCRate, min, max)
   gamma = gamma_dvbs2(LDPCRate, ordre);
   [constellation, mapping] = DVBS2Constellation(ordre, gamma);
   capa = zeros(1, abs(max - min));
   for EsNo = min:max
        %nbre de symboles tests
        N = 64800;
        %generation des symboles
        bits = randi([0 1], 1,N);

        %modulation
        modData = modulation(bits, ordre, gamma);
        noiseVariance = var(modData)/(2*10^(EsNo/10));
        
        %ajout d'un bruit gaussien
        bruitRe = normrnd(0, sqrt(noiseVariance), length(modData), 1);
        bruitIm = normrnd(0, sqrt(noiseVariance), length(modData), 1);
        bruit = bruitRe + 1i*bruitIm;

        %symboles bruités
        symboles = modData + bruit;

        %calcul de l'Entropie
        numerator = zeros(length(symboles), 1);
        denominator = zeros(length(symboles), 1);
        PX = 1/(2^ordre);
        PYX = zeros(length(symboles), length(constellation));
        
        numerator = exp(- abs(bruit).^2 / (2*noiseVariance));
        for i = 1:length(constellation)
            PYX(:, i) = exp( - abs(constellation(i) - symboles).^2 / (2*noiseVariance));
            denominator =  denominator + PYX(:,i);
        end
        
        somme = zeros(length(symboles), 1);
        for i = 1:length(constellation)
            somme = somme + PX * numerator./denominator;
        end
        HXY = -mean(log2(somme));
        HX = ordre;
        capa(EsNo+abs(min) + 1) = HX - HXY;
   end
end
