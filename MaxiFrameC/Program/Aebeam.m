function [Ae,A] = Aebeam(Xe,X3e)
%**************************************************************************
% File: Aebeam.m
%   Builds rotation matrices for transforming between local xyz- and
%   global XYZ-coordinates.
% Syntax:
%   [Ae,A] = Aebeam(Xe,X3e)
% Input:
%   Xe  : Coordinates of nodes, Xe = [ X1 Y1 Z1 ; X2 Y2 Z2 ]
%   X3e : Coordinates of third nodes, X3e = [ X3 Y3 Z3 ]
% Output:
%   Ae  : Element rotation matrix
%   A   : Rotation matrix for 3D vectors
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Vector from 1st to 2nd node and from 1st to 3rd node
V12 = Xe(2,:)-Xe(1,:);
V13 = X3e-Xe(1,:);

% Unit vector in x-, z-, and y-direction
Vx = V12/norm(V12);
Vz = cross(V13,V12)/norm(cross(V13,V12));
Vy = cross(Vz,Vx);

% Rotation matrix for 3D vectors
A = [ Vx
      Vy
      Vz ];

% Nodal rotation matrix
An = [   Vx     0  0  0  0
         Vy     0  0  0  0
         Vz     0  0  0  0
       0  0  0     Vx    0
       0  0  0     Vy    0
       0  0  0     Vz    0
       0  0  0  0  0  0  1  ];
      
% Element rotation matrix
Ae = [     An        zeros(7,7)
       zeros(7,7)       An       ];