close all;
clear all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Main page for calling all the individual functions %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('JS00001', 'val'); % load in the ECG data from saved file

filtered_ecg = ECG_digital_filter(val); % calling the function that returns the filtered ECG data as an output

MenuGUI();