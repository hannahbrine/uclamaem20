%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Name of the script: project_805107983_p1.m
%
% Description: This program will create a plot with the eigenvectors
% created by the myPCA.m program on a 2D vector subspace.
%
% Name: Hannah Brine (hannahebrine@gmail.com) 
% UID: 805107983
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Clearing Out

clear; clc; close all;

%% Performing myPCA on the data

% Loading in the data
data = readtable('covid_countries.csv', 'Range', 'C1:H28', 'ReadVariableNames', true, 'PreserveVariableNames', true);
data = table2array(data);
% variable names
variables_temp = readtable('covid_countries.csv', 'PreserveVariableNames', true);
variables_temptwo = variables_temp.Properties.VariableNames;
variables = variables_temptwo(1,3:8);
% Calling myPCA
PCA = @myPCA; 
[coeffOrth,pcaData] = PCA(data);

%% Plotting the results
 figure('Name', 'Principal Component Analysis')
 biplot(coeffOrth(:,1:2), 'Scores', pcaData(:, 1:2),'VarLabels', variables); %, 'ObsLabels', samples);
 title('PCA Analysis of COVID-19 Data')
 box on;
 grid on;
 saveas(gcf,'pca.png'); 
 