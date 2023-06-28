function ig = address(nodes,dofs)
%**************************************************************************
% File: address.m
%   Builds adress vector for a list of nodes for the dofs specified.
%   Assumes all seven dofs if not specified. Does not sort the vector.
% Syntax:
%   ig = address(nodes,dofs)
% Input:
%   nodes : List of nodes
%   dofs  : List of dofs (Default is 1:7)
% Output:
%   ig    : Unsorted adress vector
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Assume all seven dofs if not specified
if( nargin == 1 )
    dofs = 1:7;
end

% Number of nodes
nn = numel(nodes);

% Number of dofs
ndof = numel(dofs);

% Build address vector
for i = 1:nn
    for j = 1:ndof
        ig((i-1)*ndof+j,1) = (nodes(i)-1)*7 + dofs(j);
    end
end