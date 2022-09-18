function [tArray, yArray] = nonlinearGenerate(sigmaVec, tMax)


p = 1; n = 2;
yInitData = sigmaVec*randn(n,1)
    coupling1Mat = [0 0; 1 0];

    tArray = -p:tMax;
    yArray = [yInitData nan(n,tMax+1)];
    
    for s = p+1:p+tMax+1 % index s = p+t+1
        yArray(:,s) = coupling1Mat*(yArray(:,s-1).^2) + sigmaVec.*randn(n,1);
    end


end
