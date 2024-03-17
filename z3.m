[A,B,C,D]=tf2ss([1 4 1.75],[1 15 74 120]);
%syms s s0 k1 k2 k3;
%sI = s*eye(3);
%k = [k1 k2 k3];

%sol = det((sI-A+B*k));
%c = coeffs(sol, s);
%sol2= (s-s0)^3;
%d = coeffs(sol2, s);

%eqn= c == d;
%wynik = solve(eqn, k3,k2,k1);

p=[-5 -5 -5];
k = acker(A,B,p);