%% Used for plotting the RMSE of various localization algorithms from their .mat files
%% Load the matrices containing RMSE
load 'crlb.mat'
load 'SDPrmse.mat'
load 'WLSrmse.mat'

%% Plot RMSE 
nAnchorsList=crlb(:,2);
crlb=crlb(:,1);
SDPrmse=SDPrmse(:,1);
WLSrmse=WLSrmse(:,1);

figure;
xq = 0:0.1:max(nAnchorsList);
vq = interp1(nAnchorsList,crlb,xq,'v5cubic');
plot(xq,vq,'color',[1 0 0]);hold on;

xq = 0:0.1:max(nAnchorsList);
vq = interp1(nAnchorsList,SDPrmse,xq,'v5cubic');
plot(xq,vq,'color',[0 0 1]);

xq = 0:0.1:max(nAnchorsList);
vq = interp1(nAnchorsList,WLSrmse,xq,'v5cubic');
plot(xq,vq,'color',[0 1 0]);

%% Plot formating
legend('CRLB','GM-SDP-2','WLS');
scatter(nAnchorsList,crlb,'red','filled');
scatter(nAnchorsList,SDPrmse,'blue','filled');
scatter(nAnchorsList,WLSrmse,'green','filled');
xlabel('N');ylabel('RMSE (m)');
title('RMSE v/s number of anchors');
axis([4 20 0 12]);grid on;
