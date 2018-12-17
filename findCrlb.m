%% Returns CRLB for a particular target and anchor placement 
function [crlb]=findCrlb(tau,mu,sigmasq,phiIndex,phi,alpha,beta,X)
In=monteCarloInt(tau,mu,sigmasq,X);
I=zeros(2);
for v=1:2%iterate over first dimension in 2D plane
    for r=1:2%iterate over second dimension in 2D plane
        Num=(phi(v,phiIndex)-alpha(v,:)).*(phi(r,phiIndex)-alpha(r,:));
        Dem=(sum(((repmat(phi(:,phiIndex),1,length(alpha))-alpha).^2),1)).^2;
        I(v,r)=((10*beta)/(log(10)))^2*In*sum(Num./Dem);%Terms of the Fisher Information Matrix
    end
end
%CRLB from Fisher Information Matrix
crlb=sqrt(trace(I^-1));
end
