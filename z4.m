sb=-8;

t=out.simout.time;
u=out.simout.signals.values;
plot(t,u, 'r');

t1=out.simout1.time;
x1=out.simout1.signals.values;
%plot(t1,x1, 'r');
hold on;
grid on;
t2=out.simout2.time;
x2=out.simout2.signals.values;
%plot(t2,x2, 'b');
t3=out.simout3.time;
x3=out.simout3.signals.values;
%plot(t3,x3, 'g');
xlabel('czas');
%ylabel('X');
%legend('wartość x1','wartość x2', 'wartość x3', 'Location','southeast');



ylabel('U');
legend('wartość u','Location','southeast');

print("z4-8u.png","-dpng","-r400")