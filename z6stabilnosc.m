Kkryt=1.36;
Tkr=10;

K0=5.5;
T0=5;
T1=2.2;
T2=4.59;
G=tf(K0, [T1*T2 T1+T2 1], 'InputDelay', T0);
Gd=c2d(G, 0.5, 'zoh');
licznik=Gd.Numerator{1,1};
mianownik=Gd.Denominator{1,1};
a1=mianownik(2); 
a0=mianownik(3); 
b1=licznik(2); 
b0=licznik(3);

Ts=1000;
%warunki początkowe
u = zeros(Ts, 1);
y = zeros(Ts, 1);
for k=13:Ts+13+Tkr
    u(k) = 1;
    %symulacja obiektu
    y(k)=b1*u(k-11)+b0*u(k-12)-a1*y(k-1)-a0*y(k-2);
end
model = y(13:Ts+13+Tkr);
clear u y k ;

Kk=0.38;
Tk=20.5;
Kr=0.6*Kk;
Ti=0.5*Tk;
Td=0.12*Tk;
%inicjalizacja
Tp=0.5;
r2=(Kr*Td)/Tp; 
r1=(-Kr)*( 2*Td/Tp - Tp/(2*Ti) + 1); 
r0= Kr*(Td/Tp + Tp/(2*Ti) +1);
%warunki początkowe
u(1:12+Tkr)=0; y(1:12+Tkr)=0;
yzad(1:100)=0; yzad(101:Ts+91+Tkr)=1;e(1:12+Tkr)=0;
for k=13+Tkr:Ts+91+Tkr %główna pętla symulacyjna
%symulacja obiektu
y(k)=Kkryt*b1*u(k-11-Tkr)+Kkryt*b0*u(k-12-Tkr)-a1*y(k-1)-a0*y(k-2);
%uchyb regulacji
e(k)=yzad(k)-y(k);
%sygnał sterujący regulatora PID
u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
end
yPID=y(1:Ts+91+Tkr);
uPID=u(1:Ts+91+Tkr);
clear u y k;



%Definicja horyzontów i parametrów
N = 19;
N_u = 5;
D = 90;
lambda = 60;
start=D+1+Tkr;
%deklaracja potrzebnych wektorów
u = zeros(1,Ts + start);
y = zeros(1,Ts + start);
yzad = zeros(1,Ts + start);
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

M_p = zeros(N, D-1);
for column=1:(D-1)
    for row=1:N
        M_p(row, column) = s(row + column) - s(column);
    end
end
%yzad(1:150)=1; yzad(151:300)=2; yzad(301:Ts+start)=0;
yzad(1:100)=0; yzad(101:Ts+start)=1;
Y_zad = ones(N, 1) * yzad(1);

%inicjalizacja pozostałych potrzebnych macierzy
DU_p = zeros(D-1, 1);

for k=start:Ts+start
    %symulacja obiektu
    y(k)=Kkryt*b1*u(k-11-Tkr)+Kkryt*b0*u(k-12-Tkr)-a1*y(k-1)-a0*y(k-2);
     
    %Obliczenie DU_p
    for d=1:(D-1)
        DU_p(d) = u(k-d) - u(k-d-1);
    end
    
    %Pomiar wyjścia
    Y = ones(N, 1) * y(k);
    
    %Obliczenie Y_0
    Y_0 = M_p * DU_p + Y;

    Y_zad = ones(N, 1) * yzad(k);
    
    %Obliczenie sterowania
    DU = K * (Y_zad - Y_0);
    u(k) = u(k-1) + DU(1);
end
yzad=yzad(1:Ts+start);
yDMC=y(1:Ts+start)';
uDMC=u(1:Ts+start);
%figure; 
%plot(yDMC); 
%hold on; 
%plot(yPID); 
%xlim([0 Ts]);
KoDMC=[1.83 1.85 1.83 1.79 1.74 1.68 1.61 1.55 1.49 1.43 1.36];
KoPID=[1.61 1.54 1.48 1.42 1.37 1.32 1.28 1.23 1.20 1.17 1.13];
To=[1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2];
figure;
plot(To,KoDMC);
hold on; 
plot(To,KoPID);
ylim([0 3]);
legend('DMC','PID');
%print("z6stabilność.png","-dpng","-r400")