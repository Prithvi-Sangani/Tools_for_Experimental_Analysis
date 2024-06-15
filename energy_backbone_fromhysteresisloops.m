% intially each cylce data as to be stored as a matrix c_i_1
% in this case we have 16 cycles and therefore we will have c_1_1 to c_16_1
% energy plotting
energy = zeros(16,1); %populate energy of each loop initially
cumenergy =zeros(17,1); %populate cumulative energy of each loop initially
for i = 1:16;
    cyclename = sprintf('c_%d_1',i); %initially save as variable name 
    currentcycle = eval(cyclename); % evaluate the variable name
    looparea = polyarea(currentcycle(:,1),currentcycle(:,2)); % find the loop area (energy)
    energy(i,1) = looparea; % energy of each cycle
    cumenergy   = cumsum(energy); % cumulative energy at each cycle
end

%backbone curve generation
FDmax = zeros(16,2); %intialize the FDmax positve side 
FDmin = zeros(16,2); %intialize the FDmin negative side 
for i = 1:16;
    varname = sprintf('c_%d_1',i);
    currentmatrix  = eval(varname);
    FDmax(i,1) = max(currentmatrix(:,1));
    FDmax(i,2) = max(currentmatrix(:,2));
    FDmin(i,1) = min(currentmatrix(:,1));
    FDmin(i,2) = min(currentmatrix(:,2));
end
% hold on 
% plot(FDmax(:,1),FDmax(:,2));
% plot(FDmin(:,1),FDmin(:,2));
% hold off
cycle1 = [];
for i = 1:16;
    cyclename = sprintf('c_%d_1',i);
    current = eval(cyclename);
cycle1 = [cycle1
           current];
end
plot(cycle1(:,1),cycle1(:,2));