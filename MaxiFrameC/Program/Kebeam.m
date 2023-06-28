function Ke = Kebeam(Xe,X3e,Ge)
%**************************************************************************
% File: Kebeam.m
%   Builds element stiffness matrix using numerical integration.
% Syntax:
%   Ke = Kebeam(Xe,X3e,Ge)
% Input:
%   Xe  : Coordinates of nodes, Xe = [ X1 Y1 Z1 ; X2 Y2 Z2 ]
%   X3e : Coordinates of third nodes, X3e = [ X3 Y3 Z3 ]
%   Ge  : Element properties
% Output:
%   Ke  : Element stiffness matrix
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Element length
Le = norm( Xe(2,:)-Xe(1,:) );

% Gauss quadrature points and weights
[xi,w] = lgwt(Ge.ip,-1,1);

% Initialise element flexibility matrix
H = zeros(8,8);

% Loop over integration points
for i = 1:Ge.ip
   
   % Interpolation matrix (St. Venant moment)
   [T,Ts] = Tbeam(xi(i),Le,Ge);
   
   % Cross-section flexibility matrix
   C = Cbeam(xi(i),Ge);
      
   % Element flexibility matrix found by numerical integration
   H = H + Le/2*w(i)*Ts'*C*Ts;
    
end

% Interpolation matrix at start and end of element
Tminus = Tbeam(-1,Le,Ge);
Tplus  = Tbeam(1,Le,Ge);

% Element stiffness matrix in local coordinates
ke = [  Tminus*H^(-1)*Tminus'  -Tminus*H^(-1)*Tplus'
       -Tplus *H^(-1)*Tminus'   Tplus *H^(-1)*Tplus' ];
  
% Element rotation matrix
Ae = Aebeam(Xe,X3e);
  
% Element stiffness matrix in global coordinates
Ke = Ae'*ke*Ae;