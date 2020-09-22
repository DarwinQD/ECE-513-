% Darwin Quiroz
% ECE 321
% 09/08/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Homework 2.2.2 Verifying results from table 1.20 of textbook
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Given values for Phi on the borders
Phi_l = 80;
Phi_r = 20;
Phi_b = 60;
Phi_t = 100;
% Initial values were found as the average of all borders
Phi = [ 65, 65, 65, 65]
% Outer for loop will compute each step completed in the table
for n = 1:10
    % inner for loop computes the step of each potential
    for i = 1:4
        % cases were made to know which are the neighboring borders to the 
        % points was to be used. A brute force method is the simplest to 
        % create since there are only 4 cases but as grid becomes more in 
        % depth an algorithm would be required.
        if i == 1
            top = Phi_t;
            right = Phi(2);
            left = Phi_l;
            bot = Phi(3);
        elseif i ==2
            top = Phi_t;
            right = Phi_r;
            left = Phi(1);
            bot = Phi(4);    
        elseif i ==3
            top = Phi(1);
            right = Phi(4);
            left = Phi_l;
            bot = Phi_b; 
        else
            top = Phi(2);
            right = Phi_r;
            left = Phi(3);
            bot = Phi_b; 
        end
        % Then the potentials numbered 1-4 are computed each loop (once per
        % step.
        Phi(i) = (top+right+left+bot)/4;
    end
    % the step results are then displayed to the user.
    Phi
end