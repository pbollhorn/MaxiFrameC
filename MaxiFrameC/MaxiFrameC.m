%**************************************************************************
% File: MaxiFrameC.m
%   Script for starting the program in an user friendly way. The user
%   simply has to write 'MaxiFrameC' in the in-data file.
% Date:
%   Version 1.0    27.07.12
%**************************************************************************

% Add path of program folder
addpath([fileparts(mfilename('fullpath')) '/Program'])

% Use dummy value for nodal loads if not specified
if ~exist('P','var')
    P = [ 1 1 0 ];
end

% Use dummy value for distributed loads if not specified
if ~exist('p','var')
    p = [ 1 0 0 0 0 0 0 ];
end

% Run the program through a function for safety
[U,R,Uen,Sen] = program(X,X3,T,B,G,P,p,C);