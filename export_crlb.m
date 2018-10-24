%clear all;
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
%nAnchorsList=[20];

%crlbList=zeros(1,nEstimates);
phiIndex=3;%Target index whose position is to be estimated (DENOTED BY j IN PAPER)
phiHatIndex=1;%Index for phiHat where current estimate should be stored
plotting=0;


crlbList=zeros(100,length(nAnchorsList));
for aIndex=1:length(nAnchorsList)
    disp(['Calculating for nAnchors = ' num2str(nAnchorsList(aIndex))]);
    for x=1:100
        %fprintf([num2str(x) ' '])
        fprintf('.')
        [phi,alpha]=place(side,nNodes,nAnchorsList(aIndex));
        [d,P,X,n]=findRSS(phi,alpha,P0,beta,d0,mu,sigmasq,tau);        
        %Compute CRLB
        crlbList(x,aIndex)=findCrlb(tau,mu,sigmasq,phiIndex,phi,alpha,beta,plotting,X);
    end
    fprintf(' \n')
end

crlb=sqrt(mean((crlbList.^2)));
disp(['RMSE CRLB is ' num2str(crlb)]);

figure;
xq = 0:0.1:max(nAnchorsList);
vq = interp1(nAnchorsList,crlb,xq,'v5cubic');
plot(xq,vq,'color',[0 0.5 0]);hold on;scatter(nAnchorsList,crlb,'black','filled');
xlabel('N');ylabel('RMSE (m)');title('RMSE v/s number of anchors');
axis([4 20 0 6]);grid on;

% xq = 0:0.1:max(nAnchorsList);
% vq = interp1(nAnchorsList,rmse,xq,'v5cubic');
% plot(xq,vq,'color',[0 0 1]);hold on;scatter(nAnchorsList,rmse,'blue','filled');
% xlabel('N');ylabel('RMSE (m)');title('RMSE v/s number of anchors');
% axis([4 20 0 6]);grid on;
% legend('CRLB');

% for k=1:100
%     index=1;
%     for nAnchors=nAnchorsList
%         %disp(['Calculating for nAnchors = ' num2str(nAnchors)]);
%         [phi,alpha]=place(side,nNodes,nAnchors);
%         [d,P,X,n]=findRSS(phi,alpha,P0,beta,d0,mu,sigmasq,tau);
%         %Compute CRLB
%         crlbList(index)=findCrlb(tau,mu,sigmasq,phiIndex,phi,alpha,beta,plotting,X);
%         index=index+1;
%     end
%     crlbrmse(k,:)=crlbList;
% end

%plot(sqrt(mean((crlbrmse.^2))));hold on;
%plot(mean(crlbrmse));hold on;
%plot(crlbList);hold on;