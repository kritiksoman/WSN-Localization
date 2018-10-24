% Determine RSS between all targets and nodes
function[d,P,X,n]=findRSS(phi,alpha,P0,beta,d0,mu,sigmasq,tau)
[~,nNodes]=size(phi);
[~,nAnchors]=size(alpha);
gm = gmdistribution(mu,sigmasq,tau);
% rng('default'); % For reproducibility
d=zeros(nNodes,nAnchors);
%n=zeros(nNodes,nAnchors);
for i=1:nNodes
     d(i,:)=sqrt(sum((repmat(phi(:,i),1,nAnchors)-alpha(:,1:nAnchors)).^2));
    %n(i,:)=random(gm,nAnchors);
end

X = random(gm,nNodes*nAnchors);
n = reshape(X,[nNodes,nAnchors]);
P=P0-10*beta*log10(d./d0)+n;
end