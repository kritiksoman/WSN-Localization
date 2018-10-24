%Plots the CDF of the error in estimated target position
%Two Mode GMM parameters
P0=-55;
beta=2;
d0=1;
mu=[-4.36;1.73];
S=length(mu);
sigmasq = cat(3,[5.22],[4.09]);
tau=[0.37;0.63];
eta=log(sqrt(2*pi).*[sigmasq(:,:,1);sigmasq(:,:,2)]);

%Target and anchor deployment
side=15;%15m
nNodes=100;
%nAnchorsList=[4 8 12 16 20];
nAnchorsList=[20];
phiIndex=1;%Target index whose position is to be estimated (DENOTED BY j IN PAPER)

for aIndex=1:length(nAnchorsList)
    disp(['Calculating for nAnchors = ' num2str(nAnchorsList(aIndex))]);
    phiHat=zeros(2,nNodes);
    phiTrue=zeros(2,nNodes);   
        
    for x=1:100
        %fprintf([num2str(x) ' '])
        fprintf('.')
        [phi,alpha]=place(side,nNodes,nAnchorsList(aIndex));
        [d,P,X,n]=findRSS(phi,alpha,P0,beta,d0,mu,sigmasq,tau);
        % Estimate position
        gammasq=zeros(nAnchorsList(aIndex),S);
        for s=1:1:S
            gammasq(:,s)=(d0^2)*10.^((P0+mu(s)-P(phiIndex,:))/(5*beta));
        end
        [phiHat(:,x),tauHat]=estimatePos(alpha,gammasq,sigmasq,eta,nAnchorsList(aIndex));
        phiTrue(:,x)=phi(:,phiIndex);
        %dsq(x,:)=sum((phi-phiHat).^2);%??
    end
    
    %Find error in position
    dsq=sum((phiTrue-phiHat).^2);
    d=sqrt(dsq);    
end

acc = 0.5;%round off to nearest 0.5
x = round(d/acc)*acc;
a = unique(x);
frequency = histc(x(:),a);
sdpCDF=cumsum(frequency)./sum(frequency);
plot(a,sdpCDF,'Marker','.','MarkerSize',20);
title('CDF');xlabel('Error (in m)');ylabel('CDF');
grid on;legend('GM-SDP-2');
