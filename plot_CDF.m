%% Used for plotting the CDF of various localization algorithms from their .mat files
%% Load the matrices containing CDF
load 'wlsCDF.mat'
load 'sdpCDF.mat'

%% Plot CDF
figure;
plot(sdpCDF(:,2),sdpCDF(:,1),'Marker','.','MarkerSize',20);
title('CDF');xlabel('Error (in m)');ylabel('CDF');

grid on;hold on;
plot(wlsCDF(:,2),wlsCDF(:,1),'Marker','.','MarkerSize',20);
title('CDF');xlabel('Error (in m)');ylabel('CDF');
legend('GM-SDP-2','WLS');
