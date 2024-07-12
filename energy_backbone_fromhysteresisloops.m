% intially each cylce data as to be stored as a matrix c_i_1
% in this case we have 16 cycles and therefore we will have c_1_1 to c_16_1
% energy plotting
% C_1_1 = [];
% C_2_1 = [];
% C_3_1 = [];
% C_4_1 = [];
% C_5_1 = [];
% C_6_1 = [];
% C_7_1 = [];
% C_8_1 = [];
% C_9_1 = [];
% C_10_1 = [];
% C_11_1 = [];
% C_12_1 = [];
% C_13_1 = [];
% C_14_1 = [];
% C_15_1 = [];
% C_16_1 = [];
n = 15; % number of cycles
energy = zeros(n,1); %populate energy of each loop initially
cumenergy =zeros(n+1,1); %populate cumulative energy of each loop initially
for i = 1:n;
    cyclename = sprintf('C_%d_1',i); %initially save as variable name 
    currentcycle = eval(cyclename); % evaluate the variable name
    looparea = polyarea(currentcycle(:,1),currentcycle(:,2)); % find the loop area (energy)
    energy(i,1) = looparea; % energy of each cycle
    cumenergy   = cumsum(energy); % cumulative energy at each cycle
end

%backbone curve generation
FDmax = zeros(16,2); %intialize the FDmax positve side 
FDmin = zeros(16,2); %intialize the FDmin negative side 
for i = 1:n;
    varname = sprintf('C_%d_1',i);
    currentmatrix  = eval(varname);
    FDmax(i,1) = max(currentmatrix(:,1));
    FDmax(i,2) = max(currentmatrix(:,2));
    FDmin(i,1) = min(currentmatrix(:,1));
    FDmin(i,2) = min(currentmatrix(:,2));
end
backbonecurve = [FDmin
                 FDmax];
% hold on 
% plot(FDmax(:,1),FDmax(:,2));
% plot(FDmin(:,1),FDmin(:,2));
% hold off
cycle1 = [];
for i = 1:n;
    cyclename = sprintf('C_%d_1',i);
    current = eval(cyclename);
cycle1 = [cycle1
           current];
end
figure(1)
plot(cycle1(:,1),cycle1(:,2));
figure(2)
hold on
plot(FDmin(:,1),FDmin(:,2),'k');
plot(FDmax(:,1),FDmax(:,2),'k');
hold off
figure(3)
plot(cumenergy(1:n))
