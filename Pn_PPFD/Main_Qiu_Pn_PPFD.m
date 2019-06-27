%This program was developed to determine alpha, Pn_max,Rd and kappa
%from measured photosynthetic light¨Cresponse curve.
%------------------Equations used-------------
%YY=(alpha*PPFD+Pn_max)^2-4*kappa*alpha*PPFD*Pn_max;
%Pn=(alpha*PPFD+Pn_max-sqrt(YY))/(2*kappa)-Rd;
%------------------Reference----------------
%Li, T., et al. Enhancement of crop photosynthesis by diffuse light: 
%quantifying the contributing factors. Annu. Bot. 114, 145-156 (2014)
%------------------Author-----------------------
%Author: Rangjian Qiu
%Nanjing University of Information Science & Technology
%Last update 6,June,2018 
%-----------------Main inputs------------------
%PPFD-----Photosynthetic Photon Flux Density (micro mol/m2/s)
%Pn---------Photosynthesis (micro mol/m2/s)
%-----------------Main outputs----------------
%alpha--the maximum apparent quantum yield of CO2 (mol mol-1 photons);
%Pn_max--the irradiance-saturated rate of gross photosynthesis (micro mol m-2 s-1);
%Rd--dark respiration rate (micro mol m-2 s-1)
%kappa--a dimensionless convexity term [0,1]
%%%%%%%%%%%%%%%%%%%%%%%%%%
%------------------Cite-------------------------
%If the program is useful, please cite
%Qiu et al, An investigation on possible effect of leaching fractions physiological responses 
%of hot pepper plants to irrigation water salinity, BMC Plant biology, xxxx
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc
%-------------------Load data----------------
%prepared your data in excel as follows
%the data points for each curve should be the same
%1          2            3
%PPFD   Pn           Treatment lable(should be numbers)
A = xlsread('0001.xlsx'); % read excel data
PPFD=A(:,1);            %Photosynthetic Photon Flux Density (micro mol/m2/s)
Pn=A(:,2);                 % Photosynthesis (micro mol/m2/s)
label=A(:,3);              %Treatments lable should be numbers
s=[ ];                         % storage paremeter
                       
%%%%%%%%%%%----Notice!!!----%%%%%%%%%%%%%%%%%%%%%
%%-----separate each Pn-PPFD curve with every j rows-------
j=10;   % factors that separate each Pn-PPFD curve with every j rows
% users should modify j based on your data.

Pn_i=reshape(Pn,j,[ ]); % separate each Pn-PPFD curves with every j rows
PPFD_i=reshape(PPFD,j,[ ]);% separate each Pn-PPFD curves with every j rows
label_i = label(1:j:length(label));%treatment label with every j rows
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------main function to calculate--------
[alpha,Pn_max,Rd,kappa] = Pn_PPFD_fit (Pn_i,PPFD_i);
%------ Store optimized results in matrix s as follows
%(treatment lable, alpha, Pn_max, Rd, kappa)
s=[label_i alpha Pn_max Rd kappa];
header={'label', 'alpha', 'Pn_max', 'Rd', 'kappa'};
s2=num2cell(s);
%Send all the results stored in s to file name 'Optimized_Parameters_Pn_PPFD.xlsx' as excle file
xlswrite('Optimized_Parameters_Pn_PPFD.xlsx',[header;s2],'sheet1','A1')

%-------Figure all data points and curves--------
figure (1)
clf
%-------Figure data points------
plot (PPFD_i, Pn_i,'bo','MarkerFaceColor','b','linewidth',1.5)
hold on
%-------Figure curves------------------
[M,N]=size(PPFD_i);
for i=1:N;
PPFD_p=0:1:2200;
beta_p=[alpha, Pn_max,Rd, kappa];
[Pn_p(i,:)] =Qiu_Pn_PPFD(beta_p(i,:),PPFD_p);
plot (PPFD_p, Pn_p(i,:),'-','Color',[0.07 0.6 0.26],'linewidth',3)
end
xlabel ('PPFD (\mu mol m^{-2} s^{-1})','fontweight','bold','fontsize',12)
ylabel ('{\it{P_n}} (\mu mol m^{-2} s^{-1})','fontweight','bold','fontsize',12')

