% Darwin Quiroz
% 09/01/2020
% ECE 513
% Forward Euler method used.
% NOTE:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Looking back on the assignment, and having better experience doing
% computations, the constants should have been made dimensionless and the
% step distance (dt) should have been a function of Nsteps. along with just
% setting the constants such as charge, epsilon, etc.. to 1 so to not
% influence the graph. and have used the Runga Kutta method over the
% forward Euler. This way would have allowed the E field equation to not be
% influenced by small distances (as a ratio) compared to what was
% developed. These methods mentioned were used when creating and
% implementing question 2 for continuous charge distributions.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clf;

% number of samples that will be taken
Nsteps = 10000;
% differential time/distance taken
dt = 0.01;
% initialization of arrays (used for other variables such as E1 and E2 so
% to analyze data computer during execution
x = nan*ones(1,Nsteps);
y = nan*ones(1,Nsteps);
t = zeros(1,Nsteps);
E_x1 = zeros(1,Nsteps-1);
E_y1 = zeros(1,Nsteps-1);
E_x2 = zeros(1,Nsteps-1);
E_y2 = zeros(1,Nsteps-1);
%position of charges
x_charge1 = -3;
y_charge1 = 0;
x_charge2 = 3;
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
x(1) = x_charge2 + 0.1; % Not used. Can delete.
t(1) = 0;
r1 = zeros(1,Nsteps);
r2 = zeros(1,Nsteps);
%number of field lines to be drawn in total (secondary for loop will use)
Nlines = 20;
fprintf('t\tx\ty\n')
% want N field lines for each charge to be drawn
% outer for loop to draw a new field line from charge at a different angle 
for i_2 = 4:4%(Nlines)
    % a total of N field lines are going to be drawn N/2 for each charge
    % first half will start using location of positive charge
    if i_2 <=(Nlines/2)  
        theta = (2*pi/Nlines)*2*i_2;
        x(1) = x_charge2 + cos(theta);
        y(1) = y_charge2 + sin(theta);
    % second half of loop will use location of negative charge
    else
        % theta starts at 0 from the +x-axis and increments by an evenly
        theta = (2*pi/Nlines)*2*i_2;
        x(1) = x_charge1 + cos(theta);
        y(1) = y_charge1 + sin(theta);
    end
    for i = 1:(Nsteps-1)
        fprintf('%.3f\t%.3f\t%.3f\n',t(i),x(i),y(i));
        % calculates the distance each loop between charges and current
        % position
        r1(i) = (((x(i) - x_charge1)^2 + (y(i) - y_charge1)^2)^(3/2));
        r2(i) = (((x(i) - x_charge2)^2 + (y(i) - y_charge2)^2)^(3/2));
        % E field is then calculated using Coulombs law for both charges
        E_x1(i) = k*q1*(x(i) - x_charge1)/r1(i);
        E_y1(i) = k*q1*(y(i) - y_charge1)/r1(i);
     
        E_x2(i) = k*q2*(x(i) - x_charge2)/r2(i);
        E_y2(i) = k*q2*(y(i) - y_charge2)/r2(i);
        % using Forward Euler method, system becomes unstable when
        % approaching the negative charge (distance between point and
        % charge becomes smaller as one approaches the positive charge and
        % E field becomes extremely large fluctuation position
        % Stop condition
        if r2(i) < 0.5 || r2(i) < 0.5 || abs(x(i)) > 10 || abs(y(i)) > 10
            break;
            % just causes the default value to stay at the charge one near
            x(i+1) = x_charge1;
            y(i+1) = y_charge1;
            t(i+1) = t(i) + dt*t(i);
        else
            % otherwise continues calculation the new position due to the
            % influence of the fields
            x(i+1) = x(i) + dt*(E_x1(i) + E_x2(i));
            y(i+1) = y(i) + dt*(E_y1(i) + E_y2(i));
            t(i+1) = t(i) + dt;
        end
    end  
% once the data for different positional points have been calculated due to
% the E-fields influence, the line is plotted onto the graph for eahc line
plot(x,y);
% hold on so to plot all field lines onto the same graph
hold on;
ax = gca;
% set axis so to show with reference to the origin
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
set(0,'DefaultLegendAutoUpdate','off')
axis square
xlabel('x')
ylabel('y')
title('point charges field lines');
print -dpdf HW_11.pdf
end







