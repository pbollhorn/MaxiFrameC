function K = Kbeam(X,X3,T,B,G,ne,ndof)
%**************************************************************************
% File: Kbeam.m
%   Assembles system stiffness matrix from element stiffness matrices.
% Syntax:
%   K = Kbeam(X,X3,T,B,G,ne,ndof)
% Input:
%   X    : Coordinates of nodes
%   X3   : Coordinates of third nodes
%   T    : Element topology
%   B    : Beam topology
%   G    : Element properties
%   ne   : Number of system elements
%   ndof : Number of system dofs
% Output:
%   K    : System stiffness matrix
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Initialise system stiffness matrix
K = zeros(ndof,ndof);

% Loop over elements
for e = 1:ne
    
    % Element arrays
    Xe  = X(T(e,1:2),:);
    X3e = X3(B(T(e,3),4),:);
    Te  = T(e,1:2);
    Ge  = G(e);             
    
    % Element stiffness matrix
    Ke = Kebeam(Xe,X3e,Ge);

    % Address vector for element dofs
    ig = address(Te);

    % Add element contributions to system stiffness matrix
    K(ig,ig) = K(ig,ig) + Ke;

end