clear
clc

% Deleting pervious files
delete ('temp.inp','temp1.$$$','temp2.$$$','temp.txt','temp.out','hyd.out');

% Input Files
inpname='Devanoor_10DMA';

% Output file
outfile = 'hyd.out';
d=epanet([inpname,'.inp']);

% Setting Simulation duration and settings
d.setTimeSimulationDuration(86400);
d.setTimeHydraulicStep(600);
d.setTimeReportingStep(3600);
index = d.LinkIndex;
valves_index = d.LinkValveIndex;
tanks = d.NodeTankIndex;

% Setting the setting-read file
settings = xlsread('Settings-all-report.xls');

% Simulate all times
d.solveCompleteHydraulics;
%d.solveCompleteQuality;

% Report generation
d.saveHydraulicsOutputReportingFile
d.setReportFormatReset
d.setReport('FILE TestReport.txt');
d.setReport('PAGESIZE 0')
d.setReport('NODES ALL')%/ALL/node1 node2 
d.setReport('LINKS ALL')%/ALL/link1 link2
%d.setReport('PRESSURE PRECISION 1')
%d.setReport('PRESSURE ABOVE 20')
d.setReport('STATUS YES')%YES/NO/FULL 
d.setReport('SUMMARY YES')%YES/NO 
d.setReport('MESSAGES YES')%YES/NO 
d.setReport('ENERGY YES')%YES/NO 
%Nodes parameters
%YES/NO/BELOW/ABOVE/PRECISION
d.setReport('ELEVATION YES')
d.setReport('DEMAND YES')
d.setReport('HEAD YES') 
d.setReport('PRESSURE YES') 
%d.setReport('QUALITY YES') % bug.
%Links parameters
%BELOW/ABOVE/PRECISION
% d.setReport('LENGTH YES')
% d.setReport('DIAMETER YES')
d.setReport('FLOW YES')
% d.setReport('LENGTH YES')
d.setReport('VELOCITY YES')
d.setReport('HEADLOSS YES')
% d.setReport('QUALITY PRECISION 1')
d.setReport('STATUS YES')
d.setReport('SETTING YES')
% d.setReport('REACTION YES')
% d.setReport('F-FACTOR YES')

%Write the report to file 
% d.writeReport
% movefile('TestReport.txt',[pwd,'/RESULTS/','TestReport-8:00.txt']);

% Runs hydraulics Step-by-step
d.openHydraulicAnalysis;
d.initializeHydraulicAnalysis;

% Variable initialisation
tstep=1; P=[];T=[]; D=[]; H=[];F=[];E=[]; TM=[];TH=[];VF=[];temp=[];hour_counter=1;

% Valve initialisation
[valves_setting] = d.getLinkInitialSetting;
valves_setting = repmat(valves_setting,[12,1]);

for counter = 1:size(settings,1)
    % Valve values from settings are copied onto the valve_setting
    valves_setting(counter,valves_index) =settings(counter,:); 
end

%setting the valves for the 0th hour
d.setLinkSettings(valves_setting(hour_counter,:));
% %checking the valve settings before calculation
[temp] = d.getLinkSettings;

% Simulation loop
while (tstep>0) %&& hour_counter<12 )    
    t=d.runHydraulicAnalysis;
    P=[P; d.getNodePressure]; %#ok<AGROW>
    D=[D; d.getNodeActualDemand]; %#ok<AGROW>
    H=[H; d.getNodeHydaulicHead];
    TM = [TM; d.getNodeTankMinimumWaterLevel];
    E=[E; d.getNodeElevations];
    TH = [TH; H(end,48:end) - E(end,48:end) - TM(end,48:end)];
    F=[F; d.getLinkFlows];
    VF = [VF; F(end,48:end)];
    T=[T; t];
    tstep=d.nextHydraulicAnalysisStep;
    if ((t > 0 && t < 86400) && ~rem(t,3600))
        hour_counter = hour_counter+1;
        % Setting valve values
            d.setLinkSettings(valves_setting(hour_counter,:));
        
        % checking the valve settings- for testing purpose
        temp = [temp; d.getLinkSettings];
    end
       
end

% Tank Percentages
Perc = [];
Perc(:,1) = fillperc(TH(:,1),14.5,1000000);
Perc(:,2) = fillperc(TH(:,2),14.5,1000000);
Perc(:,3) = fillperc(TH(:,3),17,1500000);
Perc(:,4) = fillperc(TH(:,4),10.3,500000);
Perc(:,5) = fillperc(TH(:,5),10.3,500000);
Perc(:,6) = fillperc(TH(:,6),14.5,1000000);
Perc(:,7) = fillperc(TH(:,7),10.3,500000);
Perc(:,8) = fillperc(TH(:,8),7.3,250000);
Perc(:,9) = fillperc(TH(:,9),14.5,1000000);
Perc(:,10) = fillperc(TH(:,10),17,1500000);
Perc(:,11) = fillperc(TH(:,11),14.5,1000000);

% Plot the tank levels
figure(1)
plot(T/3600,Perc(:,1:end),'DisplayName','Perc(:,1:11)','YDataSource','Perc(:,1:11)');

% Plot the Valve Flow
figure(2)
plot(T/3600,VF(:,1:end),'DisplayName','VF(:,1:12)','YDataSource','VF(:,1:12)');
% d.writeReport
% movefile('TestReport.txt',[pwd,'/RESULTS/','TestReport-devanoor.txt']);

d.closeHydraulicAnalysis;


% d.saveHydraulicFile(outfile);
% d.useHydraulicFile(outfile);
% d.saveInputFile([pwd,'/RESULTS/','hyd.inp']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
