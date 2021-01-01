%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Name of the script: plotTimeSeries.m
%
% Description: This script will create a plot that shows the SIR
% distribution at a specified coordinate point over the previously allotted
% time steps
%
% Name: Hannah Brine (hannahebrine@gmail.com) 
% UID: 805107983
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plotTimeSeries(t, X, x, y)
 % plotTimeSeries: a function that plots and saves the local S.I.R distribution at spatial coordianate (x, y).
 % Inputs:
 % t: a vector of time steps
 % X: an M*N*3*length(t) matrix, where each point in the M*N space
 % corresponds to a local S.I.R. model with states whose values are between 0 and 1. This 3D matrix is repeated for...
 %   each time step, making it a 4D matrix.
 % x: the spatial x-coordinate on the grid
 % y: the spatial y-coordinate on the grid
 
 % Outputs:
 % This function has no outputs
 
 formatSpec1 = "Time Series at x = %d and y = %d";
 formatSpec2 = "time_series_%d_%d.png";

 str1 = sprintf(formatSpec1, x, y);
 filename = sprintf(formatSpec2, x, y);

 figure('Name', str1)
 subplot(3,1,1)
 x_axis = 1:t(end);
 y1 = X(x, y ,1);
 plot(x_axis,y1)
 title(['Susceptible Individuals at x = ', num2str(x), ' and y = ', num2str(y)]);
 xlabel('Time Steps');
 ylabel('S(t) Normalized');

 subplot(3,1,2)
 y2 = X(x, y ,2);
 plot(x_axis,y2)
 title(['Infected Individuals at x = ', num2str(x), ' and y = ', num2str(y)]);
 xlabel('Time Steps');
 ylabel('I(t) Normalized');

 subplot(3,1,3)
 y3 = X(x, y ,3);
 plot(x_axis,y3)
 title(['Recovered Individuals at x = ', num2str(x), ' and y = ', num2str(y)]);
 xlabel('Time Steps');
 ylabel('R(t) Normalized');

 box on;
 saveas(gcf,filename, 'png'); 
end
 
 