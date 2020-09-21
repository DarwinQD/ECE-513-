%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Darwin Quiroz
% 09/21/2020
% ECE 513
% HW4_3 to compute the magnetic flux through a circular loop due to current
% running through it and another one below it. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% with a circle radius of 1, we can imagine a square sheet in the x-y
% plane at z = 2, that perfectly encloses the circular loop, this square
% plane will have a area of 4 that will be dividid into n smaller squares
% the side length of the infintesimal area
radius = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Creating the loops with current
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I = 1;
% loop1 will contain all the datapoints to compute the magnetic field of
% the wire at the z=0 plane
loop1 = [];
% loop2 will contain all the datapoints to compute the B field of the wire
% at the z=2 plane
loop2 = [];
N = 100;
% to simulate a circular loop, we create a N-sided polygons where N is very
% large so that this approximates to a circle
theta = 0:(2*pi/N):2*pi;
% for loop created to compute the points of the circle and store these into
% rows on loop1 and loop2, the only difference being the constant z value
for i = 1:N
    % each datapoint or coordinate is stored in a row, creating N rows or N
    % line segments, when around 100, this approximates to a circular loop
    loop1(i,:) = [radius*cos(theta(i)), radius*sin(theta(i)), 0];
    loop2(i,:) = [radius*cos(theta(i)), radius*sin(theta(i)), 2];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Computing numerically the magnetic Flux 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The flux can be approximated by converting the integral into a sum of the
% flux occuring at differential areas such that sum = sum + dA*B_i

% The BiotSavart function requires a datapoint location to be given and
% this location will be at the center of the differential square, where the
% sum will only account for flux values computed that are within the circle

% this means that if the point location the magnetic field is being
% calculated on has a magntiude greater than radius, we are off the circle

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Creating the grid of differential areas for flux
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = 9;
% the length of the side is to be the same as the diameter
L = 2*radius;
% the length is to be divided into n+1 pieces (i.e. for n=1, 1 slice causes
% 2 dL's and for any n=N, there are N+1 pieces
dL = L/(n+1);
% differential area of the square
dA = dL^2;
% P is a matrix that contains all the datapoints that the magnetic field
% will be calculated through, similar to that of loop1 and loop2 matrix
P = [];
Pz = 2;
% counter is used to know how many squares exist on the grid and will be
% used as the limit index for computing B fields
counter = 0;
for index1 = 1:n
    % first loop is for each row or y level adjustment
    Py = dL/2 + (index1-1)*dL;
    % second loop will account for all x shifts in squares datapoints
    for index2 = 1:n
        % conuter is increased for each datapoint added
        counter = counter + 1;
        % the x coordinate is shifted depending on which square we are on,
        % then we add that from the x coordinate then also add the midpoint
        % dL/2
        Px = dL/2 + (index2-1)*dL;
        % this data point is added with Py and Pz remaining the same 
        P(counter,:) = [Px, Py, Pz];
    % once all points for the y row are found, y increased and done again
    end
end

% The datapoints were calculated with the left-bottom corner being the
% origin, the whole coordinate system must be shifted by the radius so that
% the coordinate systems are the same for the circular loops and the
% datapoints
% x coordinate shifted by L/2
P(:,1) = P(:,1) - L/2;
% x coordinate shifted by L/2
P(:,2) = P(:,2) - L/2;

% The magnetic flux that is to be calculated, only cares about the magnetic
% field coming out of the area in the circle, therefore the sum must only
% account for these values

% if the sqrt(Px^2 + Py^2 datapoint is greater than the radius than we are
% off the circle and will be ignored in the sum
limit = radius;
% the magnetic field for both loops will be calculated at all P values
% generated earlier
Flux = 0;
for k = 1:counter
    % magnetic field computed at each point for both loop
    B1(k,:) = HW4_BiotSavart(P(k,:), loop1, I);
    B2(k,:) = HW4_BiotSavart(P(k,:), loop2, I);
    % after every iteration the total magnetic field is found
    Btot = B1(k,:) + B2(k,:);
    % the limit is checked to see if the datapoint is outside the circles
    % radius by looking at the x and y components magnitude
    if norm([P(k,1),P(k,2)]) > limit
        continue
    else
        % Flux is then computed for those areas within the curve with the
        % dot product between dA and Btot only worrying about the z-axis
        Flux = Flux + dA*Btot(3);
    end
end
% Flux is then displayed to the user
Flux






