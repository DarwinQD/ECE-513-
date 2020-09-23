%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Darwin Quiroz
% 09/21/2020
% ECE 513
% HW4_1 was to create a function that can compute the magnetic field using
% the Biot-Savart formula. The inputs would be the datapoints of a wire
% that are assumed to be connected to one another, the current in the
% closed wire, and finally the point at which the magnetic field is to be
% computed at.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function B = HW4_BiotSavart(P, XYZ, I)
% find the number of points along the wire given
rows = size(XYZ,1);
u0 = 4*pi*10^(-7);
% summation will account for each line segment starting at intial point P_i
% up to P_i+1, where the points are given by each row in XYZ
Arg = [];
for i = 1:rows
    P_1 = XYZ(i,:);
    if i == rows
        P_2 = XYZ(1,:);
    else
        P_2 = XYZ((i+1),:);
    end
    % dL will represent the vector of the differential wire lengths
    dl = P_2 - P_1;
    % Midpoint coordinate of line segment must be found to compute R
    MP = (P_1 + P_2)/2;
    % The R vector is the vector pointing from the midpoint of the wire to
    % the point P
    Rx = P(1) - MP(1);
    Ry = P(2) - MP(2);
    Rz = P(3) - MP(3);
    R = [Rx, Ry, Rz];
    % the magnitude of the R vector is then computed
    Rmag = norm(R);
    % the cross product between dl x R is then computed
    cross_product = cross(dl, R);
    % a new row is appended for each line segment, this will be the
    % argument or the value normally integrated in the Biot-Savart eqn.
    Arg(i,:) = cross_product/(Rmag^3);
end
% Finally the total B field is calculated by multiplying its constants and
% finding the total sum of all the line segments accounted for using the
% sum function from matlab which sums the individual columns, for this case
% all x, y and z components are summed seperately and stored as a vector
B = ((I*u0)/(4*pi))*sum(Arg);%((u0*I)/(4*pi))*sum(Arg);
return
end