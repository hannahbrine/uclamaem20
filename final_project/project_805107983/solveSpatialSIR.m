%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Name of the script: solveSpatialSIR.m
%
% Description: This function is the wrapper for the dynamicsSIR.m
% function and will give us the desired SIR function values and matrix in
% the form of output X. The time steps will be outputted as t.
%
% Name: Hannah Brine (hannahebrine@gmail.com) 
% UID: 805107983
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [t, x] = solveSpatialSIR(tFinal, initialConditions, alpha, beta, gamma, odeSolver)
 %solveSpatialSIR Solve the spatial SIR model
 % Inputs: 
 % tFinal: end time for the simulation (assuming start is t=0)
 % initialCondition: a MxNx3 matrix that sums to 1 in third dimension
 % alpha, beta, gamma: model parameters
 % odeSolver: a function handle for an ode45-compatible solver
 % Outputs:
 % t: a vector of the time-steps
 % X: MxNx3xlength(t) matrix representing the state vs. time
 
%% Solving 

% setting up initial values
 y0 = initialConditions(:);
 tspan = [0 tFinal];
 [M, N] = size(initialConditions, [1, 2]);

% calling dynamicsSIR function
 
 [t, sol] = odeSolver(@(t,x)dynamicsSIR(x, M, N, alpha, beta, gamma),...
      tspan, y0);
  
% preallocating
 x = zeros(M, N, 3, numel(t));
 
  for i = 1:numel(t)
      x(:, :, :, i) = reshape(sol(i, :), [M, N, 3]);
  end
 
end
