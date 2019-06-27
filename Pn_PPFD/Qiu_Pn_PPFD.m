function [Pn] =Qiu_Pn_PPFD(beta,PPFD)

alpha=beta(1);
Pn_max=beta(2);
Rd=beta(3);
kappa=beta(4);

YY=(alpha.*PPFD+Pn_max).^2-4*kappa*alpha.*PPFD*Pn_max;
Pn=(alpha.*PPFD+Pn_max-sqrt(YY))/(2*kappa)-Rd;
end