%%Path loss model
%Logarithmic fitting parameters
P0=-55;
beta=2;
d0=1;
%GMM parameters
mu=[-4.36;1.73];
sigmasq = cat(3,[5.22],[4.09]);
tau=[0.37;0.63];

d=[0.5:0.1:10]';
P=P0-10*beta*log10(d/d0);
rng('default'); % For reproducibility
gm = gmdistribution(mu,sigmasq,tau);
n = random(gm,length(d));
RSS=P+n;

%plotting
figure;subplot(1,2,1);
scatter(d,P,'filled','red');hold on;
scatter(d,RSS,'filled','black');hold off;
axis([0 10 -80 -45]);grid on;
title('Fig.1(a) Simulated Path Loss Model');
xlabel('distance(m)');ylabel('RSS (dBm)');
legend('logarithmic fitting','RSS measurement');

subplot(1,2,2);
hist(random(gm,3000),175);hold on;
xlim([-50 25]);
title('Fig.1(b) Histogram of Simulated RSS noise modelled as Gaussian Mixture');
xlabel('Noise(dBm)');ylabel('Frequency counts');grid on;
legend('Simulated RSS noise');