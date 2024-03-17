Ar = [-1 -74 -120 0; 1 0 0 0; 0 1 0 0; -1 -4 -1.75 0];
Br = [1.5; 0; 0; 0];
sb = -2;
p=[sb sb sb sb];
k = acker(Ar,Br,p);
k1= k(1);
k2= k(2);
k3= k(3);
k4= k(4);


f1 = figure;
t1=out.simout1.time;
x1=out.simout1.signals.values;
plot(t1,x1, 'r');
hold on;
grid on;
t2=out.simout2.time;
x2=out.simout2.signals.values;
plot(t2,x2, 'b');
t3=out.simout3.time;
x3=out.simout3.signals.values;
plot(t3,x3, 'g');
xlabel('czas');
ylabel('X');
legend('x1','x2','x3','Location','southeast');
print("dodwolnyxB.png","-dpng","-r400")

f2 = figure;
t5=out.simout5.time;
yz=out.simout5.signals.values;
hold on;
grid on;
plot(t5,yz, 'r');
xlabel('czas');
ylabel('Yzad');
print("dodwolnyyzB.png","-dpng","-r400")

f3 = figure;
t4=out.simout4.time;
y=out.simout4.signals.values;
hold on;
grid on;
plot(t4,y, 'r');
xlabel('czas');
ylabel('Y');
print("dodwolnyyB.png","-dpng","-r400")

f4 = figure;
t=out.simout.time;
u=out.simout.signals.values;
hold on;
grid on;
plot(t,u, 'r');
xlabel('czas');
ylabel('U');
print("dodwolnyuB.png","-dpng","-r400")

