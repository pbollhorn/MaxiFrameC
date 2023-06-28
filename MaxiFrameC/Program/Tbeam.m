function [T,Ts] = Tbeam(xi,Le,Ge)
%**************************************************************************
% File: Tbeam.m
%   Supplies interpolation matrices for section force fields. Both a
%   version for the full torsional moment Mx and the St. Venant moment Ms
%   is available.
% Syntax:
%   [T,Ts] = Tbeam(xi,Le,Ge)
% Input:
%   xi : Normalised beam coordinate
%   Le : Element length
%   Ge : Element properties
% Output:
%   T  : Interpolation matrix for section force fields
%   Ts : Interpolation matrix for section force fields (St. Venant moment)
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% The k factor at the middle of the element
k = sqrt(Ge.GK(0)/Ge.EIw(0));

% Four hyperbolic help functions
h1 = 1/2*cosh(xi*k*Le/2)/cosh(k*Le/2);
h2 = 1/2*sinh(xi*k*Le/2)/sinh(k*Le/2);
h3 = k/2*cosh(xi*k*Le/2)/sinh(k*Le/2);
h4 = k/2*sinh(xi*k*Le/2)/cosh(k*Le/2);

% Interpolation matrix for section force fields
T  = [  1      0      0      0      0      0      0      0
        0      1      0      0      0      0      0      0
        0      0      1      0      0      0      0      0
        0      0      0      1      0      0      0      0
        0      0   xi*Le/2   0      1      0      0      0
        0  -xi*Le/2   0      0      0      1      0      0
        0      0      0      0      0      0    h1-h2  h1+h2  ];

% Interpolation matrix for section force fields (St. Venant moment)
Ts = [  1      0      0      0      0      0      0      0
        0      1      0      0      0      0      0      0
        0      0      1      0      0      0      0      0
        0      0      0      1      0      0    h3-h4 -h3-h4
        0      0   xi*Le/2   0      1      0      0      0
        0  -xi*Le/2   0      0      0      1      0      0
        0      0      0      0      0      0    h1-h2  h1+h2  ];