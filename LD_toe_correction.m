LD_rawdata = []; % import or copy Load-Deformation [L(kN) D(mm)] data in this matrix
[Load_max,L_i] = max(LD_rawdata(:,1)); % [maximum Load value, max load value index]
n = 50; % input datapoints required at every n intervals
LD_1 = LD_rawdata(1:n:L_i,:); % LD plot from Zero to L_max
[L_max,L_1] = max(LD_1(:,1));
LD_2 = LD_rawdata(L_i:n:end,:); % LD plot in softening zone
LD_coarser = [LD_1
              LD_2]; 
[m p] = size(LD_coarser);
stiffness = zeros(m-1,1); %stiffness 
for i = 1:m-1 % stiffness = Delta_load/Delta_deformation
    stiffness(i,1) = (LD_coarser(i+1,1)-LD_coarser(i,1))/(LD_coarser(i+1,2)-LD_coarser(i,2));
end
stiffness(isinf(stiffness)|isnan(stiffness)) = 0;
[stiffness_max,S_i] = max(stiffness(1:L_1,:)); %maximum stiffness value and index upto max_load only
D_corrected = zeros(m,1); %Deformation corrected
for k = 1:m
if k < S_i
    D_corrected(k) = (LD_coarser(k,1)/stiffness_max);
else
    D_corrected(k) = LD_coarser(k,2)-(LD_coarser(S_i-1,2)-D_corrected(S_i-1));
end
end
LD_corrected = [LD_coarser(:,1) D_corrected]; %Load-Deformation corrected
hold on
plot(LD_corrected(:,2),LD_corrected(:,1),'-','Linewidth',2,'displayname','corrected') 
plot(LD_coarser(:,2),LD_coarser(:,1),'g--','Linewidth',2,'displayname','rawdata')
xlabel('Deformation(mm)','FontSize',10,'FontWeight','bold')
ylabel('Axial Load (kN)','FontSize',10,'FontWeight','bold')
legend('show','Location','Southeast')
legend boxoff
grid on
hold off



