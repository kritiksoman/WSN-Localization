%% Creates matrix wlsCDF.mat containing CDF for weighted least square (WLS)
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
%nAnchorsList=[4 8 12 16 20];
nAnchorsList=[20];

%% Compute error
for aIndex=1:length(nAnchorsList)
    disp(['Calculating for nAnchors = ' num2str(nAnchorsList(aIndex))]);
    phiHat=zeros(2,nNodes);
    phiTrue=zeros(2,nNodes);
    
    for x=1:100 %loop over all the target nodes
        fprintf('.');
        %Create matrix containing target and anchor locations
        [phi,alpha]=place(side,nNodes,nAnchorsList(aIndex));        
        %Recenter origin to first anchor location
        phiNew=phi-alpha(:,1);
        alphaNew=alpha-alpha(:,1);
        %Calculate RSS at every target node        
        [P,~]=findRSS(phiNew,alphaNew,P0,beta,d0,mu,sigmasq,tau);
        %find H,b matrices for WLS        
        d=d0*10.^((P0-P(x,:))/(10*beta));%find d from RSS
        tmp=alphaNew(:,2:end)';
        H=2*tmp;
        tmp2=d.^2-d(1).^2;
        b=sum(tmp.^2,2)-tmp2(2:end)';        
        %find S matrix for WLS
        varMat=zeros(100,nAnchorsList(aIndex));
        for i=1:100
            [P,~]=findRSS(phiNew,alphaNew,P0,beta,d0,mu,sigmasq,tau);
            d=d0*10.^((P0-P(x,:))/(10*beta));
            varMat(i,:)=d.^2;
        end
        variance=zeros(1,nAnchorsList(aIndex));
        for i=1:nAnchorsList(aIndex)
            variance(i)=mean((varMat(:,i)-mean(varMat(:,i))).^2);
        end
        tmp3 = diag(variance(2:end));
        S = tmp3+variance(1);
        
        %Find estimated position of target using WLS
        phiHat(:,x)=inv(H'*inv(S)*H)*H'*inv(S)*b;
        phiTrue(:,x)=phi(:,x);
    end
    
    %Find error in position
    dsq=sum((phiTrue-phiHat).^2);
    d=sqrt(dsq);
end

%% Save CDF as wlsCDF.mat
acc = 0.5;%round off to nearest 0.5
x = round(d/acc)*acc;
a = unique(x);
frequency = histc(x(:),a);
wlsCDF(:,1)=cumsum(frequency)./sum(frequency);
wlsCDF(:,2)=a;
save('wlsCDF.mat','wlsCDF');
disp('Completed.');
