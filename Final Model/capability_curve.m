%% Generator per-unit resistance
Xs = 1.81; % + 1.76

figure()

%%Stator current limit curve
x = linspace(-pi/2,pi/2,100);
plot(cos(x),sin(x), 'LineWidth',2, 'DisplayName','Stator current limit curve')
hold on

%%Rotor current limit curve
x = linspace(0,pi,100);
Es = 1.44; % Es = Vt + jXsIa(theta), taking Es as roughly 1.44 of Vt 
rr = (3*Es/Xs);
yp = -3/Xs;
plot( rr*cos(x),  yp + rr*sin(x), 'LineWidth',2, 'DisplayName','Rotor current limit curve')
hold on

Q_max = -3/Xs + (3*Es/Xs);

legend('Location','southwest')

xlabel('Active Power (per-unit)')
ylabel('Reactive Power (per-unit)')
xlim([-0.5,1.5])

%%Retriving power data from logsout
P = out.logsout{3}.Values.Data;
Q = out.logsout{4}.Values.Data;

[s,~] = size(P);
idx = 1:100:s;

P = P(idx); %sampled Ps and Qs
Q = Q(idx);
%colormap = zeros(3,size(idx));
colormap = [];
for i = 1:size(P)
    d1 = sqrt(P(i)^2  + Q(i)^2);
    d2 = sqrt(P(i)^2  + (yp-Q(i))^2);
    if( d1 > 1 || d2 > rr)
        colormap(i) = 1;
    else
        colormap(i) = 0.5;
    end
end

scatter(P,Q,[],colormap,'x','LineWidth', 3, 'DisplayName','Data');

grid on
