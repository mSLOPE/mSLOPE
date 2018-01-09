q = 0.2;
p = 5000;
i = 1:1:500;
l1 = norminv(1-q*i/p/2);
l2 = l1*sqrt(1+cumsum(l1.^2)/(p-i-1));
l3 = l1*sqrt(1+cumsum(l1.^2)/(2*p-i-1));
fig = figure();
%% zooming
set(fig,'units','points','position',[0,0,600,400],'PaperPositionMode','auto')
set(gca,'Color',[0.7 .7 .7]);
set(gca,'FontName','Times New Roman','Fontsize',18,'FontWeight','bold');
%%
hold on
set(fig, 'DefaultTextInterpreter', 'latex');
plot(i,l1,'r','LineStyle','-','LineWidth',3,'MarkerSize',10);
hold on
plot(i,l2,'g','LineStyle','--','LineWidth',3,'MarkerSize',10);
hold on
plot(i,l3,'k','LineStyle',':','LineWidth',3,'MarkerSize',10);
hold off
grid on
%set(gca,'gridLineStyle','-','linewidth',1);
box on
ylim([2,6]);
set(gca,'xTick',0:100:500);
set(gca,'yTick',2:0.5:6);
%title(sprintf('q=%f',q),'FontSize',18);
xlabel('$$\it{i}$$','FontName','Times New Roman','FontWeight','bold','FontSize',18)
ylabel('$$\lambda$$','FontName','Times New Roman','FontWeight','bold','FontSize',18)
legend1=legend('$$\lambda_{BH}$$','Ordered $$\lambda$$, n=p','Ordered $$\lambda$$, n=2p');
set(legend1,'FontName','Times New Roman','FontWeight','bold','FontSize',18,'Interpreter','latex');