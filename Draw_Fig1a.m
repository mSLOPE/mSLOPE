% This demo illustrates how to use the model-free knockoff filter package 
% for fixed-design knockoffs on a synthetic data set (i.e. therefore 
% assuming a linear regression model for the response).

%% Synthetic problem parameters

n = 1000;         % Number of data points
p = 2000;         % Number of variables
k = 60;           % Number of variables with nonzero coefficients
amplitude = 4.5;  % Magnitude of nonzero coefficients
sigma = 1;        % Noise level
q = 0.20;         % Target false discovery rate (FDR)

rng(123);         % Random seed

%% Synthetic problem construction
% We generate the data by sampling the rows of X from a multivariate normal
% distribution with mean zero and identity covariance matrix.
% Conditional on X, the response y is drawn from a linear regression model
% with k non-zero coefficients

Sigma = eye(p);
mu = zeros(1,p);
X = mvnrnd(mu, Sigma, n);

S0 = randsample(p,k);
beta = zeros(p,1);
beta(S0) = amplitude/sqrt(n);
sampleY = @(X) X*beta + sigma .* randn(n,1);

trueDiscoveries = @(S) sum(beta(S) > 0);
power = @(S) trueDiscoveries(S)*100/k;
FDP = @(S) sum(beta(S) == 0) / max(1, length(S));
printSummary = @(S) fprintf(...
    ['%d true discoveries (Power = %2.2f%%)\n' ...
     'FDP = %2.2f%% (target FDR = %2.f%%)\n'], ...
    trueDiscoveries(S), power(S), 100*FDP(S), 100*q);

%%
%% Calculate value of Y
y = sampleY(X);

%% Running the knockoff filter steps manually

% The main function 'knockoffs.filter' is a wrapper around simpler functions
% that create knockoffs, compute test statistics, and perform variable
% selection. When more control is necessary, these functions may be
% called directly. We demonstrate this below in reproducing the plot of
% Figure 1.

Xmodel = {'gaussian', mu, Sigma};
X_ko = knockoffs.create(X, Xmodel{:});
[W,Z] = knockoffs.stats.adaptiveLassoLambdaSignedMax(X, X_ko, y);
t = knockoffs.threshold(W, q);
t =1.5;
fig = figure();
%% zooming
set(fig,'units','points','position',[0,0,600,400],'PaperPositionMode','auto')
set(gca,'Color',[0.7 .7 .7]);
set(gca,'FontName','Times New Roman','Fontsize',18,'FontWeight','bold');
%%
hold on
set(fig, 'DefaultTextInterpreter', 'latex');
patch([0 t t 0], [0 0 t t], 'w');
hold on
plot([t t 0], [0 t t], 'k','LineWidth', 3,'MarkerSize', 10);
hold on
g=gscatter(Z(1:p), Z(p+1:2*p), ismember(1:p, S0), 'kr',[],15);
hold off
xlabel('Value of $\lambda$ when $X_j$ enters model');
ylabel('Value of $\lambda$ when $\tilde X_j$ enters model');
%limits = [0 ceil(max(Z))];
limits = [0 max(ceil(max(Z)),9)];
xlim(limits); ylim(limits);
%title('MF Knockoff Filter with mSLOPE');
text(0.5,6.5,'Numerator$$(W_{j} \leq -t)$$','Interpreter','latex','FontName','Times New Roman','FontWeight','bold','FontSize',18)
text(4.5,2.3,'Denominator$$(W_{j} \geq t)$$','Interpreter','latex','FontName','Times New Roman','FontWeight','bold','FontSize',18)
text(0.5,7.0,'Rectangle box is threshold t=1.5','FontName','Times New Roman','FontWeight','bold','FontSize',18)
h=legend(g,'Null feature', 'Non-null feature');
set(h,'Location','northwest','FontName','Times New Roman','FontWeight','bold','FontSize',18);
line = refline(1,0);
set(line, 'LineStyle', '-', 'Color', 'blue','LineWidth', 3,'MarkerSize', 10);
%print('E:/Deep Learning/Research/Code/Matlab/mf_knockoffs/Figure/Final/F1_a.eps','-depsc2','-r1200');