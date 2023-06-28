function [Fe,H,gam01] = Febeam(Xe,X3e,Ge,pe)
%**************************************************************************
% File: Febeam.m
%   Finds the equivalent nodal forces from uniform distributed loads and
%   puts them in the element load vector. Numerical integration is used.
% Syntax:
%   [Fe,H,gam01] = Febeam(Xe,X3e,Ge,pe)
% Input:
%   Xe    : Coordinates of nodes, Xe = [ X1 Y1 Z1 ; X2 Y2 Z2 ]
%   X3e   : Coordinates of third nodes, X3e = [ X3 Y3 Z3 ]
%   Ge    : Element properties
%   pe    : Distributed loads, pe = [ qx qy qz mx my mz ]
% Output:
%   Fe    : Element load vector
%   H     : Element flexibility matrix
%   gam01 : Midpoint deformation vector
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Element length
Le = norm( Xe(2,:)-Xe(1,:) );

% Gauss quadrature points and weights
[xi,w] = lgwt(Ge.ip,-1,1);

% Initialise element flexibility matrix
H = zeros(8,8);

% Initialise midpoint deformation vectors
gam01 = zeros(8,1);
gam02 = zeros(8,1);

% Loop over integration points
for i = 1:Ge.ip;
           
   % Interpolation matrix (St. Venant moment)
   [T,Ts] = Tbeam(xi(i),Le,Ge);
   
   % Cross-section flexibility matrix
   C = Cbeam(xi(i),Ge);
   
   % Section force vectors from distributed loads
   Q1 = Q1beam(xi(i),Le,pe);
   Q2 = Q1beam(xi(i)-2,Le,pe);
   
   % Element flexibility matrix found by numerical integration
   H = H + Le/2*w(i)*Ts'*C*Ts;
   
   % Midpoint deformation vectors found by numerical integration
   gam01 = gam01 + Le/2*w(i)*Ts'*C*Q1;
   gam02 = gam02 + Le/2*w(i)*Ts'*C*Q2;
   
end

% Interpolation matrix at start and end of element
Tminus = Tbeam(-1,Le,Ge);
Tplus  = Tbeam(1,Le,Ge);
  
% Element load vector in local coordinates
fe = [ -Tminus*H^(-1)*gam01
         Tplus*H^(-1)*gam02  ];

% Element rotation matrix
Ae = Aebeam(Xe,X3e);

% Element load vector in global coordinates
Fe = Ae'*fe;