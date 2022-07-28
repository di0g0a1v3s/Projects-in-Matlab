s= tf([1 0] , 1 );

e1 = sqrt(10)/2;
e2 = sqrt(10);
e3 = 5*sqrt(10)/4;

w = 5;

G1 = (2*e1*w*s+w*w)/(s*s+2*e1*w*s+w*w);
G2 = (2*e2*w*s+w*w)/(s*s+2*e2*w*s+w*w);
G3 = (2*e3*w*s+w*w)/(s*s+2*e3*w*s+w*w);

figure(101);
hold on;
step( G1);
step( G2);
step( G3);

figure(102);
hold on;
pzmap( G1);
pzmap( G2);
pzmap( G3);

figure(103);
hold on;
bode( G1);
bode( G2);
bode( G3);

[mag, phase] = bode(G1, 1)





