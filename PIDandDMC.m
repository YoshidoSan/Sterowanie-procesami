%PID------------------------------------------------------------------
Kk=0.388;
Tk=20;
Kr=0.6*Kk;
Ti=0.5*Tk;
Td=0.12*Tk;
%inicjalizacja
Tp=0.5;
a1=-1.693; 
a0=0.7145; 
b1=0.06093; 
b0=0.05447;
r2=(Kr*Td)/Tp; 
r1=(-Kr)*( 2*Td/Tp - Tp/(2*Ti) + 1); 
r0= Kr*(Td/Tp + Tp/(2*Ti) +1);
Ts=200; %koniec symulacji
%warunki początkowe
u(1:12)=0; y(1:12)=0;
yzad(1:100)=0; yzad(101:Ts+91)=1;e(1:12)=0;
for k=13:Ts+91 %główna pętla symulacyjna
%symulacja obiektu
y(k)=b1*u(k-11)+b0*u(k-12)-a1*y(k-1)-a0*y(k-2);
%uchyb regulacji
e(k)=yzad(k)-y(k);
%sygnał sterujący regulatora PID
u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
end
yPID = y(91:Ts+91);
uPID=u(91:Ts+91);
clear u y k Ts delay;
%-----------------------------------------------------------------------
%DMC--------------------------------------------------------------------
Ts=200;
a1=-1.693; 
a0=0.7145; 
b1=0.06093; 
b0=0.05447;
%warunki początkowe
u = zeros(Ts, 1);
y = zeros(Ts, 1);
for k=13:Ts+13
    u(k) = 1;
    %symulacja obiektu
    y(k)=b1*u(k-11)+b0*u(k-12)-a1*y(k-1)-a0*y(k-2);
end
model = y(13:Ts+13);
clear u y k Ts delay;
%------------------
Ts=150;
a1=-1.693; 
a0=0.7145; 
b1=0.06093; 
b0=0.05447;
%Definicja horyzontów i parametrów
N = 19;
N_u = 5;
D = 90;
lambda = 60;
start= D+1;
%deklaracja potrzebnych wektorów
u = zeros(Ts + start, 1);
y = zeros(Ts + start, 1);
yzad = zeros(Ts + start, 1);
% z zdania 4
s = model;
%Obliczenie części macierzy DMC
M = zeros(N, N_u);
for column=1:N_u
    for row=1:N
        if row - column + 1 >= 1
            M(row, column) = s(row - column + 1);
        else
            M(row, column) = 0;
        end
    end
end
L = lambda * eye(N_u);
K = (M.' * M + L) \ M.';
Mp = zeros(N, D-1);
for column=1:(D-1)
    for row=1:N
        Mp(row, column) = s(row + column) - s(column);
    end
end
%skok wartości zadanej
%yzad(1:150)=1; yzad(151:300)=2; yzad(301:Ts+start)=0;
yzad(1:100)=0; yzad(101:Ts+start)=1;
Yzad = ones(N, 1) * yzad(1);
dUp = zeros(D-1, 1);
for k=start:Ts+start
    %symulacja obiektu
    y(k)=b1*u(k-11)+b0*u(k-12)-a1*y(k-1)-a0*y(k-2);
    %Obliczenie dUp
    for d=1:(D-1)
        dUp(d) = u(k-d) - u(k-d-1);
    end
    %Pomiar wyjścia
    Y = ones(N, 1) * y(k);
    %Obliczenie Y_0
    Y0 = Mp * dUp + Y;
    Yzad = ones(N, 1) * yzad(k);
    %Obliczenie sterowania
    dU = K * (Yzad - Y0);
    u(k) = u(k-1) + dU(1);
end
yzad=yzad(start:Ts+start);
yDMC = y(start:Ts+start);
uDMC=u(start:Ts+start);
figure; stairs(yDMC); hold on; stairs(yPID); stairs(yzad,':'); legend('DMC','PID'); hold off
xlim([0 Ts]);
%print("z6Y.png","-dpng","-r400")
figure; stairs(uDMC); hold on; stairs(uPID); stairs(yzad,':'); legend('sterowanie DMC','sterowanie PID'); hold off
xlim([0 Ts]);
%print("z6U.png","-dpng","-r400")