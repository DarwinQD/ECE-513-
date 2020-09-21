clc
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Darwin Quiroz
% 09/21/2020
% ECE 513
% HW4_2 to check if the function developed in HW4_1 was implemented 
% correctly, this will be tested by computing the magnetic field of a
% n-sided polygon, and as the number of sides increases, eventually we
% reach an approximation for the magnetic field of a circular loop.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculating the Magnetic field of a n sided polygon at the origin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% magnetic field will be calculated at the center
P = [0,0,0];
% current is in magnitude of 10^7 to cancel u0 term
I = 1*10^7;
% Bmag will be the computed overall magnetic field from all differential
% wire segments
Bmag = [];
% XYZ will be created to connect all points or vertices of the polygon, as
% the number of points are increased, the magnetic field will eventually
% reach to that of a circular loop which will hold a magnetic field of 2*pi
XYZ = [];
% magnetic field output will be a vector
B = [];
% the first values of the array are ignored since we need 3 or more points
% to create a closed loop
Bmag = [0,0];
% Setting a limit to the number of sides the last polygon will have
N_lim = 100;
% The loop will find the B-field for each polygon, and increase the sides
% by 1 each iteration up to N_lim
for N = 3:N_lim
    % the points/vertices of the polygon are found by dividing a circle by
    % the number of sides then connecting these points on the outer edge
    % radius of the circle by a line segment
    theta = 0:(2*pi/N):(2*pi);
    % The datapoints are stored into the XYZ matrix where each row is a
    % datapoint
    for i = 1:N
            XYZ(i,:) = [cos(theta(i)), sin(theta(i)), 0];    
    end
    % The total magnetic field is found for each polygon using the function
    B = HW4_BiotSavart(P, XYZ, I);
    % the magnitude of the B field for each polygon is stored into an array
    Bmag(N) = sqrt(sum(B.*B));
end
% number of data points is made into a vector to plot
N_vec = 1:N_lim;
% the B-field is plotted after 3 data points, since a close polygon can not
% be created unless there are at least 3 points given. 
% the magnetic field is computed in terms of pi, because eventually the
% magnetic field will converge to 2*pi, or the magnetic field due to a
% circular loop
plot(N_vec(3:end), Bmag(3:end)/(pi))
xlabel("Data points (N sided polygons)");
ylabel("Magnitude of B-field (in terms of pi)");
title("Magnetic fields for N sided polygons centered at origin");

figure
% the magnetic field of a perfectly circular loop at the same current 
B_ideal = 2*pi;
% the comparison is to show how the Bmag will eventually be the same
% magnitude as that of a circular loop as we increase the number of
% polygon sides or the number of datapoints.
comparison = Bmag/B_ideal;
plot(N_vec(3:end), comparison(3:end))
