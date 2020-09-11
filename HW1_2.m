index = 1;
% N must be creater than 2 for the seperation of charges to be less than
% the length of the line
N = 3;
% Ey_ratio will be the output and set to any value bigger than 0.01 to 
% start while loop

% Ey_ratio = abs(1 - Ey_approximate/Ey_exact)
Ey_ratio = 1;
output = ones(1,51);
delta = zeros(1,50);
% While loop will keep checking each N increating each loop to determine
% when the difference between the approximation and exact electric field is
% less than 1%
while(Ey_ratio > 0.01)

%The new limits for the summation are adjusted since N is now increased to
%a higher value (alternating between odd and even)
N_even_limit = N/2 - 1;
N_odd_limit = (N-1)/2;
% resets to the sum to 0 for each iteration of N
sum = 0;
% odd_even determines if N is either odd or even 
odd_even = rem(N,2);
% 2 cases are made to determine which summation to use 
% odd case 
if (odd_even == 1)
   for i = 1:N_odd_limit
       sum = sum + 2/( (1 + (2*i/(N-1))^2)^(3/2) );
   end
   sum = sum + 1;
% even case
else
   for i = 0:N_even_limit
        sum = sum + 2/( ( ((1 + 2*i) / (N-1))^2 +1)^(3/2) );
   end   
end
% depending if N is even or odd, Ey_ratio uses the summation calculated 
% for its appropriate N case  
Ey_ratio = 1-(sqrt(2)/N) * sum;
% take the ratio outputs and record them into an array to show the increase
% in approximation
output(N) = ((sqrt(2)/N) * sum);
delta(N) = 2/(N-1);
index = index + 1;
% N is increased by 1 for the next loop iteration
N = N + 1;
end

% for data, output(1) and output(2) were calculated using the ratio and
% comparing for N = 1,2

output(1) = NaN;
output(2) = NaN;
delta(1) = NaN;
delta(2) = NaN;

N_charges = 1:51;
subplot(2,1,1)
loglog(N_charges, delta)
xlabel('Charges on Line')
ylabel('delta (units of 1/L)')
title('Delta output correlation to number of charges');
subplot(2,1,2)
hold
% Much easier to see convergence behavior using loglog and plotting error
% as defined in problem statement.
loglog(N_charges, 1-output,'.');hold on;
loglog([3,N_charges(end)],[0.02,0.02],'k-')
grid on;
xlabel('# of Charges')
ylabel('E field ratio $\frac{Approximate}{Exact}$','Interpreter','Latex')
title('approximation accuracy');
print -dpdf HW_12.pdf
