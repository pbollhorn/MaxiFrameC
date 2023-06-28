%**************************************************************************
% File: Ex_Frame.m
%   In-data file for 3D frame consisting of eight nodes connected by eight
%   elements and subjected to two horizontal point loads.
% Date:
%   Version 1.0        27.07.12
%**************************************************************************

% Clear memory
clear all, close all, clc

% Coordinates of nodes: X = [ X Y Z ]
X = [ 0  0  0
      1  0  0 
      0  1  0
      1  1  0 
      0  0  1
      1  0  1
      0  1  1
      1  1  1 ];

% Coordinates of third nodes: X3 = [ X Y Z ]
X3 = [ 0.5  0  0
       0.5  1  0 
       0.5 0.5 1 ];

% Element topology: T = [ node1 node2 beamno ]
T = [ 1  5  1 
      2  6  2 
      3  7  3
      4  8  4
      5  6  5
      6  8  6
      7  8  7
      5  7  8 ];

% Beam topology: B = [ node1 node2 propno node3 ]
B = [ 1  5  1  1 
      2  6  1  1 
      3  7  1  2
      4  8  1  2
      5  6  1  1
      6  8  1  3
      7  8  1  2
      5  7  1  3 ];

% Beam properties
G{1}.EA  = @(s) 1;
G{1}.EIy = @(s) 1;
G{1}.EIz = @(s) 2;
G{1}.GK  = @(s) 1;
G{1}.EIw = @(s) 0.01;

% Nodal loads: P = [ node dof value ]
P = [ 5  2 -1 
      8  2  1 ];
  
% Supports  
C{1}.dofs = [ 1 0
              2 0 
              3 0 ];
C{2}=C{1};
C{3}=C{1};
C{4}=C{1};

% Call MaxiFrameC
MaxiFrameC

% Output
U     % Nodal displacements
R     % Nodal reactions
Uen   % Displacements along elements
Sen   % Section forces along elements