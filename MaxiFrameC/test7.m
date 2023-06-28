% Clear memory
clear all, close all, clc

% Inputs
Q  = 10;
l  = 0.76;
h0 = 72.76e-3;
b  = 31.55e-3;
t  = 3.11e-3;
E  = 65.31e9;
alpha=0.1:0.1:0.9;

% Loop over different values of alpha
for j=1:size(alpha,2)

    % Height of beam as function of s
    h = @(s) h0*(1-s*(1-alpha(j)));

    % Coordinates of nodes: X = [ X Y Z ]
    X = [  0  0  0
           l  0  0  ];

    % Coordinates of third nodes: X3 = [ X Y Z ]
    X3 = [ 0  -1  0 ];

    % Element topology: T = [ node1 node2 beamno ]
    T = [  1  2  1  ];

    % Beam topology: B = [ node1 node2 propno node3 ]
    B = [ 1  2  1  1 ];

    % Beam properties
    G{1}.EA  = @(s) 10;
    G{1}.EIy = @(s) 10;
    G{1}.EIz = @(s) E*t*b^3*(2*h(s)+b)/(3*h(s)+6*b);
    G{1}.GK  = @(s) 10;
    G{1}.EIw = @(s) 10;
    G{1}.cy  = @(s) -b^2/(h(s)+2*b);

    % Nodal loads: P = [ node dof value ]
    P = [ 2  1  Q ];

    % Supports
    C{1}.dofs = [ 1  0
                  2  0
                  3  0
                  4  0
                  5  0
                  6  0 
                  7  0 ];

    % Call MaxiFrameC
    MaxiFrameC

    % Numerical result for rotation at tip
    phi_z_l_numerical(j)  = U(2,6);
    
    % Analytical result for rotation at tip
    phi_z_l_analytical(j) = 3/2*Q*l*log((2*h0+b)/(2*alpha(j)*h0+b))...
                            /(E*t*b*h0*(alpha(j)-1));

end

% Plot results
figure
plot(alpha,[Q./phi_z_l_numerical;Q./phi_z_l_analytical],'-o')
xlabel('\alpha [-]')
ylabel('$$Q/\varphi_z(\ell)$$ [N]','Interpreter','latex')
legend('Numerical','Analytical','Location','Best')