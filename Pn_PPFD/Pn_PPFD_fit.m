function [alpha,Pn_max,Rd,kappa] = Pn_PPFD_fit (Pn,PPFD)

opts=statset('MaxIter',800,'TolX',1e-6);
opts.Robust='Bisquare';
[M, N]=size (PPFD);

for i=1:N
  
    x(:,i)=PPFD(:,i);
    y(:,i)=Pn(:,i);
    beta0=[0.1 20 1 0.9];  % initial parameters
   %[beta,R,J,CovB,MSE]=nlinfit(x(:,i),y(:,i),@Qiu_Pn_PPFD,beta0,opts);
[beta,resnorm]= lsqcurvefit(@Qiu_Pn_PPFD,beta0,x(:,i),y(:,i),[0 0 0 0], [+inf +inf +inf 1],opts);
    alpha(i)=beta(1);
    Pn_max(i)=beta(2);
    Rd(i)=beta(3);
    kappa(i)=beta(4);
   end
%----convert row to column-----
alpha=alpha';
Pn_max=Pn_max';
Rd=Rd';
kappa=kappa';


