% This code will plot stress-strain plot with yield_stress & Tensile stress from raw data of stress and strain
SS_rawdata = []; %import stress(MPa)-strain(mm/mm) [Ss_r Sn_r]
[Stress_max,S_i] = max(SS_rawdata(:,1)); % [maximum Stress value, max stress value index]
n = 10; % input datapoints required at every n intervals, can be modified as per the convenience
Ss_1 = 100; %lower bound of stress value for E calculation,can be modified 
Ss_2 = 200; %upper bound of stress value for E, can be modified
SS_1 = SS_rawdata(1:n:S_i,:); % S-S plot from Zero to S_max
[S_max,S_1] = max(SS_1(:,1));
SS_2 = SS_rawdata(S_i:n:end,:); 
SS_coarser = [SS_1
              SS_2]; 
[m p] = size(SS_coarser);
E_cal = zeros(m,2);% Stress-strain to calculate Young's Modulus
for i = 1:m
          if  Ss_1 < SS_coarser(i,1) && SS_coarser(i,1) < Ss_2
           E_cal(i,1:2) = SS_coarser(i,1:2);
        else
            E_cal(i,1:2) = 0;
        end
end
E_cal_R = [nonzeros(E_cal(:,1)) nonzeros(E_cal(:,2))]; % for linear fitting 
[e1 e2] = size(E_cal_R);
for itr = 1:m             
    if Ss_1 < SS_coarser(itr,1) && SS_coarser(itr,1) < Ss_2 
        index = itr + e1 ;
      break;
    end
end
E_w_intercept = polyfit(E_cal_R(:,2),E_cal_R(:,1),1);% with intercept
slope_1 = E_w_intercept(1);
slope_2 = E_cal_R(:,2)\E_cal_R(:,1);% slope without intercept
delta_1 = abs(200000-slope_1); delta_2 = abs(200000-slope_2); % to choose E nearest to 200GPa
if delta_1 < delta_2
    E_modulus = slope_1;
else
    E_modulus = slope_2;
end
SS_offset = zeros(m,2);%initiating offset stress-strain
for s = 1:m
    if s < index
        SS_offset(s,1:2) = [SS_coarser(s,1) SS_coarser(s,2)+0.002];
    else
        SS_offset(s,1:2) = [E_modulus*(SS_coarser(s,2)) SS_coarser(s,2)+0.002];
    end
end
hold on
plot(SS_coarser(:,2),SS_coarser(:,1),'Linewidth',2)
plot(SS_offset(:,2),SS_offset(:,1),'--','Linewidth',1)
str = {'E =',E_modulus};
text(0.005,Ss_2,str)
xlabel('Strain','FontWeight','bold')
ylabel('Stress (MPa)','FontWeigh','bold')
title('Stress-Strain plot','Fontsize',12,'FontWeight','bold')
grid on
ylim([0 S_max+50])
hold off
Youngs_Modulus = E_modulus
Tensile_Strength = Stress_max
