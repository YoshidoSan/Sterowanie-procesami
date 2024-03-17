T1=2.2;
T2=4.59;
T0=5;
K0=5.5;
G=tf(K0, [T1*T2 T1+T2 1], 'InputDelay', T0);
%parametry ciągłego pid
Kk=0.388;
%Ti musi być bardzo dużą liczbą -> nieskończoność
Ti=1e+30;
Td= 0;
PID = tf([0 Kk*Ti Kk],[Ti 0]);
f = feedback(PID*G,1);
figure
step(f);
xlim([0 500]);
%print("z30388.png","-dpng","-r400")