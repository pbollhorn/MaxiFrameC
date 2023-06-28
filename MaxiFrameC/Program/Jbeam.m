function J = Jbeam(cy,cz,ay,az)
%**************************************************************************
% File: Jbeam.m
%   Supplies translation matrix for transforming forces and displacements
%   between the reference axis and the cross-section centers.
% Syntax:
%   J = Jbeam(cy,cz,ay,az)
% Input:
%   cy : y-coordinate of elastic center
%   cz : z-coordinate of elastic center
%   ay : y-coordinate of shear center
%   az : z-coordinate of shear center
% Output:
%   J  : Translation matrix
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Translation matrix
J = [   1    0    0    0   0   0   0  
        0    1    0    0   0   0   0  
        0    0    1    0   0   0   0  
        0    az  -ay   1   0   0   0  
       -cz   0    0    0   1   0   0  
        cy   0    0    0   0   1   0  
        0    0    0    0   0   0   1  ];