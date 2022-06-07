hold on
plot(FE_t_10(:,2),FE_t_10(:,1),'-','Linewidth',2,'displayname','FE-t/10') 
plot(FE_t_0(:,2),FE_t_0(:,1),'g--','Linewidth',2,'displayname','FE-0')
plot(FE_t_50(:,2),FE_t_50(:,1),'b','Linewidth',2,'displayname','FE-t/50')
plot(FE_t_100(:,2),FE_t_100(:,1),'y','Linewidth',2,'displayname','FE-t/100')
plot(Experimental(:,2),Experimental(:,1),'-.','Linewidth',2,'displayname','Experimental')
xlabel('Axial Strain','FontSize',12,'FontWeight','bold','Color','r')
ylabel('Axial Load (kN)','FontSize',12,'FontWeight','bold','Color','r')
legend('show','Location','Southeast')
legend boxoff
grid on
hold off
