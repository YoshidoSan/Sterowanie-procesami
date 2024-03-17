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
%wyniki symulacji
yzad=yzad(start:Ts+start);
y1 = y(start:Ts+start);
u1=u(start:Ts+start);
figure; stairs(y1); hold on; stairs(yzad,':');
xlim([0 Ts]);
%print("z5d60Y.png","-dpng","-r400")
figure; stairs(u1); hold on; stairs(yzad,':'); title('Sterowanie');
xlim([0 Ts]);
%print("z5d60U.png","-dpng","-r400")
