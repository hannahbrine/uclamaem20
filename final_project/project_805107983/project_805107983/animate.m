%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Name of the script: animate.m
%
% Description: This program will create an animation demonstrating the
% spread of susceptible, infected, and recovered people according to the
% SIR model.
%
% Name: Hannah Brine (hannahebrine@gmail.com) 
% UID: 805107983
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function animate(X)
 % animate: a function that shows the change in the ratio of susceptible,
 % infected, and recovered individuals in the grid as an image.
 % Inputs:
 % X: an M*N*3*length(t) matrix, where each point in the M*N space
 % corresponds to a single grid with 3 numbers between 0 and 1 showing
 % the SIR result. this 3D matrix is repeated for each time step
 % making it a 4D matrix.
 %
 % Output: this function does not output anything.

 % reorganizing SIR according to colors
 color(:, :, 2, :) = X(:, :, 3, :); % I: Red
 color(:, :, 1, :) = X(:, :, 2, :); % S: Blue
 color(:, :, 3, :) = X(:, :, 1, :); % R: Green

 figure;
 for t = 1:size(X, 4)/10
     image(squeeze(color(:, :, :,t*10)))
     title('Spatial Representation of the Spread of Disease')
     colorbar
     pause(0.1)
 end
end
 