clc 
clear
close all
Nx = 350;   % place boundary
x = [1:Nx];   % only animates left of boundary
lambda = 100;   %wavelength
figure(1);clf
Niter = 600;   % number of iterations or "time steps" to run simulation
Er = NaN(1,length(x));  % will not animate until Ei reaches boundary

% This is a very nice plot.
% If I do this again, I'd probably ask for an analytic calculation for
% the VSWR curve and a line that shows it.
% This could be done by 
for i = 1:Niter
    Ei = cos(2*pi*(x-i)/lambda);    
    % Set values to right of wave front to NaN so they won't be plotted.
    Ei(i+1:end) = NaN; 
    Er = -1/2*fliplr(Ei);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % what was added to animate the reflected wave
    %%%%%%%%%%%%%%%%%%%%%%%%%%%   
    plot(Er,'r','LineWidth',1,'Color',[1,0,0,0.4]/2);
    hold on 
    E = Ei + Er;
    plot(x,E,'k','LineWidth',1,'Color',[1,1,1,0.4]/2)
    % Plot current time step as light grey.
    plot(Ei,'b','LineWidth',1,'Color',[0,0,1,0.4]/2);
    % Keep past time steps
    hold on;
    grid on;
    if i > 1
        % Delete previous current time step thick black line
        delete(h)
        delete(h2)
        delete(h3)
    
    end
    % Plot current time step as thick black line
    h = plot(E,'k','LineWidth',2);
    h2 = plot(Er,'r','LineWidth',2);
    h3 = plot(Ei,'b','LineWidth',2);
    if i == Niter
        title("Incident and Reflected wave animation");
        xlabel("position x");
        ylabel("amplitude")
        legend('V^{+}(x)','V^{-}(x)','V(x)');
    end
    set(gca,'Ylim',[-2,2]);
    set(gca,'Xlim',[1,Nx]);
    % Uncomment the following to hide past time steps
    %hold off;
%    if mod(i,lambda) == 0
%         % Allow early termination of animation
%         param = input('Continue?');
%     end
    drawnow;
end
