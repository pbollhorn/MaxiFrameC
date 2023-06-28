% Clear memory
clear all, close all, clc

% Coordinates of nodes: X = [ X Y Z ]
X = [  0    0  0
       6.0  0  0  ];

% Coordinates of third nodes: X3 = [ X Y Z ]
X3 = [ 0  -1  0 ];

% Element topology: T = [ node1 node2 beamno ]
T = [ 1  2  1 ];
  
% Beam topology: B = [ node1 node2 propno node3 ]
B = [ 1  2  1  1 ];

% Beam properties
G{1}.EA   = @(s) 2.0000e+005;
G{1}.GAey = @(s) 7.6923e+004;
G{1}.GAez = @(s) 6.5554e+004;
G{1}.EIy  = @(s) 6.6667e+002;
G{1}.EIz  = @(s) 1.6667e+002;
G{1}.GK   = @(s) 1.8681e+002;
G{1}.EIw  = @(s) 2.3505e-001;
G{1}.ip   = 25;

% Nodal loads: P = [ node dof value ]
P = [ 2  1  1
      2  2  1
      2  3  1
      2  4  1 ];

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
U(2,1) % Extension
U(2,2) % Shear in y-direction
U(2,3) % Shear in z-direction
U(2,4) % Twist