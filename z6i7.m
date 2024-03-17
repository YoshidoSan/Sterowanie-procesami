sb=-5;
so=-15;
L1 = - (287708*so)/3465 - (79228*so^2)/3465 - (22628*so^3)/10395 - 1168108/10395;
L2 = (79228*so)/3465 + (22628*so^2)/3465 + (6448*so^3)/10395 + 287708/10395;
L3 = - (22628*so)/3465 - (6448*so^2)/3465 - (1808*so^3)/10395 - 79228/10395;

f1 = figure;
t1=out.simout1.time;
x1=out.simout1.signals.values;
plot(t1,x1, 'r');
hold on;
grid on;
t2=out.simout2.time;
x2=out.simout2.signals.values;
plot(t2,x2, 'b');
xlabel('czas');
ylabel('X');
legend('x1 obiektu','x1 obserwatora','Location','southeast');
%print("z7wolnyx1.png","-dpng","-r400")

f2 = figure;
t3=out.simout3.time;
x3=out.simout3.signals.values;
plot(t3,x3, 'r');
hold on;
grid on;
t4=out.simout4.time;
x4=out.simout4.signals.values;
plot(t4,x4, 'b');
xlabel('czas');
ylabel('X');
legend('x2 obiektu','x2 obserwatora','Location','southeast');
%print("z7wolnyx2.png","-dpng","-r400")

f3 = figure;
t5=out.simout5.time;
x5=out.simout5.signals.values;
plot(t5,x5, 'r');
hold on;
grid on;
t6=out.simout6.time;
x6=out.simout6.signals.values;
plot(t6,x6, 'b');
xlabel('czas');
ylabel('X');
legend('x3 obiektu','x3 obserwatora','Location','southeast');
%print("z7wolnyx3.png","-dpng","-r400")

f4 = figure;
t=out.simout.time;
u=out.simout.signals.values;
plot(t,u, 'r');
hold on;
grid on;
xlabel('czas');
ylabel('U');
legend('u obiektu','Location','southeast');
%print("z7wolnyu.png","-dpng","-r400")
