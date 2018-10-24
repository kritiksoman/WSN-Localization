%Performs monte carlo integration required for finding CRLB
function [In] = monteCarloInt(tau,mu,sigmasq,X,plotting)

n = sort(X);
p1 = tau(1)*(1/(sqrt(2*pi*sigmasq(:,:,1))))*exp(-(n-mu(1)).^2/(2*sigmasq(:,:,1)));
p2 = tau(2)*(1/(sqrt(2*pi*sigmasq(:,:,2))))*exp(-(n-mu(2)).^2/(2*sigmasq(:,:,2)));
p=p1+p2;

gradp1 = -p1.*(n-mu(1))/sigmasq(:,:,1);
gradp2 = -p2.*(n-mu(2))/sigmasq(:,:,2);
gradp=gradp1+gradp2;

f=(gradp.*gradp)./p;
In=mean(f)*range(n);
%disp(['In = ' num2str(In)]);
% if plotting==1
%     plot(n,p,n,gradp,n,f);
%     legend('p','gradp','f');
%     legend({'p(n)','$\nabla_n p(n)$','${[\nabla_n p(n)]}^2/p(n)$'},'Interpreter','latex');
%     grid on;
%     title('Evaluation of monte carlo integral')
%     xlabel('n');
%     ylabel('Probability Density');
% end
end