function G = Gbeam(X,T,B,G)
%**************************************************************************
% File: Gbeam.m
%   Rebuilds beam property array into an element property array. I.e. beam
%   properties are fed into elements. Assumes default values for GAey,
%   GAez, EIyz, cy, cz, ay, az and ip if not specified.
% Syntax:
%   G = Gbeam(X,T,B,G)
% Input:
%   X : Coordinates of nodes
%   T : Element topology
%   B : Beam topology
%   G : Beam properties
% Output:
%   G : Element properties
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Loop over beams
for b = 1:size(B,1)
    
    % Property number of beam
    propno = B(b,3);
    
    % Beam length
    Lb = norm( X(B(b,2),:) - X(B(b,1),:) );
    
    % Loop over elements belonging to beam
    for e = find( T(:,3) == b )'
        
        % s-coordinate for start and end of element
        sminus = norm( X(T(e,1),:) - X(B(b,1),:) ) / Lb;
        splus  = norm( X(T(e,2),:) - X(B(b,1),:) ) / Lb;
        
        % Feed EA, EIy, EIz, GK and EIw into element
        Gnew(e).EA  = @(xi)G{propno}.EA ( (1-xi)/2*sminus + (1+xi)/2*splus );
        Gnew(e).EIy = @(xi)G{propno}.EIy( (1-xi)/2*sminus + (1+xi)/2*splus );
        Gnew(e).EIz = @(xi)G{propno}.EIz( (1-xi)/2*sminus + (1+xi)/2*splus );
        Gnew(e).GK  = @(xi)G{propno}.GK ( (1-xi)/2*sminus + (1+xi)/2*splus );
        Gnew(e).EIw = @(xi)G{propno}.EIw( (1-xi)/2*sminus + (1+xi)/2*splus );
        
        % Feed GAey into element. Assume inf if not specified.
        if( isfield(G{propno},'GAey') )
            Gnew(e).GAey = @(xi)G{propno}.GAey( (1-xi)/2*sminus + (1+xi)/2*splus );
        else
            Gnew(e).GAey = @(xi)inf;
        end
        
        % Feed GAez into element. Assume inf if not specified.
        if( isfield(G{propno},'GAez') )
            Gnew(e).GAez = @(xi)G{propno}.GAez( (1-xi)/2*sminus + (1+xi)/2*splus );
        else
            Gnew(e).GAez = @(xi)inf;
        end
        
        % Feed EIyz into element. Assume 0 if not specified.
        if( isfield(G{propno},'EIyz') )
            Gnew(e).EIyz = @(xi)G{propno}.EIyz( (1-xi)/2*sminus + (1+xi)/2*splus );
        else
            Gnew(e).EIyz = @(xi)0;
        end
        
        % Feed cy into element. Assume 0 if not specified.
        if( isfield(G{propno},'cy') )
            Gnew(e).cy   = @(xi)G{propno}.cy  ( (1-xi)/2*sminus + (1+xi)/2*splus );
        else
            Gnew(e).cy   = @(xi)0;
        end
        
        % Feed cz into element. Assume 0 if not specified.
        if( isfield(G{propno},'cz') )
            Gnew(e).cz   = @(xi)G{propno}.cz  ( (1-xi)/2*sminus + (1+xi)/2*splus );
        else
            Gnew(e).cz   = @(xi)0;
        end
        
        % Feed ay into element. Assume 0 if not specified.
        if( isfield(G{propno},'ay') )
            Gnew(e).ay   = @(xi)G{propno}.ay  ( (1-xi)/2*sminus + (1+xi)/2*splus );
        else
            Gnew(e).ay   = @(xi)0;
        end
        
        % Feed az into element. Assume 0 if not specified.
        if( isfield(G{propno},'az') )
            Gnew(e).az   = @(xi)G{propno}.az  ( (1-xi)/2*sminus + (1+xi)/2*splus );
        else
            Gnew(e).az   = @(xi)0;
        end
        
        % Feed ip into element. Assume 5 if not specified.
        if( isfield(G{propno},'ip') )
            Gnew(e).ip = G{propno}.ip;
        else
            Gnew(e).ip = 5;
        end
        
    end
end

% Overwrite old G with new G
G = Gnew;