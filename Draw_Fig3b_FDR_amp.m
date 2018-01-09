prefix = mfilepath(mfilename('fullpath'));
prefix_cache = [prefix,'.',filesep,'data',filesep];

%% Real data problem parameters
formatSpec = '%f';
Y = fscanf(fopen(strcat(prefix_cache,'fdr_SLOPE_Knockoff_amp.txt'),'r'),formatSpec);
Y2 = fscanf(fopen(strcat(prefix_cache,'fdr_LCD_Knockoff_amp.txt'),'r'),formatSpec);
Y3 = fscanf(fopen(strcat(prefix_cache,'fdr_LSM_Knockoff_amp.txt'),'r'),formatSpec);
Y4 = fscanf(fopen(strcat(prefix_cache,'fdr_BVS_Knockoff_amp.txt'),'r'),formatSpec);
X = [5 10 20];

%% Generate Figure
fig = figure();
%% zooming
set(fig,'units','points','position',[0,0,600,400],'PaperPositionMode','auto')
set(gca,'Color',[0.7 .7 .7]);
set(gca,'FontName','Times New Roman','Fontsize',18,'FontWeight','bold');

%%
hold on
set(fig, 'DefaultTextInterpreter', 'latex');
plot(X,Y, 'r','LineWidth', 3,'MarkerSize', 10);
hold on
plot(X,Y2, 'b','LineWidth', 3,'MarkerSize', 10);
hold on
plot(X,Y3, 'k','LineWidth', 3,'MarkerSize', 10);
%hold on
%plot(X,Y4, 'g','LineWidth', 3,'MarkerSize', 10);
hold off
xlabel('Amplitude','FontName','Times New Roman','FontWeight','bold','FontSize',18);
ylabel('FDR','FontName','Times New Roman','FontWeight','bold','FontSize',18);
ylimits = [0 max([ceil(max(Y)) ceil(max(Y2)) ceil(max(Y3)) ceil(max(Y4))])];
xlimits = [0 ceil(max(X))];
grid on
%set(gca,'gridLineStyle','-','linewidth',1);
box on
%xlim(xlimits);
ylim([0 0.4]);
%set(gca,'XTick',(5:10:15));
set(gca,'YTick',(0.10:0.10:0.4));
%h=legend('mSLOPE','LCD Knockoffs', 'LSM Knockoffs','BVS Knockofs','Location','northwest');
h=legend('mSLOPE','LCD Knockoffs', 'LSM Knockoffs','Location','northwest');
set(gca,'FontName','Times New Roman','Fontsize',12);
%print('E:/Deep Learning/Research/Code/Matlab/mf_knockoffs/Figure/Final/Fig3a_FDR_amp.eps','-depsc2','-r1200');