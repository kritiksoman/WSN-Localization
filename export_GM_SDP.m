%% Creates matrix SDPrmse.mat containing RMSE for GM-SDP-2
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
phiIndex=1;%Target index whose position is to be estimated (DENOTED BY j IN PAPER)

%% Compute error in estimated target position using GM-SDP-2
rmse=zeros(1,length(nAnchorsList));
for aIndex=1:length(nAnchorsList)%iterate over all anchor sets
    disp(['Calculating for nAnchors = ' num2str(nAnchorsList(aIndex))]);
    phiHat=zeros(2,nNodes);
    phiTrue=zeros(2,nNodes);
           
    for x=1:100%100 Monte-Carlo runs
        fprintf('.');
        %Create matrix containing target and anchor locations
        [phi,alpha]=place(side,nNodes,nAnchorsList(aIndex));
        %Calculate RSS at every target node
        [P,~]=findRSS(phi,alpha,P0,beta,d0,mu,sigmasq,tau);
        % Estimate position
        gammasq=zeros(nAnchorsList(aIndex),S);
        for s=1:1:S
            gammasq(:,s)=(d0^2)*10.^((P0+mu(s)-P(phiIndex,:))/(5*beta));
        end
        [phiHat(:,x),tauHat]=estimatePos(alpha,gammasq,sigmasq,eta,nAnchorsList(aIndex));
        phiTrue(:,x)=phi(:,phiIndex);
    end
    
    %Find RMSE
    dsq=sum((phiTrue-phiHat).^2);
    rmse(aIndex)=sqrt(mean(dsq));
    fprintf(' \n');
end

%% Save RMSE as SDPrmse.mat
disp(['RMSE GM_SDP: ' num2str(rmse)]);
SDPrmse(:,1)=rmse;
SDPrmse(:,2)=nAnchorsList;
save('SDPrmse.mat','SDPrmse');
disp('Completed.');

