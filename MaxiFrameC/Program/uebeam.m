function ue = uebeam(U,Xe,X3e,Te)
%**************************************************************************
% File: uebeam.m
%   Extracts element displacements from system displacement vector and
%   transforms them to local coordinates.
% Syntax:
%   ue = uebeam(U,Xe,X3e,Te)
% Input:
%   U   : System displacement vector
%   Xe  : Coordinates of nodes, Xe = [ X1 Y1 Z1 ; X2 Y2 Z2 ]
%   X3e : Coordinates of third nodes, X3e = [ X3 Y3 Z3 ]
%   Te  : Element topology, Te = [ node1 node2 ]
% Output:
%   ue  : Element displacement vector
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Address vector for element dofs
ig = address(Te);

% Element displacement vector in global coordinates
Ue = U(ig);

% Element rotation matrix
Ae = Aebeam(Xe,X3e);

% Element displacement vector in local coordinates
ue = Ae*Ue;