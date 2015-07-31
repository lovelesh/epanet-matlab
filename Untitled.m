% clear
% clc
% inpname='DVR Command_2024 (200)_Steady_State'; 
% d=epanet([inpname,'.inp']);
% index = d.LinkIndex;
% valves = d.LinkValveIndex;
% d.setTimeSimulationDuration(1)
% d.setTimeHydraulicStep(3600)
% for t=1:24
%     for i = 1:size(valves,2)
%         d.LinkInitialSetting(1,valves(1,i)) = settings(t,i);
%     end
%     d.saveInputFile([pwd,'\RESULTS\','Mysore.inp']);
%     d.solveCompleteHydraulics
%     d.saveHydraulicsOutputReportingFile
% 
% d.setReportFormatReset
% d.setReport('FILE TestReport.txt');
% d.setReport('PAGESIZE 0')
% d.setReport('NODES ALL')%/ALL/node1 node2 
% % d.setReport('LINKS ALL')%/ALL/link1 link2
% % d.setReport('PRESSURE PRECISION 1')
% % d.setReport('PRESSURE ABOVE 20')
% % d.setReport('STATUS YES')%YES/NO/FULL 
% % d.setReport('SUMMARY YES')%YES/NO 
% % d.setReport('MESSAGES YES')%YES/NO 
% % d.setReport('ENERGY YES')%YES/NO 
% % %Nodes parameters
% % %YES/NO/BELOW/ABOVE/PRECISION
% % d.setReport('ELEVATION YES')
% % d.setReport('DEMAND YES')
% % d.setReport('HEAD YES') 
% % d.setReport('PRESSURE YES') 
% % d.setReport('QUALITY YES') % bug.
% % %Links parameters
% % %BELOW/ABOVE/PRECISION
% % d.setReport('LENGTH YES')
% % d.setReport('DIAMETER YES')
% % d.setReport('FLOW YES')
% % d.setReport('LENGTH YES')
% % d.setReport('VELOCITY YES')
% % d.setReport('HEADLOSS YES')
% % d.setReport('QUALITY PRECISION 1')
% % d.setReport('STATUS YES')
% % d.setReport('SETTING YES')
% % d.setReport('REACTION YES')
% % d.setReport('F-FACTOR YES')
% 
% %Write the report to file 
% d.writeReport
% movefile('TestReport.txt',[pwd,'\RESULTS\','TestReport.txt']);
% open('TestReport.txt');
% 



clear
clc
% Input Files
delete ('temp.inp','temp1.$$$','temp2.$$$','temp.txt');
inpname='Mysore_Demand_Zero_2';
d=epanet([inpname,'.inp']);
d.setTimeSimulationDuration(86400)
d.setTimeHydraulicStep(3600)
index = d.LinkIndex;
valves = d.LinkValveIndex;
settings = xlsread('Settings.xls');


% Simulate all times
d.solveCompleteHydraulics
d.solveCompleteQuality

% Runs hydraulics Step-by-step
d.openHydraulicAnalysis;
d.initializeHydraulicAnalysis;
tstep=1; P=[];T=[]; D=[]; H=[];F=[];count=0;
% for i = 1:size(valves,2)
%         d.LinkInitialSetting(1,valves(1,i)) = settings(count,i);
% end

while (tstep>0 && count ~=24)
    t=d.runHydraulicAnalysis;
    P=[P; d.getNodePressure];
    D=[D; d.getNodeActualDemand];
    H=[H; d.getNodeHydaulicHead];
    F=[F; d.getLinkFlows];
    T=[T; t];
    tstep=d.nextHydraulicAnalysisStep;
    count = count+1;
    for i = 1:size(valves,2)
        d.LinkInitialSetting(1,valves(1,i)) = settings(count,i);
    end
    %d.saveInputFile([count,'.inp']);
end
d.closeHydraulicAnalysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




