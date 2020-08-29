dt = 0.01;
Nsteps = 10000;
% initialize arrays for how many points to measure
%position of charge
x_charge1 = -1;
y_charge1 = 0;
x_charge2 = 1;
y_charge2 = 0;
% number of points that will be taken

%setting constants used for E-field formula
epsilon = 8.854*10^(-12);
k = 1/(4*pi*epsilon);
% charge values are given
q1 = 1*10^(-9); % charge will be set 1 nC for simplicity
q2 = -1*10^(-9);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2 for loops will be created, each loop will calculate a field line and
% store these values into an array to plot
% splitting positive and negative x values into seperate arrays
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%positive for loop to calculate field lines where x>0
x = zeros(1,Nsteps);
y = zeros(1,Nsteps);

t = zeros(1,Nsteps);
E_x1 = zeros(1,Nsteps-1);
E_y1 = zeros(1,Nsteps-1);
E_x2 = zeros(1,Nsteps-1);
E_y2 = zeros(1,Nsteps-1);
x(1) = x_charge1 + 0.01;
t(1) = 1;
r1 = zeros(1,Nsteps);
r2 = zeros(1,Nsteps);
Nlines = 6;
y(1) = y_charge1 - (Nlines + 1)/10;
fprintf('t\tx\ty\n')
for i_2 = 1:1
    %x(1) = x_charge1 + 0.01;
    y(1) = 0.1
    %y(1) = y(1) + 0.2;
for i = 1:(Nsteps-1)
    fprintf('%.3f\t%.3f\t%.3f\n',t(i),x(i),y(i));

    r1(i) = (((x(i) - x_charge1)^2 + (y(i) - y_charge1)^2)^(3/2));
    r2(i) = (((x(i) - x_charge2)^2 + (y(i) - y_charge2)^2)^(3/2));
    
    E_x1(i) = k*q1*(x(i) - x_charge1)/r1(i);
    E_y1(i) = k*q1*(y(i) - y_charge1)/r1(i);
    
    E_x2(i) = k*q2*(x(i) - x_charge2)/r2(i);
    E_y2(i) = k*q2*(y(i) - y_charge2)/r2(i);
    if (x(i) >= x_charge2*0.96)
        x(i+1) = x_charge2;
        y(i+1) = y_charge2;
        t(i+1) = t(i) + dt*t(i);
    else
        x(i+1) = x(i) + dt*(E_x1(i) + E_x2(i));
        y(i+1) = y(i) + dt*(E_y1(i) + E_y2(i));
        t(i+1) = t(i) + dt*t(i);
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







