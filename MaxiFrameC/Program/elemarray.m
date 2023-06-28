function [Uen,Sen] = elemarray(U,X,X3,T,B,G,p,ne,ndat)
%**************************************************************************
% File: elemarray.m
%   Builds arrays with displacements and section forces from all elements.
% Syntax:
%   [Uen,Sen] = elemarray(U,X,X3,T,B,G,p,ne,ndat)
% Input:
%   U    : System displacement vector
%   X    : Coordinates of nodes
%   X3   : Coordinates of third nodes
%   T    : Element topology
%   B    : Beam topology
%   G    : Element properties
%   p    : Distributed loads
%   ne   : Number of system elements
%   ndat : Number of data points along elements
% Output:
%   Uen  : Displacements along elements
%   Sen  : Section forces along elements
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Loop over elements
for e = 1:ne

    % Element arrays
    Xe  = X(T(e,1:2),:);
    X3e = X3(B(T(e,3),4),:);
    Te  = T(e,1:2);
    Ge  = G(e);
    pe  = p(e,:);
    
    % Put displacements along element in an array for all elements
    Uen(e,:,:) = Uenbeam(U,Xe,X3e,Te,ndat);
    
    % Put section forces along element in an array for all elements
    Sen(e,:,:) = Senbeam(U,Xe,X3e,Te,Ge,pe,ndat);
    
end