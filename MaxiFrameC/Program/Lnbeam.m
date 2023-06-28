function Ln = Lnbeam(V)
%**************************************************************************
% File: Lnbeam.m
%   Builds nodal transformation matrix for offsetting coordinates to
%   the support point.
% Syntax:
%   Ln = Lnbeam(V)
% Input:
%   V  : Offset to support point, V = [ DeltaX DeltaY DeltaZ ]
% Output:
%   Ln : Nodal transformation matrix
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Unit vector in y-direction
Vy = V/norm(V);

% Unit vector in x-direction
if( abs(V(1)) <= abs(V(2))  &  abs(V(1)) <= abs(V(3)) )
    Vx = [ 0 -V(3) V(2) ]/norm([ 0 -V(3) V(2) ]);
elseif( abs(V(2)) <= abs(V(1))  &  abs(V(2)) <= abs(V(3)) )
    Vx = [ -V(3) 0 V(1) ]/norm([ -V(3) 0 V(1) ]);
else
    Vx = [ -V(2) V(1) 0 ]/norm([ -V(2) V(1) 0 ]);
end

% Unit vector in z-direction
Vz = cross(Vx,Vy);

% Nodal rotation matrix
An = [   Vx     0  0  0  0
         Vy     0  0  0  0
         Vz     0  0  0  0
       0  0  0     Vx    0
       0  0  0     Vy    0
       0  0  0     Vz    0
       0  0  0  0  0  0  1  ];

% y- and z-coordinate for support point
by = dot(V,Vy);
bz = 0;

% Translation matrix
J = Jbeam(by,bz,by,bz);

% Nodal transformation matrix
Ln = An^(-1)*J'*An;