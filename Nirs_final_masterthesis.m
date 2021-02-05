clear all; close all; clc
%aan te passen in deze file: 
% fname: dit is de datafile waar je de gegevens uit moet halen 
% voorlopig: de begintijd en de eindtijd van de eerste minuut van ieder event 
% pnameICL: naam van de overzichtgrafieken van alle data ICL
% pnameMF: naam van de overzichtgrafieken van alle data ICL
% fsolution: de naam van de excel file waar je in wil schrijven 

% dit is geschreven voor het volgende protocol: 
% prone - 5min 
% sitting - 4min 
% standing - 4min
% bending FW 25° - 2min
% bending FW 45° - 2min
% prone - 5min 
%% add a path 
addpath(genpath('C:\Users\annav\OneDrive\KUL\DATA THESIS'));
%% importdata 
fname = 'PILOT_1_Hanne_left_right_data.xlsx';
x = importdata(fname);
set(0,'DefaultFigureWindowStyle','docked')
pnameICL = 'graphs_ICL_Hanne';
pnameMF = 'graphs_MF_Hanne';
pnameTOI = 'graph_Hanne_TOI';
pnameHHb = 'graph_Hanne_HHb';
pnameO2Hb = 'graph_Hanne_O2Hb';
%% exportdata 
fsolution='results_Hanne_bis.xls';
%% Select the beginning & end times of the events for ICL 
%Pas deze tijdstippen aan van de 1e MINUUT naargelang de events 
tb = 154.27; 
te = 213.51; 
tbsi = 754.21;
tesi =813.45;
tbst =1115.73;
test =1174.96;
tblb =1448.04;
telb =1507.27;
tbbb =1761.70;
tebb =1820.94;
tbp =1981.15;
tep =2040.39;

%Pas deze tijdstippen aan van de 1e seconde naargelang de events 
mtb = 147.60; 
mte = 207.40; 
mtbsi = 747.20;
mtesi =807.00;
mtbst =1108.60;
mtest =1168.40;
mtblb =1440.60;
mtelb =1500.40;
mtbbb =1754.00;
mtebb =1813.80;
mtbp =1973.60;
mtep =2033.40;

%% pkshave 
% wat de bedoeling is: normaliseren, shaven, terugzetten. 
% de Zscore = geschaalde versie van x.data.ICL(:,c)-- grootte idem
% [Z,MU,SIGMA] = zscore(X) also turns MEAN(X) in MU and STD(X) in SIGMA.
% %  Als die toch teveel afknipt, moet je de levels [-3,3] wat verhogen.)
 
y_out = zeros(length(x.data.ICL(:,1)),6);
for c = 2:7 
[z,mu,sigma] = zscore(x.data.ICL(:,c));
z_out = pkshave(z,[-3,3],false);
    %Een eerste lus die van al je datakolommen een pkshave doet.
y_out(:,c-1)= z_out*sigma+mu;
end 

ym_out = zeros(length(x.data.MF(:,1)),6);
for c = 2:7 
[z,mu,sigma] = zscore(x.data.MF(:,c));
zm_out = pkshave(z,[-3,3],false);
    %Een eerste lus die van al je datakolommen een pkshave doet.
ym_out(:,c-1)= zm_out*sigma+mu;
end

%% setting for ICL
headers = {'O2HbL','HHbL','TOIL','O2HbR','TOIR','HHbR'};
xlswrite(fsolution,headers,'ICL','A1:F1')
i = 0;
time = x.data.ICL(:,1);
%% calculations Prone 
%5min
H = zeros(5,6);
for c=1:6
for i=0:4
    tbegin = tb+(i*60);
    tend = te+(i*60);
    value = y_out(:,c);
    res =  calculateMean(tbegin,min(tend,time(end)),time,value);
    H(i+1,c) = res;
end 
end
disp(H)
xlswrite(fsolution,H,'ICL','A2')
%% calculations sitting
% %4min
H = zeros(4,6);
for c=1:6
for i=0:3
    tbegin = tbsi+(i*60);
    tend = tesi+(i*60);
    value = y_out(:,c);
    res =  calculateMean(tbegin,min(tend,time(end)),time,value);
    H(i+1,c) = res;
end 
end
disp(H)
xlswrite(fsolution,H,'ICL','A7')

%% calculations  standing 
%4min
H = zeros(4,6);
for c=1:6
for i=0:3
    tbegin = tbst+(i*60);
    tend = test+(i*60);
    value = y_out(:,c);
    res =  calculateMean(tbegin,min(tend,time(end)),time,value);
    H(i+1,c) = res;
end 
end
disp(H)
xlswrite(fsolution,H,'ICL','A11')

%% calculations  BFS
%2min
H = zeros(2,6);
for c=1:6
for i=0:1
    tbegin = tblb+(i*60);
    tend = telb+(i*60);
    value = y_out(:,c);
    res =  calculateMean(tbegin,min(tend,time(end)),time,value);
    H(i+1,c) = res;
end 
end
disp(H)
xlswrite(fsolution,H,'ICL','A15')

%% calculations  BFL
%2min
H = zeros(2,6);
for c=1:6
for i=0:1
    tbegin = tbbb+(i*60);
    tend = tebb+(i*60);
    value = y_out(:,c);
    res =  calculateMean(tbegin,min(tend,time(end)),time,value);
    H(i+1,c) = res;
end 
end
disp(H)
xlswrite(fsolution,H,'ICL','A17')

%% calculations  pronepost
%5min
H = zeros(5,6);
for c=1:6
for i=0:4
    tbegin = tbp+(i*60);
    tend = tep+(i*60);
    value = y_out(:,c);
    res =  calculateMean(tbegin,min(tend,time(end)),time,value);
    H(i+1,c) = res;
end 
end
disp(H)
xlswrite(fsolution,H,'ICL','A19')

%% where to write for MF
headers = {'O2HbL','HHbL','TOIL','O2HbR','TOIR','HHbR'};
xlswrite(fsolution,headers,'MF','A1:F1')
i = 0;
time = x.data.MF(:,1);
%% calculations Prone 
H = zeros(5,6);
for c=1:6
for i=0:4
    tbegin = mtb+(i*60);
    tend = mte+(i*60);
    value = ym_out(:,c);
    res =  calculateMean(tbegin,min(tend,time(end)),time,value);
    H(i+1,c) = res;
end 
end
disp(H)
xlswrite(fsolution,H,'MF','A2')
%% calculations sitting
% %4min
H = zeros(4,6);
for c=1:6
for i=0:3
    tbegin = mtbsi+(i*60);
    tend = mtesi+(i*60);
    value = ym_out(:,c);
    res =  calculateMean(tbegin,min(tend,time(end)),time,value);
    H(i+1,c) = res;
end 
end
disp(H)
xlswrite(fsolution,H,'MF','A7')

%% calculations  standing 
%4min
H = zeros(4,6);
for c=1:6
for i=0:3
    tbegin = mtbst+(i*60);
    tend = mtest+(i*60);
    value = ym_out(:,c);
    res =  calculateMean(tbegin,min(tend,time(end)),time,value);
    H(i+1,c) = res;
end 
end
disp(H)
xlswrite(fsolution,H,'MF','A11')

%% calculations  BFS
%2min
H = zeros(2,6);
for c=1:6
for i=0:1
    tbegin = mtblb+(i*60);
    tend = mtelb+(i*60);
    value = ym_out(:,c);
    res =  calculateMean(tbegin,min(tend,time(end)),time,value);
    H(i+1,c) = res;
end 
end
disp(H)
xlswrite(fsolution,H,'MF','A15')

%% calculations  BFL
%2min
H = zeros(2,6);
for c=1:6
for i=0:1
    tbegin = mtbbb+(i*60);
    tend = mtebb+(i*60);
    value = ym_out(:,c);
    res =  calculateMean(tbegin,min(tend,time(end)),time,value);
    H(i+1,c) = res;
end 
end
disp(H)
xlswrite(fsolution,H,'MF','A17')

%% calculations pronepost
%5min
H = zeros(5,6);
for c=1:6
for i=0:4
    tbegin = mtbp+(i*60);
    tend = mtep+(i*60);
    value = ym_out(:,c);
    res =  calculateMean(tbegin,min(tend,time(end)),time,value);
    H(i+1,c) = res;
end 
end
disp(H)
xlswrite(fsolution,H,'MF','A19')

%% plot ICL
figure('Name','NIRS - ICL');
a = -50;
b = 150;
graphmin1= min(min(y_out(:,1),y_out(:,4)));
graphmax1= max(max(y_out(:,1),y_out(:,4)));
graphmin2= min(min(y_out(:,2),y_out(:,5)));
graphmax2= max(max(y_out(:,2),y_out(:,5)));
graphmin3= min(min(y_out(:,3),y_out(:,6)));
graphmax3= max(max(y_out(:,3),y_out(:,6)));
for c = 2:7
t = (x.data.ICL(:,1)-tb)/60;
subplot(2,3,(c-1));hold on 
plot(t,y_out(:,c-1)); hold on

f = [1 2 3 4];
y1 = [tb/60 a; (te/60)+4 a; (te/60)+4 b; tb/60 b];
y2 = [tbsi/60 a; (tesi/60)+3 a; (tesi/60)+3 b; tbsi/60 b];
y3 = [tbst/60 a; (test/60)+3 a; (test/60)+3 b; tbst/60 b];
y4 = [tblb/60 a; (telb/60)+1 a; (telb/60)+1 b; tblb/60 b];
y5 = [tbbb/60 a; (tebb/60)+1 a; (tebb/60)+1 b; tbbb/60 b];
y6 = [tbp/60 a; (tep/60)+4 a; (tep/60)+4 b; tbp/60 b];
patch('Faces',f,'Vertices',y1,'FaceColor',[0.2 0.2 0.2],'FaceAlpha',.3,'EdgeColor',[0.2 0.2 0.2],'EdgeAlpha',.3)
patch('Faces',f,'Vertices',y2,'FaceColor',[.23 0.48 0.34],'FaceAlpha',.3,'EdgeColor',[.23 0.48 0.34],'EdgeAlpha',.3)
patch('Faces',f,'Vertices',y3,'FaceColor',[0.2 0.8 0.8],'FaceAlpha',.3,'EdgeColor',[0.2 0.8 0.8],'EdgeAlpha',.3)
patch('Faces',f,'Vertices',y4,'FaceColor',[0 0.28 0.73],'FaceAlpha',.3,'EdgeColor',[0 0.28 0.73],'EdgeAlpha',.3)
patch('Faces',f,'Vertices',y5,'FaceColor',[0 0.28 0.73],'FaceAlpha',.3,'EdgeColor',[0 0.28 0.73],'EdgeAlpha',.3)
patch('Faces',f,'Vertices',y6,'FaceColor',[.69 0 0.16],'FaceAlpha',.3,'EdgeColor',[.69 0 0.16],'EdgeAlpha',.3)

u = ones(360,1)/360; hold on 
plot (t(360:end),conv(x.data.ICL(:,c),u,'valid'),'linewidth',1.5);

if  c == 2
axis([min(t+1) max(t) graphmin1 graphmax1])
elseif c == 5
axis([min(t+1) max(t) graphmin1 graphmax1])
elseif c == 3
axis([min(t+1) max(t) graphmin2 graphmax2])
elseif c == 6
axis([min(t+1) max(t) graphmin2 graphmax2])
else
axis([min(t+1) max(t) graphmin3 graphmax3])
end
%axis([min(t+1) max(t) min(x.data.ICL(:,c)) max(x.data.ICL(:,c))])
end 

subplot(2,3,1)
ylabel('O2Hb left');
subplot(2,3,2)
ylabel('HHb left');
subplot(2,3,3)
ylabel('TOI left');
subplot(2,3,4)
ylabel('O2Hb right');
xlabel('time (minutes)');
subplot(2,3,5)
ylabel('HHb right');
xlabel('time (minutes)');
subplot(2,3,6) 
ylabel('TOI right');
xlabel('time (minutes)');

%% plot MF
figure('Name','NIRS - MF');
graphmin1= min(min(ym_out(:,1),ym_out(:,4)));
graphmax1= max(max(ym_out(:,1),ym_out(:,4)));
graphmin2= min(min(ym_out(:,2),ym_out(:,5)));
graphmax2= max(max(ym_out(:,2),ym_out(:,5)));
graphmin3= min(min(ym_out(:,3),ym_out(:,6)));
graphmax3= max(max(ym_out(:,3),ym_out(:,6)));

for c = 2:7
t = (x.data.MF(:,1)-mtb)/60;
subplot(2,3,(c-1));hold on 
plot(t,ym_out(:,c-1)); hold on

f = [1 2 3 4];
y1 = [mtb/60 a; (mte/60)+4 a; (mte/60)+4 b; mtb/60 b];
y2 = [mtbsi/60 a; (mtesi/60)+3 a; (mtesi/60)+3 b; mtbsi/60 b];
y3 = [mtbst/60 a; (mtest/60)+3 a; (mtest/60)+3 b; mtbst/60 b];
y4 = [mtblb/60 a; (mtelb/60)+1 a; (mtelb/60)+1 b; mtblb/60 b];
y5 = [mtbbb/60 a; (mtebb/60)+1 a; (mtebb/60)+1 b; mtbbb/60 b];
y6 = [mtbp/60 a; (mtep/60)+4 a; (mtep/60)+4 b; mtbp/60 b];
patch('Faces',f,'Vertices',y1,'FaceColor',[0.2 0.2 0.2],'FaceAlpha',.3,'EdgeColor',[0.2 0.2 0.2],'EdgeAlpha',.3)
patch('Faces',f,'Vertices',y2,'FaceColor',[.23 0.48 0.34],'FaceAlpha',.3,'EdgeColor',[.23 0.48 0.34],'EdgeAlpha',.3)
patch('Faces',f,'Vertices',y3,'FaceColor',[0.2 0.8 0.8],'FaceAlpha',.3,'EdgeColor',[0.2 0.8 0.8],'EdgeAlpha',.3)
patch('Faces',f,'Vertices',y4,'FaceColor',[0 0.28 0.73],'FaceAlpha',.3,'EdgeColor',[0 0.28 0.73],'EdgeAlpha',.3)
patch('Faces',f,'Vertices',y5,'FaceColor',[0 0.28 0.73],'FaceAlpha',.3,'EdgeColor',[0 0.28 0.73],'EdgeAlpha',.3)
patch('Faces',f,'Vertices',y6,'FaceColor',[.69 0 0.16],'FaceAlpha',.3,'EdgeColor',[.69 0 0.16],'EdgeAlpha',.3)

u = ones(300,1)/300; hold on 
plot (t(300:end),conv(x.data.MF(:,c),u,'valid'),'linewidth',1.5);

if  c == 2
axis([min(t+1) max(t) graphmin1 graphmax1])
elseif c == 5
axis([min(t+1) max(t) graphmin1 graphmax1])
elseif c == 3
axis([min(t+1) max(t) graphmin2 graphmax2])
elseif c == 6
axis([min(t+1) max(t) graphmin2 graphmax2])
else
axis([min(t+1) max(t) graphmin3 graphmax3])
end
%axis([min(t+1) max(t) min(x.data.MF(:,c)) max(x.data.MF(:,c))])
end 

subplot(2,3,1)
ylabel('O2Hb left');
subplot(2,3,2)
ylabel('HHb left');
subplot(2,3,3)
ylabel('TOI left');
subplot(2,3,4)
ylabel('O2Hb right');
xlabel('time (minutes)');
subplot(2,3,5)
ylabel('HHb right');
xlabel('time (minutes)');
subplot(2,3,6) 
ylabel('TOI right');
xlabel('time (minutes)');


