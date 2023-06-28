function Q1 = Q1beam(xi,Le,pe)
%**************************************************************************
% File: Q1beam.m
%   Supplies section force vector from uniform distributed loads on a
%   free-fixed beam.
% Syntax:
%   Q1 = Q1beam(xi,Le,pe)
% Input:
%   xi : Normalised beam coordinate
%   Le : Element length
%   pe : Distributed loads = [ qx qy qz mx my mz ]
% Output:
%   Q1 : Section force vector from distributed loads
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Uniform distributed loads
qx = pe(1);
qy = pe(2);
qz = pe(3);
mx = pe(4);
my = pe(5);
mz = pe(6);

% Section force vector from distributed loads
Q1 = [          -qx*(xi+1)*Le/2
                -qy*(xi+1)*Le/2
                -qz*(xi+1)*Le/2
                -mx*(xi+1)*Le/2
       -my*(xi+1)*Le/2 - qz*((xi+1)*Le/2)^2/2
       -mz*(xi+1)*Le/2 + qy*((xi+1)*Le/2)^2/2
                        0                       ]; 