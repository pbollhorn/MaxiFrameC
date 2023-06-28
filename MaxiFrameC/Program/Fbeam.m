function F = Fbeam(X,X3,T,B,G,P,p,ne,ndof)
%**************************************************************************
% File: Fbeam.m
%   Assembles system load vector from nodal loads and element load vectors.
% Syntax:
%   F = Fbeam(X,X3,T,B,G,P,p,ne,ndof)
% Input:
%   X    : Coordinates of nodes
%   X3   : Coordinates of third nodes
%   T    : Element topology
%   B    : Beam topology
%   G    : Element properties
%   P    : Nodal loads
%   p    : Distributed loads
%   ne   : Number of system elements
%   ndof : Number of system dofs
% Output:
%   F    : System load vector
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Initialise system load vector
F = zeros(ndof,1);

% Loop over nodal loads
for i = 1:size(P,1)
    
    % Address of loaded dof
    ig = address( P(i,1) , P(i,2) );
    
    % Add nodal load to system load vector
    F(ig) = P(i,3);
    
end

% Loop over elements
for e = 1:ne
    
    % Element arrays
    Xe  = X(T(e,1:2),:);
    X3e = X3(B(T(e,3),4),:);
    Te  = T(e,1:2);
    Ge  = G(e);
    pe  = p(e,:);
    
    % Element load vector
    Fe = Febeam(Xe,X3e,Ge,pe);
    
    % Address vector for element dofs
    ig = address(Te);

    % Add element load to system load vector
    F(ig) = F(ig) + Fe;
    
end