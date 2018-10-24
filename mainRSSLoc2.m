%clear all;
%rmse over 1 node with 100 different initialization
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
nAnchorsList=[4 8 12 16 20];
%nAnchorsList=[12];

%crlbList=zeros(1,nEstimates);
phiIndex=1;%Target index whose position is to be estimated (DENOTED BY j IN PAPER)
phiHatIndex=1;%Index for phiHat where current estimate should be stored
plotting=0;
index=1;
rmse=zeros(1,length(nAnchorsList));


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
    
    %Find RMSE
    %dsq=sum((repelem(phi(:,phiIndex),1,100)-phiHat).^2);
    dsq=sum((phiTrue-phiHat).^2);
    rmse(aIndex)=sqrt(mean(dsq));
    
end

%plot(sqrt(dsq));
%disp([phiHat(:,1) phi(:,1)]);
disp('Completed.');
disp(['RMSE GM_SDP: ' num2str(rmse)]);

%figure;plot(nAnchorsList,rmse,'DisplayName','rmse');hold on;plot(nAnchorsList,crlb,'DisplayName','crlb');hold off;axis([4 20 0 6])


% for aIndex=1:length(nAnchorsList)
%     figure;
%     [phi,alpha]=place(side,nNodes,nAnchorsList(aIndex));
%     scatter(phi(1,:),phi(2,:),'filled');%target
%     grid on;hold on;
%     scatter(alpha(1,:),alpha(2,:),'filled');%anchor
%     grid on;
%     legend('Target','Anchor');
% end

% if plotting==1
%     figure('units','normalized','outerposition',[0 .25 1 0.6])%set figure at center of screen
%     subplot(1,3,1);
%     scatter(phi(1,:),phi(2,:),'filled');%target
%     hold on;
%     scatter(phi(1,phiIndex),phi(2,phiIndex),'filled');%target whose position is being estimated
%     scatter(alpha(1,:),alpha(2,:),'filled');%anchor
%     grid on;
%     legend('Node','Anchor');
%     title(['nNodes = ',num2str(nNodes),', nAnchors = ',num2str(nAnchors),', Side = ',num2str(side),'m']);
%     xlabel('x (in m)');
%     ylabel('y (in m)');
%
%     subplot(1,3,2);
%     histogram(X);
%     title('Histogram of GMM Noise');
%     xlabel('Noise (dBm)');
%     ylabel('Frequency');
%
%     subplot(1,3,3);
%     [sortd,sortloc]=sort(d(phiIndex,:));
%     bb=P(phiIndex,:);
%     scatter(sortd,bb(sortloc),'filled');
%     grid on;
%     title('Path Loss Model');
%     xlabel('distance (m)');
%     ylabel('RSS (dBm)');
% end