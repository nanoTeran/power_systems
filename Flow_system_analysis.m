%hallar tensiones y perdidas
Y=[3-9j, -2+6j,-1+3j,0;-2+6j,3.666-11j,-0.666+2j,-1+3j;-1+3j,-0.666+2j,3.666-11j, -2+6j;0,-1+3j,-2+6j,3-9j];
error=0.0008;
%potencias inyectadas
Sn2=-1.2-0.8j;
Sn3=-0.8-0.48j;
V1=1.04;
PG4=1.05;
V4mag=1.02;
%nodo1:slack, nodo2=PQ; nodo3=PQ, nodo4=PV
fx=[-1.2;-0.8;-0.8;-0.48]; %-0.8 y -0.48 son Q
Px=[-1.2;-0.8;PG4];
Qx=[-0.8;-0.48];

Bpri=imag([Y(2,2), Y(2,3),Y(2,4);Y(3,2), Y(3,3),Y(3,4);Y(4,2), Y(4,3),Y(4,4)]);
%donde no conozco la tensiÃ³n, van a ser en nodo 2 y 3
B2pri=imag([Y(2,2), Y(2,3);Y(3,2), Y(3,3)]);
Bpriinv=inv(Bpri);
B2priinv=inv(B2pri);
%suponemos
V=[V1;1;1;V4mag];
delta=[0;0;0;0];
%iteraciones
%errores
eV2=1;
eV3=1;
i=1;

for n=1:7
    
%nodo 2 a 4

for i=2:4
suma=0;
for potencia=1:4
    suma = suma + abs(V(i))*abs(V(potencia))*abs(Y(potencia,i))*cos(angle(Y(potencia,i))-angle(V(i))+angle(V(potencia)));
end
Pi(i-1,1) = suma;
end

 %nodo 2 a 3


for i=2:3
suma=0;
for potencia=1:4
    suma = suma - abs(V(i))*abs(V(potencia))*abs(Y(potencia,i))*sin(angle(Y(potencia,i))-angle(V(i))+angle(V(potencia)));
end
Qi(i-1,1) = suma;
end


%Hallar deltaP y deltaQ
deltap =Px-Pi
deltaq =Qx-Qi

%Vectores que almacenan el error de cada iteración
 errorP(n) = max(abs(deltap)); 
 errorQ(n) = max(abs(deltaq));
 errorMax(n) = max([errorP(n),errorQ(n)]);

 deltang=-Bpriinv*[deltap(1,1)/abs(V(2,1));deltap(2,1)/abs(V(3,1));deltap(3,1)/abs(V(4,1))];
 delv=-B2priinv*[deltaq(1,1)/abs(V(2,1));deltaq(2,1)/abs(V(3,1))];

 disp("previos X")
 V
  
 delta2=angle(V(2,1))+deltang(1,1);
 delta3=angle(V(3,1))+deltang(2,1);
 delta4=angle(V(4,1))+deltang(3,1);
 magV2=abs(V(2,1))+delv(1,1);
 magV3=abs(V(3,1))+delv(2,1);
 
V(2,1)=magV2*exp(j*delta2);
V(3,1)=magV3*exp(j*delta3);
V(4,1)=V4mag*exp(j*delta4);

disp("nuevo X")
 V

end

%Cálculo corrientes %NOTA: no se pueden tomar los ultimos valores de V
%porque...se renovaron luego de calculado el error de 0.0007, entonces los
%valores anteriores son los que tienen dicho error y son estos (iteración
%con n= 7 )
Ei = [1.04; 0.8998-0.0792j;0.9351-0.0553j;1.0198+0.0204j];
I = Y*Ei;

%Calculo perdidas+
Perdidas = transpose(Ei)*conj(I)

