%% Creates matrix SDPrmse.mat containing RMSE for WLS
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

%% Compute error in estimated target position using WLS
errList=zeros(100,length(nAnchorsList));
for aIndex=1:length(nAnchorsList)
    disp(['Calculating for nAnchors = ' num2str(nAnchorsList(aIndex))]);
    for y=1:100
        fprintf('.');
        %Create matrix containing target and anchor locations
        [phi,alpha]=place(side,nNodes,nAnchorsList(aIndex));
        %Recenter origin to first anchor location
        phiNew=phi-alpha(:,1);
        alphaNew=alpha-alpha(:,1);
        %Calculate RSS at every target node  
        [P,~]=findRSS(phiNew,alphaNew,P0,beta,d0,mu,sigmasq,tau);
        %find H,b matrices for WLS        
        d=d0*10.^((P0-P(phiIndex,:))/(10*beta));%find d from RSS
        tmp=alphaNew(:,2:end)';
        H=2*tmp;
        tmp2=d.^2-d(1).^2;
        b=sum(tmp.^2,2)-tmp2(2:end)';
        
        %find S matrix for WLS
        varMat=zeros(100,nAnchorsList(aIndex));
        for x=1:100
            [P,~]=findRSS(phiNew,alphaNew,P0,beta,d0,mu,sigmasq,tau);
            d=d0*10.^((P0-P(phiIndex,:))/(10*beta));
            varMat(x,:)=d.^2;
        end
        variance=zeros(1,nAnchorsList(aIndex));
        for x=1:nAnchorsList(aIndex)
            variance(x)=mean((varMat(:,x)-mean(varMat(:,x))).^2);
        end
        tmp3 = diag(variance(2:end));
        S = tmp3+variance(1);
        
        %Find estimated position of target using WLS
        wlsEst=inv(H'*inv(S)*H)*H'*inv(S)*b;
        errList(y,aIndex)=(norm(wlsEst-phiNew(:,phiIndex)));%append error for WLS   
        
    end
    fprintf(' \n');
end

%% Save RMSE as WLSrmse.mat
WLSrmse(:,1)=sqrt(mean(errList.^2));%WLS RMSE
WLSrmse(:,2)=nAnchorsList;
disp(WLSrmse(:,1));
save('WLSrmse.mat','WLSrmse');
disp('Completed.');

