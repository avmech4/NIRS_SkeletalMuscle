%%
% *Automated selection of data sections in a NIRS data set*
% Copyright Anna Vanmechelen
%
% Written for the following 3min protocol: 
% 3x MVC
% prone 
% sitting
% standing
% bending FW 25°
% prone
%
% Feel free to copy and alter

%Data sets in column form 
%x7 sheet name excel file 

clear all; close all; clc
%% add a path 
addpath(genpath('C:\Users\Administrator\Documents\FWO data'));
%% importdata 
fname = 'PP_baseline2.xlsx';
x = importdata(fname);
set(0,'DefaultFigureWindowStyle','docked')

%% exportdata 
fsolution='PP_baseline2_results.xls';
%% pkshave 
% Peter Van Overschee
%		January 4, 1994
% Revised	Jeroen Buijs
%		April 5, 2000
y_out = zeros(length(x.data.x7(:,2)),8);
for c = 3:10
[z,mu,sigma] = zscore(x.data.x7(:,c));
z_out = pkshave(z,[-3,3],false); %pkshave of all columns 
y_out(:,c-1)= z_out*sigma+mu;
end 
y_out(:,1)=x.data.x7(:,2);
%% Determine the start and stop times.
timeMask = startsWith(x.textdata.x7(2:end,11),"EVNT");

% The number of datapoints.
nb_data = numel(timeMask);

% The location in the data.
eventLocation = 1:nb_data;
eventLocation = eventLocation(timeMask);
time =y_out(:,1);
headers = x.textdata.x7(1,3:10);

% Data itself.
data = y_out(:,2:9);
eventTimes = time(timeMask==1);
nbEvents = numel(eventTimes)/2;


%%  Plot data per event
% The even events are the starting pontis of the experiment.
close all;
clc
% col = [1,2];
H = zeros(9,8);
for q = 3:10
for ev = 1:9
    fprintf("------------------------------\n");
    fprintf("Evaluating experiment: %i\n",ev);
    t_start = eventTimes(ev*2-1);
    t_stop = eventTimes(ev*2);
    p_start = eventLocation(ev*2-1);
    p_stop = eventLocation(ev*2);
    experimentTime =  time(p_start:p_stop)-time(p_start);
    value = (x.data.x7(:,q));
    t_sample = time(p_start+1) - time(p_start);% Determine the sample time
    res = mean(value(p_start:p_stop));
    H(ev,q-2) = res;
   
end
end
disp(H)
xlswrite(fsolution,headers,'x7','A1')
xlswrite(fsolution,H,'x7','A2')
