%% Creates matrix crlb.mat containing Cramer-Rao Lower Bound (CRLB) for WSN Localization
%% Two Mode GMM parameters
P0=-55;
beta=2;
d0=1;
mu=[-4.36;1.73];
S=length(mu);
sigmasq = cat(3,[5.22],[4.09]);
tau=[0.37;0.63];
eta=log(sqrt(2*pi).*[sigmasq(:,:,1);sigmasq(:,:,2)]);

%% Constants
side=15;%15m
nNodes=100;
nAnchorsList=[4 8 12 16 20];
phiIndex=25;%Target index whose position is to be estimated (DENOTED BY j IN PAPER)

%% Compute CRLB
crlbList=zeros(100,length(nAnchorsList));
for aIndex=1:length(nAnchorsList)
    disp(['Calculating for nAnchors = ' num2str(nAnchorsList(aIndex))]);
    for x=1:100
        fprintf('.');
        %Create matrix containing target and anchor locations
        [phi,alpha]=place(side,nNodes,nAnchorsList(aIndex));
        %Calculate RSS at every target node
        [d,X]=findRSS(phi,alpha,P0,beta,d0,mu,sigmasq,tau);        
        %Compute CRLB
        crlbList(x,aIndex)=findCrlb(tau,mu,sigmasq,phiIndex,phi,alpha,beta,X);
    end
    fprintf(' \n');
end
crlb(:,1)=sqrt(mean((crlbList.^2)));
crlb(:,2)=nAnchorsList;

%% Save CRLB as crlb.mat
save('crlb.mat','crlb');
disp('Completed.');

