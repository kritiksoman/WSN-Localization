%Estimates the position of the target using GM-SDP2
function [phiHat,tauHat]=estimatePos(alpha,gammasq,sigmasq,eta,nAnchors)

alphaSqSum=sum((alpha.^2),1);
cvx_begin sdp quiet
variable capPsi(2,2) symmetric
variables x(nAnchors) y(nAnchors) phiHat(2,1) tauHat(2,nAnchors) xi(nAnchors,2)
minimize(norm(x,1)+norm(y,1))
subject to

for i=1:nAnchors
    sum(tauHat(:,i))==1%C1
    for s=1:2
        tauHat(s,i)>=0%C2
        tauHat(s,i)<=1%C2
        trace(capPsi)-2*phiHat'*alpha(:,i)+alphaSqSum(i)<= gammasq(i,s)*sigmasq(:,:,s)*xi(i,s)%C4
        [ trace(capPsi)-2*phiHat'*alpha(:,i)+alphaSqSum(i)     sqrt(gammasq(i,s)/sqrt(sigmasq(:,:,s))); ...
            sqrt(gammasq(i,s)/sqrt(sigmasq(:,:,s)))                     xi(i,s)] >= 0%C5
        
    end
    %phiHat>=alpha(:,i)+1e-10
    %phiHat<=alpha(:,i)-1e-10
    %norm(smallPsi-alpha(:,i),2)<=50%C3
    %norm(phiHat-alpha(:,i),2)>0
    
    [ capPsi       phiHat; ...
        phiHat'    1 ] >= 0%C6
    
    x(i)>=trace(tauHat(:,i)*eta')%C7
    y(i)>=sum(xi(i,:))%C8
end

cvx_end;

end