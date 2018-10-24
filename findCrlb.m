%Function to find the CRLB of localization error in WSN
function [crlb]=findCrlb(tau,mu,sigmasq,phiIndex,phi,alpha,beta,plotting,X)
In=monteCarloInt(tau,mu,sigmasq,X,plotting);
I=zeros(2);
for v=1:2
    for r=1:2
        Num=(phi(v,phiIndex)-alpha(v,:)).*(phi(r,phiIndex)-alpha(r,:));
        Dem=(sum(((repmat(phi(:,phiIndex),1,length(alpha))-alpha).^2),1)).^2;
        I(v,r)=((10*beta)/(log(10)))^2*In*sum(Num./Dem);
    end
end
%disp(I);
crlb=sqrt(trace(I^-1));

% xq = 0:0.1:max(nAnchorsList);
% vq = interp1(nAnchorsList,crlbList,xq,'v5cubic');
% plot(xq,vq);hold on;scatter(nAnchorsList,crlbList,'filled');
% plot(nAnchorsList,crlbList,'Marker','.','MarkerSize',20);
end
