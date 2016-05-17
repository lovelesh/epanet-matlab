function createfigure(X1, YMatrix1, YMatrix2)
%CREATEFIGURE(X1, YMATRIX1, YMATRIX2)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data
%  YMATRIX2:  matrix of y data

%  Auto-generated by MATLAB on 17-May-2016 00:30:28

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,...
    'XTickLabel',{'0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24'},...
    'XTick',[0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24],...
    'Position',[0.056470588235294 0.583837209302325 0.775000000000001 0.341162790697674]);
%% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0 24]);
grid(axes1,'on');
hold(axes1,'on');

% Create ylabel
ylabel('Water Level (%)');

% Create xlabel
xlabel('Time (hours)');

% Create multiple lines using matrix input to plot
plot1 = plot(X1,YMatrix1,'Parent',axes1);
set(plot1(1),'DisplayName','Devanoor MDT');
set(plot1(2),'DisplayName','Rajendra Nagar II');
set(plot1(3),'DisplayName','Rajendra Nagar I');
set(plot1(4),'DisplayName','Bademakan');
set(plot1(5),'DisplayName','Kesare');
set(plot1(6),'DisplayName','Rajiv Nagar II');
set(plot1(7),'DisplayName','Veeranagere');
set(plot1(8),'DisplayName','NR Mohalla II');
set(plot1(9),'DisplayName','NR Mohalla I');
set(plot1(10),'DisplayName','Rajiv Nagar I');
set(plot1(11),'DisplayName','Tippu Park');

% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.842690286629991 0.556003685916759 0.134809184965393 0.386754358861749],...
    'FontSize',7);

% Create axes
axes2 = axes('Parent',figure1,...
    'XTick',[0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24],...
    'Position',[0.0554901960784313 0.11 0.775000000000001 0.341162790697674]);
%% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes2,[0 24]);
%% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes2,[0 200]);
grid(axes2,'on');
hold(axes2,'on');

% Create ylabel
ylabel('Flow (lps)');

% Create xlabel
xlabel('Time (hours)');

% Create multiple lines using matrix input to plot
plot2 = plot(X1,YMatrix2,'Parent',axes2);
set(plot2(1),'LineStyle','none');
set(plot2(2),'DisplayName','Veeranagere');
set(plot2(3),'DisplayName','NR Mohalla II');
set(plot2(4),'DisplayName','NR Mohalla I');
set(plot2(5),'DisplayName','Rajiv Nagar I');
set(plot2(6),'DisplayName','Rajendra Nagar II');
set(plot2(7),'DisplayName','Rajendra Nagar I');
set(plot2(8),'DisplayName','Bademakan');
set(plot2(9),'DisplayName','Kesare');
set(plot2(10),'DisplayName','Tippu Park');
set(plot2(11),'DisplayName','Rajiv Nagar II');
set(plot2(12),'DisplayName','FCV 3');

% Create legend
legend2 = legend(axes2,'show');
set(legend2,...
    'Position',[0.844444783564549 0.0618718183004829 0.132004440104128 0.421410856471553],...
    'FontSize',7);

