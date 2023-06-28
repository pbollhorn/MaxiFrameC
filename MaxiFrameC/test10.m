% Clear memory
clear all, close all, clc

% Inputs
M = 1e3;
l = 10;
alpha = -0.5:0.1:0.5;

% Loop over different values of alpha
for j=1:size(alpha,2)
    
    % Coordinates of nodes: X = [ X Y Z ]
    X = [ l+alpha(j)*l  0  0
          l+alpha(j)*l  0  l
              0         0  l  ];
    
    % Coordinates of third nodes: X3 = [ X Y Z ]
    X3 = [ 0  0  0 ];
    
    % Element topology: T = [ node1 node2 beamno ]
    T = [ 1  2  1
          2  3  2 ];
    
    % Beam topology: B = [ node1 node2 propno node3 ]
    B = [ 1  2  1  1
          2  3  2  1 ];
    
    % Beam properties
    G{2}.EA  = @(s) 1e9;
    G{2}.EIy = @(s) 1e9;
    G{2}.EIz = @(s) 1e9;
    G{2}.GK  = @(s) 1e9;
    G{2}.EIw = @(s) 1e9;
    G{1}=G{2};
    G{1}.cy  = @(s) -alpha(j)*l;
    G{1}.ay  = @(s) -alpha(j)*l;
    
    % Nodal loads: P = [ node dof value ]
    P = [ 3 5 M ];
    
    % Supports
    C{1}.dofs = [ 1 0
                  2 0
                  3 0
                  4 0
                  5 0
                  6 0
                  7 0 ];
    
    % Call MaxiFrameC
    MaxiFrameC
    
    % Numerical result for rotation
    phi_Y_numerical(j) = U(3,5);
    
end

% Formel result for rotation
phi_Y_formal = M*(l+l)/G{1}.EIz(0) * ones(1,size(alpha,2));

% Effective result for rotation
phi_Y_effective = M*(l+l+alpha*l)/G{1}.EIz(0);

% Plot results
figure
plot(alpha,[phi_Y_numerical;phi_Y_formal;phi_Y_effective],'-o')
xlabel('\alpha [-]')
ylabel('$$\varphi_Y$$ [-]','Interpreter','latex')
legend('Numerical','Formal','Effective','Location','Best')