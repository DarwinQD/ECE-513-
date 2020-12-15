clc
clear
close all
% Given parameters
w = 5e-3;
V0 = 1;
L = 2;
C = 3;
N = 1000;
Z_L =sqrt(L/C);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculating Zn array
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Zn = NaN(1,N);
Zn(N) = Z_L;
for k = 1:N-1
    if k == (N-1)
        Zn(1) = (Zn(2) + j*w*L);
    else
        Zn(N-k) = ((1/(Zn(N-k+1)+j*w*L)) + j*w*C)^(-1);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculation of V and I arrays
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I = [];
V = [];
t = [0,((2*pi/w)/4)];

for k2 = 1:N
    if k2 == 1
        % initial conditions:
        I(1) = V0/Zn(1);
        V(1) = V0-j*w*L*I(1);
        
    else
        V(k2) = V(k2-1)-j*w*L*I(k2-1);
        I(k2) = I(k2-1)-j*w*C*V(k2);
    end
    V_1(k2) = V(k2).*exp(j*w*t(1));
    V_2(k2)= V(k2).*exp(j*w*t(2));
end
rho = (Z_L-Zn(1))/(Z_L+Zn(1))

n = 1:N;
plot(n, real(V_1))
title("V(t) for Z_L = sqrt(L/C)");
xlabel("N");
ylabel("Voltage (V)");
hold on
plot(n,real(V_2),'r--');
legend("t = 0", "t = (2\pi/\omega)/4")










