u1=out.simout.time;
y1=out.simout.signals.values;
plot(u1,y1, 'r');
hold on;
grid on;
u2=out.simout1.time;
y2=out.simout1.signals.values;
plot(u2,y2, 'b');
title('Odpowiedź układu na skok sygnału sterującego');
u3=out.simout2.time;
y3=out.simout2.signals.values;
plot(u3,y3, 'g');
xlabel('czas');
ylabel('y');
legend('model A','model B','transmitation', 'Location','southeast');
%print("z2A.png","-dpng","-r400")