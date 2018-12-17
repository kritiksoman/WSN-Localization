%% Creates matrix sdpCDF.mat containing CDF for GM-SDP-2
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
        %Calculate RSS at every target node
        [P,~]=findRSS(phi,alpha,P0,beta,d0,mu,sigmasq,tau);
        %Estimate position
        gammasq=zeros(nAnchorsList(aIndex),S);
        for s=1:1:S
            gammasq(:,s)=(d0^2)*10.^((P0+mu(s)-P(x,:))/(5*beta));
        end
        [phiHat(:,x),tauHat]=estimatePos(alpha,gammasq,sigmasq,eta,nAnchorsList(aIndex));
        phiTrue(:,x)=phi(:,x);
    end
    
    %Find error in position
    dsq=sum((phiTrue-phiHat).^2);
    d=sqrt(dsq);    
end

%% Save CDF as sdpCDF.mat
acc = 0.5;%round off to nearest 0.5
x = round(d/acc)*acc;
a = unique(x);
frequency = histc(x(:),a);
sdpCDF(:,1)=cumsum(frequency)./sum(frequency);
sdpCDF(:,2)=a;
save('sdpCDF.mat','sdpCDF');
disp('Completed.');
