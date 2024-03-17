T1=2.2;
T2=4.59;
T0=5;
K0=5.5;
G=tf(K0, [T1*T2 T1+T2 1], 'InputDelay', T0);
Gd=c2d(G, 0.5, 'zoh');

hold on;
grid on;
step(G,'b');
step(Gd,'r');
xlabel('');
ylabel('');
legend('transmitancja ciągła','transmitancja dyskretna', 'Location','southeast');
%print("z1.png","-dpng","-r400")
