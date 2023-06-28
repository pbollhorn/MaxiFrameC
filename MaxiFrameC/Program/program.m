function [U,R,Uen,Sen] = program(X,X3,T,B,G,P,p,C)
%**************************************************************************
% File: program.m
%   Main function for the frame analysis program MaxiFrameC.
% Syntax:
%   [U,R,Uen,Sen] = program(X,X3,T,B,G,P,p,C)
% Input:
%   X   : Coordinates of nodes
%   X3  : Coordinates of third nodes
%   T   : Element topology
%   B   : Beam topology
%   G   : Beam properties
%   P   : Nodal loads
%   p   : Distributed loads
%   C   : Supports
% Output:
%   U   : Nodal displacements
%   R   : Nodal reactions
%   Uen : Displacements along elements
%   Sen : Section forces along elements
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Plot undeformed structure
figure(1), clf
plotelem(X,T,1);

% Variables describing the system
nn   = size(X,1);    % Number of system nodes
ne   = size(T,1);    % Number of system elements
ndof = nn*7;         % Number of system dofs

% Feed beam properties into elements
G = Gbeam(X,T,B,G);

% Assign distributed loads to all elements
p = pbeam(p,ne);

% System stiffness matrix
K = Kbeam(X,X3,T,B,G,ne,ndof);

% System load vector
F = Fbeam(X,X3,T,B,G,P,p,ne,ndof);

% Solve equation system
[U,R] = solveq(K,F,C,nn,ndof);

% Displacements and section forces along elements
ndat = 11;  % Number of data points
[Uen,Sen] = elemarray(U,X,X3,T,B,G,p,ne,ndat);

% Plot deformed structure
figure(2), clf
plotelemdisp(X,T,Uen)

% Reshape displacements and reactions
U = reshape(U,7,nn)';
R = reshape(R,7,nn)';