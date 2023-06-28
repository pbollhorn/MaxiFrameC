% Clear memory
clear all, close all, clc

% Coordinates of nodes: X = [ X Y Z ]
X = [  4.2200     0        0         
       4.0762     0        1.0922   
       3.6546     0        2.1100   
       2.9840     0        2.9840  
       2.1100     0        3.6546   
       1.0922     0        4.0762   
       0          0        4.2200   ];

% Coordinates of third nodes: X3 = [ X Y Z ]
X3 = [ 0  0  0 ];

% Element topology: T = [ node1 node2 beamno ]
T = [ 1  2  1 
      2  3  2
      3  4  3
      4  5  4
      5  6  5
      6  7  6  ];
  
% Beam topology: B = [ node1 node2 propno node3 ]
B = [ 1  2  1  1 
      2  3  1  1
      3  4  1  1
      4  5  1  1
      5  6  1  1
      6  7  1  1  ];
  
% Beam properties
G{1}.EA   = @(s) 2.0000e+005;
G{1}.GAey = @(s) 6.8176e+004;
G{1}.GAez = @(s) 8.0000e+004;
G{1}.EIy  = @(s) 1.6667e+002;
G{1}.EIz  = @(s) 6.6667e+002;
G{1}.GK   = @(s) 1.9428e+002;
G{1}.EIw  = @(s) 2.3505e-001;
G{1}.ip = 15;

% Nodal loads: P = [ node dof value ]
P = [ 7  2  1
      7  3  1 ];

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
U(7,2) % Shear in Y-direction
U(7,3) % Shear in Z-direction