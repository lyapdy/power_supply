clear;

% R1 = 144.35;%22;
% R2 = 144.35;%22;
L = 10e-4;%11e-4;
C = 55e-6;%61.5e-6;
D = 0.5;
Uin = 300;
f=10e3;
T=1e-6;
time=0.5;

% Lvar = [L - L/5 : 0.1e-3 : L + L/5];
% Cvar = [C - C/6 : 3e-6 : C + C/6];

k=3;
Lrel = 25;
Crel = 25;

Lleft = L*(1-Lrel/100);
Lright = L*(1+Lrel/100);
Lstep = (Lright - Lleft)/k;

Cleft = C*(1-Crel/100);
Cright = C*(1+Crel/100);
Cstep = (Cright - Cleft)/k;

Lrange = [Lleft : Lstep  : Lright];
Crange = [Cleft : Cstep  : Cright];

open power_supply_proposed.slx;
Leqv = [];
Ceqv = [];

for i=1:size(Lrange,2)
%     set_param('lyap_20_09_2023/Gain', 'Gain', '1/Lrange(i)');
    for j=1:size(Crange,2)
        set_param('power_supply_proposed/Series RLC Branch1', 'Inductance', 'Lrange(i)');
        set_param('power_supply_proposed/Series RLC Branch2', 'Capacitance', 'Crange(j)');
        sim('power_supply_proposed');
        U1=ans.U(:,2);
        UC(:,i,j)=U1;
        I1=ans.I(:,2);
        IL(:,i,j)=I1;
        t1=ans.I(:,1);
        deltaUC = max(UC(end*(1-2/f):end*(1-0.5/f),:,:)) - min(UC(end*(1-2/f):end*(1-0.5/f),:,:));
        deltaU = deltaUC(:);
        [dU, idx] = min(deltaU);
        deltaIL = max(IL(end*(1-2/f):end*(1-0.5/f),:,:)) - min(IL(end*(1-2/f):end*(1-0.5/f),:,:));
        deltaI = deltaIL(:);
        [dI, jdx] = min(deltaI);
        Leqv = [Leqv; Lrange(i)];
        Ceqv = [Ceqv; Crange(j)];

        %plot(t1, UC(:,i,j)); hold on;        
    end    
end



n = size(UC, 2);
t = t1(:, ones(1,n), ones(1,n));

for i=1:n
    for j=1:n
      plot(t(:,:,j),UC(:,:,j));
    end  
end

hold on;

for j=1:n
    plot(t(:,:,j),UC(:,:,j));
end

figure;

for j=1:n
    plot(t(:,:,j),UC(:,:,j));
end


[X,Y] = meshgrid(Lrange, Crange);
Z = reshape(deltaUC, [], size(Lrange, 2));
surf(X,Y,Z');

figure;
[X,Y] = meshgrid(Lrange, Crange);
Z = reshape(deltaIL, [], size(Lrange, 2));
surf(X,Y,Z');

