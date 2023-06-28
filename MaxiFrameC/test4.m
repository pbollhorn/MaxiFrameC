% Clear memory
clear all, close all, clc

% Inputs
M  = 10;
l  = 0.76;
h0 = 72.76e-3;
b  = 31.55e-3;
tf = 3.11e-3;
tw = 2.13e-3;
E  = 65.31e9;
Gm = 25.63e9;
ne = [1,2];
alpha=0.1:0.1:1;

% Loop over different number of elements
for i=1:size(ne,2)
    
    % Loop over different values of alpha
    for j=1:size(alpha,2)
    
        % Height of beam as function of s
        h = @(s) h0*(1-s*(1-alpha(j)));

        % Coordinates of nodes: X = [ X Y Z ]
        for n=1:ne(i)+1
            X(n,:)=[ (n-1)/ne(i)*l 0 0 ];
        end

        % Coordinates of third nodes: X3 = [ X Y Z ]
        X3 = [ 0  -1  0 ];

        % Element topology: T = [ node1 node2 beamno ]
        for n=1:ne(i)
            T(n,:)=[ n n+1 1 ];
        end

        % Beam topology: B = [ node1 node2 propno node3 ]
        B = [ 1 ne(i)+1 1 1 ];

        % Beam properties
        G{1}.EA  = @(s) 10;
        G{1}.EIy = @(s) 10;
        G{1}.EIz = @(s) 10;
        G{1}.GK  = @(s) Gm*2/3*b*tf^3;
        G{1}.EIw = @(s) E*1/24*tf*h(s)^2*b^3;
        
        % Nodal loads: P = [ node dof value ]
        P = [ ne(i)+1 4 M ];

        % Supports
        C{1}.dofs = [ 1  0
                      2  0
                      3  0
                      4  0
                      5  0
                      6  0
                      7  0 ];

        % Call MaxiFrameC
        MaxiFrameC

        % Numerical results for twist and warping function at tip
        phi_l_numerical(i,j) = U(ne(i)+1,4);
        theta_l_numerical(i,j) = U(ne(i)+1,7);
    
    end
end


% Plot results for twist at tip
figure
plot(alpha,[M./phi_l_numerical;[31.649 31.946 32.254 32.571 32.895 33.225 33.560 33.900 34.244 34.587];[35.5 33.2 31.8 30.9 30.7 30.8 31.3 32.2 33.4 34.8]],'-o')
xlabel('\alpha [-]')
ylabel('$$M/\varphi(\ell)$$ [Nm]','Interpreter','latex')
legend('1 element','2 elements','Maple','Yau','Location','Best')

% Plot results for warping function at tip
figure
plot(alpha,[M./theta_l_numerical;[-16.324 -16.552 -16.831 -17.135 -17.453 -17.778 -18.106 -18.435 -18.764 -19.089]],'-o')
xlabel('\alpha [-]')
ylabel('$$M/\theta(\ell)$$ [Nm $$\cdot$$ m]','Interpreter','latex')
legend('1 element','2 elements','Maple','Location','Best')