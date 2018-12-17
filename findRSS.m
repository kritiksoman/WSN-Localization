%% Returns the Received Signal Strength (RSS) at all target nodes in a WSN
function[P,X]=findRSS(phi,alpha,P0,beta,d0,mu,sigmasq,tau)
[~,nNodes]=size(phi);
[~,nAnchors]=size(alpha);
gm = gmdistribution(mu,sigmasq,tau);
% rng('default'); % For reproducibility
d=zeros(nNodes,nAnchors);

%Distance between jth target and ith anchor
for i=1:nNodes
     d(i,:)=sqrt(sum((repmat(phi(:,i),1,nAnchors)-alpha(:,1:nAnchors)).^2));
end

X = random(gm,nNodes*nAnchors);
n = reshape(X,[nNodes,nAnchors]);%Noise
P=P0-10*beta*log10(d./d0)+n;%Path Loss Model
end