%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Name of the script: project_805107983_p2.m
%
% Description: This program will call solveSpatialSIR.m and compare its time to MATLAB's built in ODE solver. 
% It will also create three SIR plots at the specified points as well as an
% animate showing the spread of infection and recovery. 
%
% Name: Hannah Brine (hannahebrine@gmail.com) 
% UID: 805107983
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Clearing Out

clear; clc; close all;

%% Main Script

load('initialValues.mat');

 % infer the size of the grid from the inital conditions
[M, N] = size(initialConditions, [1, 2]);

alpha = 0.1;
beta = 0.05;
gamma = 0.1;
tFinal = 60;


%% solveSpatialSIR

 tic;
 solveSpatialSIR = @solveSpatialSIR;
 [t, X] = solveSpatialSIR(tFinal, initialConditions, alpha, beta, gamma, @RK4);
 toc

tic;
[t,X] = solveSpatialSIR(tFinal, initialConditions, alpha, beta, gamma, @ode45);
toc

%% plotTimeSeries
 
coord = [1, 1; 5, 18; 30, 70];
timeseries = @plotTimeSeries;

% plotting the three time series 
for i=1:3
    x = coord(i,1);
    y = coord(i,2);
    timeseries(t, X, x, y);
end

%% animate
% call animate
anim = @animate;
anim(X)