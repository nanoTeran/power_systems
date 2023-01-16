%Punto 1: Despacho económico, demanda de 420 MW
Pdemand =420;

L = (Pdemand+5/0.016+5.5/0.018+4.5/0.014)/(1/0.016+1/0.018+1/0.014);

a1=290; b1 =5; y1=0.008;
a2=270; b2 =5.5; y2=0.009;
a3=300; b3 =4.5; y3=0.007;
min1 = 100; max1=300;
min2 = 200; max2=350;
min3 = 175; max3=400;

%Calculo costo con menor potencia de generación
C1min = a1+   b1*min1+ y1*min1^2; 
C2min = a2+ b2*min2+ y2*min2^2;
C3min = a3+ b2*min3+ y3*min3^2; 

%Cálculo de 2 Generadores 

%---G1 y G2 ---%

L_12=(Pdemand+b1/(2*y1)+b2/(2*y2))/(1/(2*y1)+1/(2*y2));
P1_12 = (L_12-b1)/(2*y1);
P2_12 = (L_12-b2)/(2*y2);

C1_12 = a1+ b1*P1_12+ y1*P1_12^2; 
C2_12 = a2+ b2*P2_12+ y2*P2_12^2;
C_12 = C1_12+C2_12;

%---G1 y G3 ---%

L_13=(Pdemand+b1/(2*y1)+b3/(2*y3))/(1/(2*y1)+1/(2*y3));
P1_13 = (L_13-b1)/(2*y1);
P3_13 = (L_13-b3)/(2*y3);

C1_13 = a1+ b1*P1_13+ y1*P1_13^2; 
C3_13 = a3+ b3*P3_13+ y3*P3_13^2;
C_13 = C1_13+C3_13;

%---G2 y G3 ---%

L_23=(Pdemand+b2/(2*y2)+b3/(2*y3))/(1/(2*y2)+1/(2*y3));
P2_23 = (L_23-b2)/(2*y2);
P3_23 = (L_23-b3)/(2*y3);

C2_23 = a2+ b2*P2_23+ y2*P2_23^2; 
C3_23 = a3+ b3*P3_23+ y3*P3_23^2;
C_23 = C2_23+C3_23;

%----2. Demanda 630 MW-----
Pdemand2 = 630;
L2 = (Pdemand2+b1/(2*y1)+b2/(2*y2)+b3/(2*y3))/(1/(2*y1)+1/(2*y2)+1/(2*y3));
P2_1 = (L2-b1)/(2*y1);
P2_2 = (L2-b2)/(2*y2);
P2_3 = (L2-b3)/(2*y3);

%--iteración 2--
P2_2fix =200;

deltaP2_1 = Pdemand2-(P2_1+P2_2fix+P2_3);
deltaL = deltaP2_1/(1/(2*y1)+1/(2*y3));
L2_2 = L2+ deltaL;

P2_2_1 = (L2_2-b1)/(2*y1);
P2_2_3 = (L2_2-b3)/(2*y3);

C2_2_1 = a1+ b1*P2_2_1+ y1*P2_2_1^2;
C2_2_2 = a2+ b2*P2_2fix+ y2*P2_2fix^2;
C2_2_3 = a3+ b3*P2_2_3+ y3*P2_2_3^2;

%Costo total
C2_2 = C2_2_1+C2_2_2+C2_2_3;



%----2. Demanda 970 MW-----
Pdemand3 = 970;
L3 = (Pdemand3+b1/(2*y1)+b2/(2*y2)+b3/(2*y3))/(1/(2*y1)+1/(2*y2)+1/(2*y3));
P3_1 = (L3-b1)/(2*y1);
P3_2 = (L3-b2)/(2*y2);
P3_3 = (L3-b3)/(2*y3);

%Iteración 2 
P3_1fix =300;

deltaP3 = Pdemand3-(P3_1fix+P3_2+P3_3);
deltaL = deltaP3/(1/(2*y2)+1/(2*y3));
L3_2 = L3+ deltaL;

P3_2_2 = (L3_2-b2)/(2*y2);
P3_2_3 = (L3_2-b3)/(2*y3);

%Iteración 3 
P3_3fix =400;

deltaP3_2 = Pdemand3-(P3_1fix+P3_2_2+P3_3fix);
deltaL2 = deltaP3_2/(1/(2*y2));
L3_3 = L3_2+ deltaL2;

P3_3_2 = (L3_3-b2)/(2*y2);

C3_3_1 = a1+ b1*P3_1fix+ y1*P3_1fix^2;
C3_3_2 = a2+ b2*P3_3_2+ y2*P3_3_2^2;
C3_3_3 = a3+ b3*P3_3fix+ y3*P3_3fix^2;

%Costo total
C3_3 = C3_3_1+C3_3_2+C3_3_3;

Zpos= 0.25j;
Zneg = 0.13j;
Zcero = 0.15j;
Z_tri = 1 /0.25



