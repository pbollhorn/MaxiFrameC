function Sen = Senbeam(U,Xe,X3e,Te,Ge,pe,ndat)
%**************************************************************************
% File: Senbeam.m
%   Finds section forces along an element. Bimoment is incorrect and 
%   is therefore deleted.
% Syntax:
%   Sen = Senbeam(U,Xe,X3e,Te,Ge,pe,ndat)
% Input:
%   U    : System displacement vector
%   Xe   : Coordinates of nodes, Xe = [ X1 Y1 Z1 ; X2 Y2 Z2 ]
%   X3e  : Coordinates of third nodes, X3e = [ X3 Y3 Z3 ]
%   Te   : Element topology, Te = [ node1 node2 ]
%   Ge   : Element properties
%   pe   : Distributed loads, pe = [ qx qy qz mx my mz ]
%   ndat : Number of data points along element
% Output:
%   Sen  : Section forces along element
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Element length
Le = norm( Xe(2,:)-Xe(1,:) );

% Element displacement vector
ue = uebeam(U,Xe,X3e,Te);

% Element flexibility matrix and midpoint deformation vector
[Fe,H,gam01] = Febeam(Xe,X3e,Ge,pe);

% Interpolation matrix at start and end of element
Tminus = Tbeam(-1,Le,Ge);
Tplus  = Tbeam(1,Le,Ge);

% Loop over data points
for i = 1:ndat
    
    % Normalised beam coordinate
    xi = (2*i-ndat-1)/(ndat-1);
    
    % Interpolation matrix
    T = Tbeam(xi,Le,Ge);
    
    % Section force vector from distributed loads
    Q1 = Q1beam(xi,Le,pe);
    
    % Section forces along element
    Sen(1,i,:) = T*H^(-1)*([-Tminus' Tplus']*ue - gam01) + Q1;
    
end

% Delete incorrect bimoment
Sen = Sen(:,:,1:6);