% differential time/distance taken
dt = 0.01;
% number of samples that will be taken
Nsteps = 10000;
% initialization of arrays (used for other variables such as E1 and E2 so
% to analyze data computer during execution
x = zeros(1,Nsteps);
y = zeros(1,Nsteps);
t = zeros(1,Nsteps);
E_x1 = zeros(1,Nsteps-1);
E_y1 = zeros(1,Nsteps-1);
E_x2 = zeros(1,Nsteps-1);
E_y2 = zeros(1,Nsteps-1);
%position of charges
x_charge1 = -5;
y_charge1 = 0;
x_charge2 = 5;
y_charge2 = 0;
%setting constants used for E-field formula
epsilon = 8.854*10^(-12);
k = 1/(4*pi*epsilon);
% charge values are given
q1 = -1*10^(-9); % charges will be set 1 nC for simplicity
q2 = 1*10^(-9);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2 for loops will be created, each loop will calculate a field line and
% store these values into an array to plot
% splitting positive and negative x values into seperate arrays
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initial condition for x created (will be moved within the for loop to
% plot field lines to the left of the negative charge
x(1) = x_charge2 + 0.1;
t(1) = 0;
r1 = zeros(1,Nsteps);
r2 = zeros(1,Nsteps);
%number of field lines secondary for loop will use
Nlines = 20;
%for loop to be created that changes the initial conditions
y(1) = -0.3;
%y(1) = y_charge1 - (Nlines + 1)/10;
fprintf('t\tx\ty\n')
%y(1) = y(5) + 0.2;
for i_2 = 1:(Nlines)
    if i_2 <=(Nlines/2)  
        theta = (2*pi/Nlines)*2*i_2;
        x(1) = x_charge2 + cos(theta);
        y(1) = y_charge2 + sin(theta);
    else
        theta = (2*pi/Nlines)*2*i_2;
        x(1) = x_charge1 + cos(theta);
        y(1) = y_charge1 + sin(theta);
    end
for i = 1:(Nsteps-1)
    fprintf('%.3f\t%.3f\t%.3f\n',t(i),x(i),y(i));
% r vector is calculated for both charges
    r1(i) = (((x(i) - x_charge1)^2 + (y(i) - y_charge1)^2)^(3/2));
    r2(i) = (((x(i) - x_charge2)^2 + (y(i) - y_charge2)^2)^(3/2));
% E field is calculated for both charges 
    E_x1(i) = k*q1*(x(i) - x_charge1)/r1(i);
    E_y1(i) = k*q1*(y(i) - y_charge1)/r1(i);

    E_x2(i) = k*q2*(x(i) - x_charge2)/r2(i);
    E_y2(i) = k*q2*(y(i) - y_charge2)/r2(i);
% when field line has reached the end point (connected to other charge) any points calculated near the -x axis beyond the positive charge give values of 10^5 and grow rapidly
    if (x(i) <= x_charge1*0.98)
        x(i+1) = x_charge1;
        y(i+1) = y_charge1;
        t(i+1) = t(i) + dt*t(i);
    else
    % otherwise the field lines graph well connecting the dipole together but with current sampling methods are limited to having a max distance of 10 to be effective from origin
        x(i+1) = x(i) + dt*(E_x1(i) + E_x2(i));
        y(i+1) = y(i) + dt*(E_y1(i) + E_y2(i));
        t(i+1) = t(i) + dt;
    end
end    
plot(x,y);
hold on;
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
xlabel('x')
ylabel('y')
title('point charge field lines');
end







