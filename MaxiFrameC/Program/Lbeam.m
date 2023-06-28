function L = Lbeam(C,nn,ndof)
%**************************************************************************
% File: Lbeam.m
%   Assembles system transformation matrix for offsetting coordinates to
%   support points.
% Syntax:
%   L = Lbeam(C,nn,ndof)
% Input:
%   C    : Supports
%   nn   : Number of system nodes
%   ndof : Number of system dofs
% Output:
%   L    : System transformation matrix
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Initialise system transformation matrix
L = zeros(ndof,ndof);

% Loop over nodes
for n=1:nn
    
    % Nodal transformation matrix
    if( n<=length(C) && isfield(C{n},'offset') && norm(C{n}.offset)>0 )
        
        % Offset to support point
        V = C{n}.offset;
        
        % Nodal transformation matrix if offset specified
        Ln = Lnbeam(V);
        
    else
        
        % Nodal transformation matrix if offset not specified
        Ln = eye(7,7);
        
    end
    
    % Address vector for nodal dofs
    ig = address(n);
    
    % Put nodal transformation matrix in system transformation matrix
    L(ig,ig) = Ln;
    
end