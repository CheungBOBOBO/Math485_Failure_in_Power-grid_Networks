%{
Test Functions for rn. 
    power_flow_f looks good. 
    
rn this is scrap to see if I can start figuring this out.
%}
clear all;
import const.*

a = 10;
b = 4;
testCase = 'case14';
h = 0.001; %Step Size

%Graph size
x0=10;
y0=10;
width=550;
height=400;


%read in Index values as paramiters
idx = idxVal;
%Initialize Values 
data = DataClass(testCase);


%Initilize Omega
omega_dot = zeros(1,data.nodes(3));
delta_dot = zeros(1,data.nodes(1));
neu_dot   = zeros(data.nodes(3),data.nodes(3));
neu   = zeros(data.nodes(3),data.nodes(3));
for i = 1:data.nodes(2)
     mi = data.network_data.branch(i,idx.FROM_BUS);
     mj = data.network_data.branch(i,idx.TO_BUS);
     neu(mi,mj) = .98;
end
%Line Removals 
%neu(1,4) = 0.001;
%neu(8,2) = 0.001;
%neu(3,6) = 0;
omega = zeros(1,data.nodes(3));
for i = 1:data.nodes(3)
    if ismember(i,data.gen)
        omega(i)  = 0.001;
    end
end
delta (:) = zeros(1,data.nodes(3));
delta(1)  = 0;

fun = Functions();
set(fun,'data', testCase);
set(fun,'idx', idx);
set(fun,'a', a);
set(fun,'b', b);

neu_1 = [];
neu_2 = [];
neu_3 = [];
neu_4 = [];
neu_5 = [];
neu_6 = [];
neu_7 = [];
neu_8 = [];
neu_9 = [];
neu_10 = [];
neu_12 = [];
neu_13 = [];
neu_14 = [];
neu_15 = [];
neu_16 = [];
neu_17 = [];
neu_18 = [];
neu_19 = [];
neu_20 = [];
neu_21 = [];
omega_plt1 = [];
omega_plt2 = [];
omega_plt3 = [];
omega_plt4 = [];
omega_plt5 = [];
for cnt = h:h:2
ok1 = h.*fun.update_omega(omega, delta);
ok2 = h.*fun.update_omega(omega + ok1./2, delta);
ok3 = h.*fun.update_omega(omega + ok2./2, delta);
ok4 = h.*fun.update_omega(omega + ok3, delta);

dk1 = h.*fun.update_delta(omega, delta, neu);
dk2 = h.*fun.update_delta(omega + dk1./2, delta, neu);
dk3 = h.*fun.update_delta(omega + dk2./2, delta, neu);
dk4 = h.*fun.update_delta(omega + dk3, delta, neu);

nk1 = h.*fun.update_neu( delta, neu);
nk2 = h.*fun.update_neu( delta, neu + nk1./2);
nk3 = h.*fun.update_neu( delta, neu + nk2./2);
nk4 = h.*fun.update_neu( delta, neu + nk3);

omega = omega + (1/6).*(ok1 + 2.*ok2 + 2.*ok3 + ok4);
delta = delta + (1/6).*(dk1 + 2.*dk2 + 2.*dk3 + dk4);
neu   = neu + (1/6).*(nk1 + 2.*nk2 + 2.*nk3 + nk4);

neu_1 = [neu_1 neu(1,2)];
neu_2 = [neu_2 neu(1,5)];
neu_3 = [neu_3 neu(2,3)];
neu_4 = [neu_4 neu(2,4)];
neu_5 = [neu_5 neu(2,5)];
neu_6 = [neu_6 neu(3,4)];
neu_7 = [neu_7 neu(4,5)];
neu_8 = [neu_8 neu(4,7)];
neu_9 = [neu_9 neu(4,9)];
neu_10 = [neu_10 neu(5,6)];
neu_12 = [neu_12 neu(6,11)];
neu_13 = [neu_13 neu(6,12)];
neu_14 = [neu_14 neu(6,13)];
neu_15 = [neu_15 neu(7,8)];
neu_16 = [neu_16 neu(7,9)];
neu_17 = [neu_17 neu(9,10)];
neu_18 = [neu_18 neu(9,14)];
neu_19 = [neu_19 neu(10,11)];
neu_20 = [neu_20 neu(12,13)];
neu_21 = [neu_21 neu(13,14)];
omega_plt1 = [omega_plt1 omega(1)];
omega_plt2 = [omega_plt2 omega(2)];
omega_plt3 = [omega_plt3 omega(3)];
omega_plt4 = [omega_plt4 omega(6)];
omega_plt5 = [omega_plt5 omega(8)];



if cnt >= 0.2
neu(1,2) = 0.01;
neu(2,3) = 0.01; 
%neu(2,4) = 0.01; 
neu(7,8) = 0.01;%fail at 8,2
neu(10,11) = 0.01;
neu(9,14)  = 0.01;
end


%neu
%omega
%delta
%cnt
%pause(0.01)
end 


