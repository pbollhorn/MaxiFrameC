% Clear memory
clear all, close all, clc

% Inputs
q = 1e3;
l = 10;

% Coordinates of nodes: X = [ X Y Z ]
X = [  0  0  0
       l  0  0 ];

% Coordinates of third nodes: X3 = [ X Y Z ]
X3 = [ 0  -1  0 ];

% Element topology: T = [ node1 node2 beamno ]
T = [ 1  2  1 ];
  
% Beam topology: B = [ node1 node2 propno node3 ]
B = [ 1  2  1  1 ];

% Beam properties
G{1}.EA  = @(s) 1.2428e10;
G{1}.EIy = @(s) 1.0365e9;
G{1}.EIz = @(s) 1e9;
G{1}.GK  = @(s) 1e9;
G{1}.EIw = @(s) 1e9;
G{1}.cz  = @(s) 0.5;
G{1}.az  = @(s) 0.5;

% Distributed loads: p = [ elem qx qy qz mx my mz ]
p = [ 1 0 0 -q 0 0 0 ];
  
% Supports
C{1}.dofs = [ 1 0
              2 0
              3 0 
              4 0 ];
%C{1}.offset = [ 0 0 0.5 ];
C{2}=C{1};

% Call MaxiFrameC
MaxiFrameC

% Output
R(1,1)  % RH
R(1,3)  % RV
U(1,5)  % phi_y_0