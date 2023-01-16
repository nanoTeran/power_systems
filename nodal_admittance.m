z_l= 0.0012 +0.0035j;
B_c=0.0015j;

% admitancia nodal
yc(1)=B_c/2*(250+300+220);
yc(2)=B_c/2*(220+80);
yc(3)=B_c/2*(80+300+120);
yc(4)=B_c/2*(120+250);
Y11=1/z_l*(1/250+1/300+1/220)+yc(1);
Y22=1/z_l*(1/220+1/80)+yc(2);
Y33=1/z_l*(1/80+1/300+1/123)+yc(3);
Y44=1/z_l*(1/120+1/250)+yc(4);

Y_1=[Y11, -1/z_l*(1/220),-1/z_l*(1/300), -1/z_l*(1/250)];
Y_2=[-1/z_l*(1/220), Y22, -1/z_l*(1/80),0];
Y_3=[-1/z_l*(1/300), -1/z_l*(1/80),Y33, -1/z_l*(1/120)];
Y_4=[-1/z_l*(1/250),0, -1/z_l*(1/120),Y44];

disp("La matriz de admitancia nodal es: ")
Ybarra=[Y_1;Y_2;Y_3;Y_4]

% impedancia nodal
disp("La matriz de impedancia nodal es: ")
Zbarra=inv(Ybarra)

% corrientes netas inyectadas
E_i=[1.02;0.98*exp(j*-4.5*pi/180);1*exp(j*-2*pi/180);0.96*exp(j*-5.8*pi/180)]
disp("El vector de corrientes netas inyectadas es: ")
i_ii=Ybarra*E_i

% Potencias netas inyectadas
   %  S_Ni=P_Ni+j*Q_Ni;
    S_n2=(E_i).*conj(i_ii);
   
   suma=0;
   
  for i=1:4
   for k=1:4
       tetai(k)=angle(Ybarra(i,k)); %teta= angulo de admitancias
       delta(k)=angle(E_i(k));   %delta=angulo de tensión
       
       P_Ni(i)= abs((Ybarra(i,k))*E_i(i)*E_i(k))*cos(tetai(k)-angle(E_i(i))+delta(k)); 

       P_Ni(i)=suma+P_Ni(i);
       suma=P_Ni(i);
    
   end
   
  end
  P_Ni
  
 for i=1:4
   for k=1:4
       tetai(k)=angle(Ybarra(i,k)); %teta= angulo de admitancias
       delta(k)=angle(E_i(k));   %delta=angulo de tensión
       
       Q_Ni(i)= -abs((Ybarra(i,k))*E_i(i)*E_i(k))*sin(tetai(k)-angle(E_i(i))+delta(k)); 

       P_Ni(i)=suma+P_Ni(i);
       suma=Q_Ni(i);
    
   end
   
  end
  disp("las potencias netas inyectadas son: ")
  S_n=P_Ni+Q_Ni*j
  
  %Potencias de transferencia 
  %es lo que un generador le entrega a otro


  for k=1:4
      for m=1:4
  i_s(k,m)=(E_i(k)-E_i(m))*(-Ybarra(k,m));
  St(k,m)=E_i(k)*conj(i_s(k,m));
      end
  end
  disp("Las potencias de transferencia son: ")
  St
    
%   i12=(E_i(1)-E_i(2))*(-Ybarra(1,2)); %otra forma de comprobar
%   S_12=E_i(1)*conj(i12);
%   S_21=E_i(2)*conj(-i12);
  

%corrientes del sistema
disp("Las corrientes del sistema son: ")
i_s
%corrientes a tierra
for i=1:4
i0(i)=E_i(i)*yc(i);
end
disp("Las corrientes a tierra son: ")
i0
%Perdidas del sistema:
%Metodo 1
SL1=transpose(E_i)*conj(i_ii)

%Metodo 2
suma=0;
for i=1:4
    
SL2=suma + S_n2(i);
suma= SL2;
end
SL2

%Metodo 3

suma=0;
for i=1:4
    for k=1:4
SL3=St(k,i)+St(i,k)+suma;
suma=SL3;
    end 
end

% metodo 4
SL4 = 0;
for i=1:4
 SL4 = abs(i0(i))^2/(yc(i)) + SL4;
end
SL4= SL4 + abs(i_s(1,2))^2*Zbarra(1,2)+abs(i_s(1,3))^2*Zbarra(1,3) + 
abs(i_s(2,3))^2*Zbarra(2,3)+ abs(i_s(3,4))^2*Zbarra(3,4);


