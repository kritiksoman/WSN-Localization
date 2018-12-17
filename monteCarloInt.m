%% Returns the value of monte-carlo integration used in calculating the fisher information matrix
function [In] = monteCarloInt(tau,mu,sigmasq,X)
n = sort(X);%Contains samples of noise from GMM
p1 = tau(1)*(1/(sqrt(2*pi*sigmasq(:,:,1))))*exp(-(n-mu(1)).^2/(2*sigmasq(:,:,1)));
p2 = tau(2)*(1/(sqrt(2*pi*sigmasq(:,:,2))))*exp(-(n-mu(2)).^2/(2*sigmasq(:,:,2)));
p=p1+p2;%PDF of the GMM

gradp1 = -p1.*(n-mu(1))/sigmasq(:,:,1);
gradp2 = -p2.*(n-mu(2))/sigmasq(:,:,2);
gradp=gradp1+gradp2;%PDF of the derivative of the GMM

f=(gradp.*gradp)./p;
In=mean(f)*range(n);
end