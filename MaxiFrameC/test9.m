% Clear memory
clear all, close all, clc

% Inputs
Q = 1e3;
l = 10;
alpha = linspace(-0.4,0.4,20);

% Loop over different values of alpha
for j=1:size(alpha,2)
    
    % Coordinates of nodes: X = [ X Y Z ]
    X = [  0  0  0
          l/2 0  0
           l  0  0 ];
    
    % Coordinates of third nodes: X3 = [ X Y Z ]
    X3 = [ 0  -1  0 ];
    
    % Element topology: T = [ node1 node2 beamno ]
    T = [ 1  2  1
          2  3  1 ];
    
    % Beam topology: B = [ node1 node2 propno node3 ]
    B = [ 1  3  1  1 ];
    
    % Beam properties
    G{1}.EA  = @(s) 1.2428e10;
    G{1}.EIy = @(s) 1.0365e9;
    G{1}.EIz = @(s) 1e9;
    G{1}.GK  = @(s) 1e9;
    G{1}.EIw = @(s) 1e9;
    
    % Nodal loads: P = [ node dof value ]
    P = [ 2 3 -Q ];
    
    % Supports
    C{1}.dofs = [ 1 0
                  2 0
                  3 0
                  4 0 ];
    C{1}.offset = [ alpha(j)*l 0 0 ];
    C{3}.dofs = [ 1 0
                  2 0
                  3 0
                  4 0 ];
    C{3}.offset = [ -alpha(j)*l 0 0 ];
    
    
    % Call MaxiFrameC
    MaxiFrameC
    
    % Numerical result for deflection at midspan
    u_numerical(j)  = U(2,3);
    
    % Analytical result for deflection at midspan
    u_analytical(j) = -1/48*Q*(l*(1-2*alpha(j)))^3/G{1}.EIy(0);
    
end


% Plot results
figure
plot(alpha,[u_numerical;u_analytical],'-o')
xlabel('\alpha [-]')
ylabel('$$u_z(\ell/2)$$ [m]','Interpreter','latex')
legend('Numerical','Analytical','Location','Best')