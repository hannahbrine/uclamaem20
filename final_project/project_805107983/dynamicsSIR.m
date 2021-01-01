%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Name of the script: dynamicsSIR.m
%
% Description: This program vectorized the outputs of the RK4.m program and
% outputs the vectorized time derivative.
%
% Name: Hannah Brine (hannahebrine@gmail.com) 
% UID: 805107983
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dxdt = dynamicsSIR(x, M, N, alpha, beta, gamma)
 % dynamicsSIR Compute the rate of change of the model
 % Inputs:
 % x: vectorized state
 % M, N: size of the grid
 % alpha, beta, gamma: model parameters
% Output:
 % dxdt: vectorized time derivative of state


  %% Implementation
  
  % reshaping the matrix into a useable form
  x_orig = x;
  %fprintf('xorig %d\n', size(x_orig))
  x = reshape(x_orig, [M, N, 3]);
 %fprintf('x %d\n', size(x))

  % preparing dynamics 
   S = reshape(x(:, :, 1), [M ,N]);
   I = reshape(x(:, :, 2), [M ,N]);
   % R = reshape(x(:, :, 3), [M ,N]); commented out because it is not used,
   % but would like it here for visual 
 
  % preallocating the derivatives matrix
  derivatives = zeros(M, N, 3);

 % finding the weights for each individual cell
 for row = 1:M
    for col= 1:N
         % boundaries
        if (row > 1 && col > 1) && (row < M && col < N)
            TL = 1/sqrt(2) .* x(row-1, col-1,2);
            TM = x((row - 1), col, 2);
            TR = 1/sqrt(2) .* x(row-1, col + 1, 2);
            LM = x(row, col-1, 2);
            RM = x(row, col+1, 2);
            BL = 1/sqrt(2) .* x(row+1, col-1, 2);
            BM = x(row+1, col, 2);
            BR = 1/sqrt(2) .* x(row+1, col+1, 2);
            W = TL + TM + TR + LM + RM + BL + BM + BR;
        elseif col == 1 && row == 1 % top left
            RM = x(row, col+1, 2);
            BM = x(row+1, col, 2);
            BR = 1/sqrt(2) .* x(row+1, col+1, 2);
            W = RM + BM + BR;
        elseif col == 1 && (1 < row) && (row < M) % left side
            TM = x((row - 1), col, 2);
            TR = 1/sqrt(2) .* x(row-1, col + 1, 2);
            RM = x(row, col+1, 2);
            BR = 1/sqrt(2) .* x(row+1, col+1, 2);
            BM = x(row+1, col, 2);
            W = TM + TR + RM + BR + BM; 
        elseif col == 1 && row == M % bottom left
            TM = x((row - 1), col, 2);
            TR = 1/sqrt(2) .* x(row-1, col + 1, 2);
            RM = x(row, col+1, 2);
            W = TM + TR + RM; 
        elseif row == M && (1 < col) && (col < N) % bottom side
            LM = x(row, col-1, 2);
            TL = 1/sqrt(2) .* x(row-1, col-1,2);
            TM = x((row - 1), col, 2);
            TR = 1/sqrt(2) .* x(row-1, col + 1, 2);
            RM = x(row, col+1, 2);
            W = LM + TL + TM + TR + RM;
        elseif row == M && col == N % bottom right
            LM = x(row, col-1, 2);
            TL = 1/sqrt(2) .* x(row-1, col-1,2);
            TM = x((row - 1), col, 2);
            W = LM + TL + TM;
        elseif col == N && (1 < row) && (row < M) % right side
            BM = x(row+1, col, 2);
            BL = 1/sqrt(2) .* x(row+1, col-1, 2);
            LM = x(row, col-1, 2);
            TL = 1/sqrt(2) .* x(row-1, col-1,2);
            TM = x((row - 1), col, 2);
            W = BM + BL + LM + TL + TM;
        elseif col == N && row == 1 %top right
            LM = x(row, col-1, 2);
            BL = 1/sqrt(2) .* x(row+1, col-1, 2);
            BM = x(row+1, col, 2);
            W = LM + BL + BM;
        elseif row == 1 && (col > 1) && (col < N) % top side
            LM = x(row, col-1, 2);
            BL = 1/sqrt(2) .* x(row+1, col-1, 2);
            BM = x(row+1, col, 2);
            RM = x(row, col+1, 2);
            BR = 1/sqrt(2) .* x(row+1, col+1, 2);
            W = LM + BL + BM + BR + RM;
        end 
       
       % Calculated the dynamics
        neighborInteractions = (alpha .* W.* I );
        derivatives(:, :, 1) = -(beta .* I + neighborInteractions) .* S; % S
        derivatives(:, :, 2) = ((beta .* I + neighborInteractions) .* S - gamma .* I); % I
        derivatives(:, :, 3) =  gamma .* I; % R
        
    end
 end
 
 % Vectorize the derivatives
 dxdt = derivatives(:);     
end