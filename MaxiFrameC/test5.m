% Clear memory
clear all, close all, clc

% Inputs
Q  = 10;
h  = 72.76e-3;
b  = 31.55e-3;
tf = 3.11e-3;
tw = 2.13e-3;
E  = 65.31e9;
Gm = 25.63e9;
l  = linspace(1,25,10);

% Loop over different values of l
for j=1:size(l,2)

    % Coordinates of nodes: X = [ X Y Z ]
    X = [  0    0  0
           l(j) 0  0  ];

    % Coordinates of third nodes: X3 = [ X Y Z ]
    X3 = [ 0  -1  0 ];

    % Element topology: T = [ node1 node2 beamno ]
    T = [  1  2  1  ];

    % Beam topology: B = [ node1 node2 propno node3 ]
    B = [ 1  2  1  1 ];

    % Beam properties
    G{1}.EA  = @(s) 10;
    G{1}.EIy = @(s) 10;
    G{1}.EIz = @(s) 10;
    G{1}.GK  = @(s) Gm*2/3*b*tf^3;
    G{1}.EIw = @(s) E*1/24*tf*h^2*b^3;
    G{1}.cz  = @(s) h/2;
    G{1}.az  = @(s) h/2;
    G{1}.ip = 15;

    % Nodal loads: P = [ node dof value ]
    P = [ 2 2 Q ];

    % Supports
    C{1}.dofs = [ 1  0
                  2  0
                  3  0
                  4  0
                  5  0
                  6  0
                  7  0  ];

    % Call MaxiFrameC
    MaxiFrameC

    % Numerical results for twist and warping function at tip
    phi_l_numerical(j) = U(2,4);
    theta_l_numerical(j) = U(2,7);
    
    % Analytical results for twist and warping function at tip
    M = Q*h/2;
    k = sqrt(G{1}.GK(0)/G{1}.EIw(0));
    phi_l_analytical(j) = (k*l(j)-tanh(k*l(j)))*1/k*M/G{1}.GK(0);
    theta_l_analytical(j) = (sech(k*l(j))-1)*M/G{1}.GK(0);

end

% Plot results for twist at tip
figure
plot(k*l,[Q./phi_l_numerical;Q./phi_l_analytical],'-o')
xlabel('$$k\ell$$ [-]','Interpreter','latex')
ylabel('$$Q/\varphi(\ell)$$ [N]','Interpreter','latex')
legend('Numerical','Analytical','Location','Best')

% Plot results for warping function at tip
figure
plot(k*l,[Q./theta_l_numerical;Q./theta_l_analytical],'-o')
xlabel('$$k\ell$$ [-]','Interpreter','latex')
ylabel('$$Q/\theta(\ell)$$ [Nm]','Interpreter','latex')
legend('Numerical','Analytical','Location','Best')