[A,B,C,D]=tf2ss([1 4 1.75],[1 15 74 120]);
syms s s0 l1 l2 l3;
%p = [1 1 1];
%l = acker(A',C',p);
sI = s*eye(3);
l = [l1 l2 l3];

row1 = det((sI-A+l'*C));
r1 = coeffs(row1, s);
fow2= (s-s0)^3;
r2 = coeffs(fow2, s);

eqn= r1 == r2;
wynik = solve(eqn, l3,l2,l1);