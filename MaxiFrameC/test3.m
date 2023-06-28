% Clear memory
clear all, close all, clc

% Inputs
EI1 = 1.0293e6;
EI2 = 8.7108e4;
alpha = @(s)pi/2*s;

% Coordinates of nodes: X = [ X Y Z ]
X = [ 0     0  0
      12.0  0  0 ];

% Coordinates of third nodes: X3 = [ X Y Z ]
X3 = [ 0  -1  0 ];

% Element topology: T = [ node1 node2 beamno ]
T = [ 1  2  1  ];

% Beam topology: B = [ node1 node2 propno node3 ]
B = [ 1  2  1  1 ];

% Beam properties
G{1}.EA   = @(s)  1e9;
G{1}.GAey = @(s)  3.4863e6;
G{1}.GAez = @(s)  3.4863e6;
G{1}.EIy  = @(s)  EI1*cos(alpha(s))^2 + EI2*sin(alpha(s))^2;
G{1}.EIyz = @(s)  -(EI1-EI2)*sin(alpha(s))*cos(alpha(s));
G{1}.EIz  = @(s)  EI1*sin(alpha(s))^2 + EI2*cos(alpha(s))^2;
G{1}.GK   = @(s)  1e9;
G{1}.EIw  = @(s)  1e9;

% Nodal loads: P = [ node dof value ]
P = [  
       2  2  1
     % 2  3  1
                ];
  
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

% Output
U(2,2) % Shear in y-direction
U(2,3) % Shear in z-direction