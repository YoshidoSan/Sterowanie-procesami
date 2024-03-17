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
Ts=450; %koniec symulacji
%warunki początkowe
u(1:12)=0; y(1:12)=0;
yzad(1:150)=1; yzad(151:300)=2; yzad(301:Ts)=0;
e(1:12)=0;
for k=13:Ts %główna pętla symulacyjna
%symulacja obiektu
y(k)=b1*u(k-11)+b0*u(k-12)-a1*y(k-1)-a0*y(k-2);
%uchyb regulacji
e(k)=yzad(k)-y(k);
%sygnał sterujący regulatora PID
u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
end
%wyniki symulacji
figure; stairs(y); hold on; stairs(yzad,':');
%print("z2pid.png","-dpng","-r400")