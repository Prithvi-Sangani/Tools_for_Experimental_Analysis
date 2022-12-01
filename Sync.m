% Synchronising of data to any standard 't' data
clear all
clc
D1 = []; %data from D1 machine/DAQ
D2 = []; %data from D2 machine/DAQ
%1st columns in data matrix should contain synchronising term, if it is time syncrinisation
%then 1st column should have time 
%to synchronise the data with the time intervals from data D2
D1_s = [interp1(D1(:,1),D1(:,2),D2(:,1)) interp1(D1(:,1),D1(:,3),D2(:,1))]; %Data 1 synchronised to time as in data2
D_s = [D2 D1_s]; %gives a complete merged and synchronised data in terms of time intervals of data 2
t = 0:200;% let 't' be a vector ranges from 0 to 200 seconds with 1s time interval
t = t'; %for conversion into vector form 
D1_st = [interp1(D1(:,1),D1(:,2),t) interp1(D1(:,1),D1(:,3),t)]; %Data 1 synchronised to time as in t
D2_st = [interp1(D2(:,1),D2(:,2),t) interp1(D2(:,1),D2(:,3),t)]; %Data 2 synchronised to time as in t
D_st = [t D1_st D2_st];%gives a complete merged and synchronised data in terms of time intervals of data 2
hold on 
plot(D1(:,1),D1(:,3),'DisplayName','raw-data','LineWidth',1,'Color',[0 0 0]);
plot(D2(:,1),D1_s(:,2),'--','DisplayName','Synchronised to D2','LineWidth',3,'Color',[1 0 0]);
plot(t,D1_st(:,2),':','DisplayName','Synchronised to t','LineWidth',3,'Color',[0 0 1]);
box on
xlabel('Time [s]')
ylabel('Strain [\mu\epsilon]')
legend ('Location','northwest')
grid on
hold off