function Uen = Uenbeam(U,Xe,X3e,Te,ndat)
%**************************************************************************
% File: Uenbeam.m
%   Finds displacements along an element. Rotations and warping
%   function are not found. Results are only consistent with the rest
%   of the program for the case of prismatic beams without shear
%   flexibility and distributed loads.
% Syntax:
%   Uen = Uenbeam(U,Xe,X3e,Te,ndat)
% Input:
%   U    : System displacement vector
%   Xe   : Coordinates of nodes, Xe = [ X1 Y1 Z1 ; X2 Y2 Z2 ]
%   X3e  : Coordinates of third nodes, X3e = [ X3 Y3 Z3 ]
%   Te   : Element topology, Te = [ node1 node2 ]
%   ndat : Number of data points along element
% Output:
%   Uen  : Displacements along element
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Element length
Le = norm( Xe(2,:)-Xe(1,:) );

% Element displacement vector
ue = uebeam(U,Xe,X3e,Te);

% Rotation matrix for 3D vectors
[Ae,A] = Aebeam(Xe,X3e);

% Loop over data points
for i = 1:ndat
    
    % Normalised beam coordinate
    xi = (2*i-ndat-1)/(ndat-1);
    
    % Displacement fields
    N1 =  1/2*( -xi + 1 );
    N2 =  1/2*(  xi + 1 );
    N3 =  1/4*(  xi^3 - 3*xi + 2 );
    N4 = Le/8*(  xi^3 - xi^2 - xi + 1  );
    N5 =  1/4*( -xi^3 + 3*xi + 2 );
    N6 = Le/8*(  xi^3 + xi^2 - xi - 1 );

    % Interpolation matrix for displacement fields
    N = [ N1  0   0   0   0   0   0   N2  0   0   0   0   0   0
          0   N3  0   0   0   N4  0   0   N5  0   0   0   N6  0
          0   0   N3  0  -N4  0   0   0   0   N5  0  -N6  0   0  ];
    
    % Displacements along element
    Uen(1,i,:) = A^(-1)*N*ue;
    
end