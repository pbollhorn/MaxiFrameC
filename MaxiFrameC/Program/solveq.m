function [U,R] = solveq(K,F,C,nn,ndof)
%**************************************************************************
% File: solveq.m
%   Solves equation system in offsetted coordinates in order to introduce
%   constraints from the offsetted supports.
% Syntax:
%   [U,R] = solveq(K,F,C,nn,ndof)
% Input:
%   K    : System stiffness matrix
%   F    : System load vector
%   C    : Supports
%   nn   : Number of system nodes
%   ndof : Number of system dofs
% Output:
%   U    : System displacement vector
%   R    : System reaction vector
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% System transformation matrix
L = Lbeam(C,nn,ndof);

% System stiffness matrix in offsetted coordinates
Ktilde = L'*K*L;

% System load vector in offsetted coordinates
Ftilde = L'*F;

% Initialise system displacement vector in offsetted coordinates
Utilde = zeros(ndof,1);

% Initialise list of constrained dofs
j=[];

% Loop over supported nodes in order to build Utilde(j)
for n = find(~cellfun('isempty',C))
    
    % Address vector for constrained nodal dofs
    ig = address( n , C{n}.dofs(:,1) );
    
    % Prescribed values of constrained nodal dofs
    Utilde(ig) = C{n}.dofs(:,2);
    
    % Add address vector to list of constrained dofs
    j = union( j , ig );

end

% List of free dofs
i = setdiff(1:ndof,j)';

% Solve equation system in offsetted coordinates
Utilde(i) = Ktilde(i,i)\(Ftilde(i)-Ktilde(i,j)*Utilde(j));

% System displacement vector
U = L*Utilde;

% System reaction vector
R = K*U-F;