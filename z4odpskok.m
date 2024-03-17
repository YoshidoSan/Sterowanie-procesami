Ts=150;
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
clear u y k Ts ;
plot(model,'x');
%print("z3odp.png","-dpng","-r400")