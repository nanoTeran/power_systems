%Definiciones iniciales
errorM=0.001;
errorA=0.05*pi/180; % radianes
nodos=3;

%2.2 Matriz Admitancia nodal
Z12 = 0.0015+0.015j;
Z13 = 0.0014+0.014j;
Z23 = 0.0011+0.011j;

Y12 = 1/Z12;
Y13 = 1/Z13;
Y23 = 1/Z23;
Y11 = 1/(Z12+Z13);
Y22 = 1/(Z12+Z13);
Y33 = 1/(Z13+Z23);

Ybarra = [Y11,-Y12, -Y13 ;
          -Y12, Y22,-Y23 ;
          -Y13,-Y23 ,Y33 ];

Zbarra=inv(Ybarra);

%Método Gauss-Seidel
E_i=[1.01;1.03;1];


errorV2=100;
%Nodo 2: PV
conteo=0;

while errorV2 > errorA % Compara el error con la referencia
conteo = conteo +1;
sum=0; sum1=0; sum2=0; V2=0;
k=2;
for n=1:nodos
sum = sum + abs(Ybarra(k,n))*abs(E_i(n))*sin(angle(E_i(k))-angle(E_i(n))-angle(Ybarra(k,n)));
end
Q_2 = abs(E_i(k))*sum ;

n=1;
sum1 = Ybarra(k,n)*E_i(n);
n=k+1;
sum2 = Ybarra(k,n)*E_i(n); 
V2= (1/Ybarra(k,k))*( (1.45-(Q_2*1j)/conj(E_i(2)))-sum1-sum2);

%Comparar el error
dif2 = angle(E_i(2))- angle(V2); 
errorV2 = abs(dif2);
%Asignar nuevo angulo a E_i;
E_i(2) = abs(E_i(2))*exp(1j*angle(V2));
end

%Cambio de Nodo del 2 al 3, que es PQ
k=k+1;
errorV3A=100; errorV3M=100;

conteo2=0;
while (errorV3A > errorA)  && (errorV3M > errorM) % Compara el error con la referencia
conteo2 = conteo2 +1;
sum1 = 0 ; sum2 = 0; V3=0;
n=1;
sum1 = Ybarra(k,n)*E_i(n) + Ybarra(k,n+1)*E_i(n+1);
n=k+1;
%sum2 = Ybarra(k,n)*E_i(n); 
V3= (1/Ybarra(k,k))*( (1.45-(Q_2*1j)/conj(E_i(3)))-sum1-sum2);

%Comparar el error
dif2 = angle(E_i(3))- angle(V3); 
errorV3A = abs(dif2);
errorV3A
dif3 = abs(E_i(3))-abs(V3);
errorV3M = abs(dif3);
errorV3M
%Asignar nuevo angulo a E_i;
E_i(3) = V3;
end







