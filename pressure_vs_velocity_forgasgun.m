clc
clear all
% Constants
gamma_diatomic = 1.4; % Adiabatic index for air, Oxygen
gamma_monoatomic = 1.66; % Adiabatic index for like helium
mu = 0.35; %coefficient of friction

% Parameters
P0_array = linspace(0.5e5, 10e5, 20); % Initial pressures from 1 bar to 10 bars in pascals (Pa)
% P0_array = 400000;
V0 = 0.1; % Initial volume of gas in cubic meters (m^3)
d_barrel = 140e-3; % Inner diameter of barrel in meters (m)
A = pi * (d_barrel / 2)^2; % Cross-sectional area of barrel in square meters (m^2)
m = 26.5; % Mass of the projectile in kilograms (kg)
barrel_length = 6; % Length of the barrel in meters (m)
dx = 0.1; % Step size for position
l_p = 0.0; %length of the projectile (m)

% Function to calculate the pressure at a given position for a given gas
pressure = @(P0, x, gamma) P0 * (V0 / (V0 + A * x)).^gamma;
% friction force calculations
F_fric = mu * m * 9.81; %in N

% Initialize arrays to store final velocities
final_velocity_diatomic = zeros(size(P0_array));
final_velocity_monoatomic = zeros(size(P0_array));

for j = 1:length(P0_array)
    P0 = P0_array(j);
    
    % Diatomic (Air)
    gamma = gamma_diatomic;
    x = 0:dx:barrel_length-l_p/2; % Position array
    v_diatomic = zeros(size(x)); % Velocity array for air
    f = zeros(size(x)); %force
    
    for i = 1:length(x)
if x(i) == 0
    P = P0;
else
        P = pressure(P0, x(i-1), gamma); % Pressure at previous position
end
        f(i) = (P *A - F_fric); %force matrix
        
        % Acceleration (a = F/m)
        a = (f(i)) / m;
        
        % Calculate time step dt based on current velocity
        if v_diatomic(i) > 0
            dt = dx / v_diatomic(i);
        else
            dt = dx/sqrt(2*a*dx);
        end
        
        % Update velocity using v = u + a*dt
        v_diatomic(i+1) = v_diatomic(i) + a * dt;
    end
    
    final_velocity_diatomic(j) = v_diatomic(end); % Store final velocity for air
    
    % Monoatomic (Helium)
    gamma = gamma_monoatomic;
    v_monoatomic = zeros(size(x)); % Velocity array for helium
    
    for i = 1:length(x)
       if x(i) == 0
           P = P0;
       else
        P = pressure(P0, x(i-1), gamma); % Pressure at previous position
       end

        % Acceleration (a = F/m)
        a = (P * A- F_fric) / m;
        
        % Calculate time step dt based on current velocity
        if v_monoatomic(i) > 0
            dt = dx / v_monoatomic(i);
        else
            dt = dx/sqrt(2*a*dx);
        end
        
        % Update velocity using v = u + a*dt
        v_monoatomic(i+1) = v_monoatomic(i) + a * dt;
    end
    
    final_velocity_monoatomic(j) = v_monoatomic(end); % Store final velocity for helium
end

% Plot results
figure(1);
plot(P0_array / 1e5, final_velocity_diatomic, '-o', 'DisplayName', 'Air');
hold on;
plot(P0_array / 1e5, final_velocity_monoatomic, '-x', 'DisplayName', 'Helium');
xlabel('Initial pressure (bar)');
ylabel('Velocity at the end of the barrel (m/s)');
title_str = sprintf('Length of Barrel (m) = %d', barrel_length);
title(title_str);
legend show;
legend Box off;
legend Location southeast;
grid on;
hold off;
figure(2);
plot(x, f, '--');
% plot(P0_array / 1e5, final_velocity_monoatomic, '-x', 'DisplayName', 'Helium');
xlabel('Length, x (m)');
ylabel('Force (N)');
title_str = sprintf('Force along the length');
title(title_str);
grid on;
figure(3);
plot(x, v_diatomic(1:length(x)), 'k--', 'DisplayName', 'Air');
hold on;
plot(x, v_monoatomic(1:length(x)), 'r-', 'DisplayName', 'Helium');
xlabel('Length, x (m)');
ylabel('Velocity (m/s)');
title_str = sprintf('Velocity along the length');
title(title_str);
legend show;
legend Box off;
legend Location southeast;
grid on;
hold off;
figure(4);
plot(x, f/(9.81*m), '--');
% plot(P0_array / 1e5, final_velocity_monoatomic, '-x', 'DisplayName', 'Helium');
xlabel('Length, x (m)');
ylabel('acceleration (m/s^2)');
title_str = sprintf('Acceleration along the length');
title(title_str);
grid on;