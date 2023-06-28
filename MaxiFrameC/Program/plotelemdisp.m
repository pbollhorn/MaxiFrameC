function plotelemdisp(X,T,Uen)
%**************************************************************************
% File: plotelemdisp.m
%   Plots undeformed structure with dashed lines and deformed structure
%   with solid lines. Although Uen is inconsistent with the rest of the
%   program it allows for smooth plots to be made of the deformed
%   structure.
% Syntax:
%   plotelemdisp(X,T,Uen)
% Input:
%   X   : Coordinates of nodes
%   T   : Element topology
%   Uen : Displacements along elements
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Initial geometry
plot3(X(:,1),X(:,2),X(:,3),'k.','markersize',15)
hold on
for j = 1:size(T,1)
    plot3([X(T(j,1),1)
        X(T(j,2),1)],[X(T(j,1),2)
        X(T(j,2),2)],[X(T(j,1),3)
        X(T(j,2),3)],'k--','linewidth',1)
end

% Deformed geometry
ndata = size(Uen,2);
for j = 1:size(T,1)
    X1 = X(T(j,1),:);
    a0 = (X(T(j,2),:)-X(T(j,1),:));
    for k = 1:ndata
        s = (k-1)/(ndata-1);
        Xd(k,:) = X1+a0*s+[Uen(j,k,1) Uen(j,k,2) Uen(j,k,3)];
    end
    plot3(Xd(1:ndata,1),Xd(1:ndata,2),Xd(1:ndata,3),'k-')
end

hold off
axis('equal')
axis('off')