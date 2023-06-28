function C = Cbeam(xi,Ge)
%**************************************************************************
% File: Cbeam.m
%   Supplies the cross-section flexibility matrix.
% Syntax:
%   C = Cbeam(xi,Ge)
% Input:
%   xi : Normalised beam coordinate
%   Ge : Element properties
% Output:
%   C  : Cross-section flexibility matrix
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Cross-section parameters
EA   = Ge.EA(xi);
GAey = Ge.GAey(xi);
GAez = Ge.GAez(xi);
EIy  = Ge.EIy(xi);
EIyz = Ge.EIyz(xi);
EIz  = Ge.EIz(xi);
GK   = Ge.GK(xi);
EIw  = Ge.EIw(xi);
cy   = Ge.cy(xi);
cz   = Ge.cz(xi);
ay   = Ge.ay(xi);
az   = Ge.az(xi);

% Cross-section flexibility matrix at cross-section centers
Cline = [
1/EA    0     0     0            0                     0             0
  0  1/GAey   0     0            0                     0             0
  0     0  1/GAez   0            0                     0             0
  0     0     0   1/GK           0                     0             0
  0     0     0     0   EIz/(EIy*EIz-EIyz^2) EIyz/(EIy*EIz-EIyz^2)   0
  0     0     0     0  EIyz/(EIy*EIz-EIyz^2)  EIy/(EIy*EIz-EIyz^2)   0       
  0     0     0     0            0                     0           1/EIw ];

% Translation matrix
J = Jbeam(cy,cz,ay,az);

% Cross-section flexibility matrix at reference axis
C = J'*Cline*J;