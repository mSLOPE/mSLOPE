prefix = mfilepath(mfilename('fullpath'));
prefix_cache = [prefix,'.',filesep,'data',filesep];

%% Real data problem parameters
formatSpec = '%f';
Y = fscanf(fopen(strcat(prefix_cache,'power_Rib_SLOPE_MFKnockoff_amp.txt'),'r'),formatSpec);
Y2 = fscanf(fopen(strcat(prefix_cache,'power_Rib_LCD_Knockoff_amp.txt'),'r'),formatSpec);
Y3 = fscanf(fopen(strcat(prefix_cache,'power_Rib_LSM_Knockoff_amp.txt'),'r'),formatSpec);
Y4 = fscanf(fopen(strcat(prefix_cache,'power_Rib_BHq_amp.txt'),'r'),formatSpec);
X = [9 12 15 18 21];

%% Generate Figure
fig = figure();
%% zooming
set(fig,'units','points','position',[0,0,600,400],'PaperPositionMode','auto')
set(gca,'Color',[0.7 .7 .7]);
set(gca,'FontName','Times New Roman','Fontsize',18,'FontWeight','bold');

%%
hold on
set(fig, 'DefaultTextInterpreter', 'latex');
bar(X, [Y Y2 Y3 Y4], 0.5, 'stack');
hold off
xlabel('Amplitude','FontName','Times New Roman','FontWeight','bold','FontSize',18);
ylabel('Power','FontName','Times New Roman','FontWeight','bold','FontSize',18);
grid on
%set(gca,'gridLineStyle','-','linewidth',1);
box on
ylimits = [0 max([ceil(max(Y)) ceil(max(Y2)) ceil(max(Y3)) ceil(max(Y3))])];
xlimits = [0 ceil(max(X))];
%xlim(xlimits);
ylim([0 21]); %increase y Limit to 21 for displaying legend
set(gca,'XTick',(9:3:21));
%set(gca,'YTick',(0:0.25:1.0));
legend('mSLOPE','LCD', 'LSM','BHq','Orientation','horizontal');
%title('Example: Real Data Riboflavin','FontName','Times New Roman','FontWeight','bold','FontSize',18);
set(gca,'FontName','Times New Roman','Fontsize',18);
print('E:/Deep Learning/Research/Code/Matlab/mf_knockoffs/Figure/Final/Fig4a_Power_amp.eps','-depsc2','-r1200');