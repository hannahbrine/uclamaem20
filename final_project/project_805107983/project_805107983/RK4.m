%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Name of the script: RK4.m
%
% Description: Using the fourth order Runge-Kutta algorithm, we will make
% our own equivalent to the ode45.m solver MATLAB has already. It will give
% us the time steps and solution of the differential equation.
%
% Name: Hannah Brine (hannahebrine@gmail.com) 
% UID: 805107983
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [t, y] = RK4(f, tspan, y0)
 % RK4 Numerically solves the differential equation using the fourth-order Runge-Kutta algorithm
 % Inputs:
 % f: function handle of f(t, y)
 % tspan: the time period for simulation (should be a 1x2 array contain start time and end time)
 % y0: the initial conditions for the differential equation
 
 % Outputs:
 % t: corresponding time sequence as a T x 1 vector
 % y: the solution of the differential equation as a T x n matrix,where T is the number of time steps and n is the dimension of y
   
 %% Implementation
 
 % inital variables 
  h = 0.1; % step size
  nSteps = tspan(:,2)/h + 1; % total amount of steps
  sz = size(y0); % finding the dimensions of the initial conditions for the diff eq
  sz = sz(1); 
  
  % preallocation
  y = zeros(tspan(2), sz);
  t = zeros(nSteps, 1);
  k1 = zeros(1, sz);
  k2 = zeros(1, sz);
  k3 = zeros(1, sz);
  k4 = zeros(1, sz);
  
  % filling in
  %t = 0:h:tspan(:,2); % preallocate with zeros
  y0 = y0.';
  
  y(1,:) = y0; 
  t(1,1) = tspan(1,1);  

  k = 1;
 while k <= nSteps
     k1 = h * f(t(k), y(k,:));
    % fprintf('k1 %d\n', size(k1))
    % fprintf('y %d\n', size(y))
     k1 = k1.';
     k2 = h * f(t(k) + (h/2), y(k,:) + (k1/2));
     k2 = k2.';
     k3 = h * f(t(k) + (h/2), y(k,:) + (k2/2));
     k3 = k3.';
     k4 = h * f((t(k) + h), y(k,:) + k3);
     k4 = k4.';
     t(k+1) = t(k) + h;
     
     y(k+1,:) = y(k,:) + (k1 + (2*k2) + (2 * k3) + k4)/6;
     
     k = k+1;
 end
end