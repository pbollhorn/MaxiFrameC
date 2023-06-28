function p = pbeam(p,ne)
%**************************************************************************
% File: pbeam.m
%   Rebuilds matrix for distributed loads so that all elements have loads
%   assigned. I.e. unloaded elements gets zeros assigned.
% Syntax:
%   p = pbeam(p,ne)
% Input:
%   p  : Distributed loads
%   ne : Number of system elements
% Output:
%   p  : Distributed loads
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Initialise new p
pnew = zeros(ne,6);

% Loop over loaded elements
for i = 1:size(p,1)
    
    % Element number
    e = p(i,1);

    % Insert loads into new p
    pnew(e,:) = p(i,2:7);   
    
end

% Overwrite old p with new p
p = pnew;