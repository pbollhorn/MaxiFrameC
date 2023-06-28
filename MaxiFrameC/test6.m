% Clear memory
clear all, close all, clc

% Inputs
q  = 10;
l  = 0.76;
h0 = 72.76e-3;
b  = 31.55e-3;
tf = 3.11e-3;
tw = 2.13e-3;
E  = 65.31e9;
alpha=0.1:0.1:0.9;

% Loop over different values of alpha
for j=1:size(alpha,2)

    % Height of beam as function of s
    h = @(s) h0*(1-s*(1-alpha(j)));

    % Coordinates of nodes: X = [ X Y Z ]
    X = [  0   0   0 
           l   0   0  ];

    % Coordinates of third nodes: X3 = [ X Y Z ]
    X3 = [ 0  -1  0 ];

    % Element topology: T = [ node1 node2 beamno ]
    T = [  1  2  1  ];

    % Beam topology: B = [ node1 node2 propno node3 ]
    B = [ 1  2  1  1 ];

    % Beam properties
    G{1}.EA   = @(s) 10;
    G{1}.EIy  = @(s) E*( 1/12*tw*h(s)^3 + 1/2*tf*b*h(s)^2 );
    G{1}.EIz  = @(s) 10;
    G{1}.GK   = @(s) 10;
    G{1}.EIw  = @(s) 10;
    
%     % Nodal loads: P = [ node dof value ]
%     P = [ 1 5 -1/12*q*l^2 
%           2 5  1/12*q*l^2 ];
    
    % Distributed loads: p = [ elem qx qy qz mx my mz ]
    p = [ 1 0 0 q 0 0 0 ];
    
    % Supports
    C{1}.dofs = [ 1  0
                  2  0
                  3  0
                  4  0 ];
    C{2}=C{1};

    % Call MaxiFrameC
    MaxiFrameC

    % Numerical results for phi_y_0 and phi_y_l
    phi_y_0_numerical(1,j) = U(1,5);
    phi_y_l_numerical(1,j) = U(2,5);

end

% Plot results for phi_y_0
figure
plot(alpha,[q./phi_y_0_numerical;[-2.988e5 -3.971e5 -4.911e5 -5.844e5 -6.782e5 -7.734e5 -8.701e5 -9.686e5 -1.069e6]],'-o')
xlabel('\alpha [-]')
ylabel('$$q/\varphi_y(0)$$ [N/m]','Interpreter','latex')
legend('Numerical','Maple','Location','Best')

% Plot results for phi_y_l
figure
plot(alpha,[q./phi_y_l_numerical;[1.169e5 2.027e5 2.949e5 3.949e5 5.031e5 6.197e5 7.448e5 8.784e5 1.020e6]],'-o')
xlabel('\alpha [-]')
ylabel('$$q/\varphi_y(\ell)$$ [N/m]','Interpreter','latex')
legend('Numerical','Maple','Location','Best')

% Plot section force My
x = linspace(0,l,11);
figure
plot(x/l,[ Sen(1,:,5) ; q*x.*(l-x)/2 ],'-o')
xlabel('$$x/\ell$$ [-]','Interpreter','latex')
ylabel('M_y(x) [Nm]')
legend('Numerical','Analytical','Location','Best')