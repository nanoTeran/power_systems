%----Datos iniciales----%
Z = j*[0.133,0.083,0.1;
       0.083,0.146,0.125;
       0.1,0.125,0.25];

z13 = 0.31j; %Nueva línea de 1 a 3 
Vf = 1; %Tensión prefalla

%----Cálculo nueva matriz----%
deltaZ = Z(:,1)-Z(:,3);
deltaZt = transpose(deltaZ);
Z44 = z13+Z(1,1)+Z(3,3)-(2*Z(1,3));
Znew = Z - (deltaZ*deltaZt/Z44) ;

%-----a. I de falla en Z original-----%
If_a = Vf/Z(3,3);

%-----b. I de falla en Znew-----%
If_b = Vf/Znew(3,3);

%%-----C. I de aporte generador nodo 1-----%
%--Caso a Z original--%
Y=inv(Z); % Matriz admitancia nodal
Zgen_a = inv(Y(1,1)+Y(1,2)+Y(1,3)); %Cálculo Z del generador 1

V1_a = 1 - Z(1,3)*If_a; %Calculo tensión V1
Igen_a = (1-V1_a)/Zgen_a;

%--Caso b. Z new--%
Ynew=inv(Znew); % Matriz admitancia nodal
Zgen_b = inv(Ynew(1,1)+Ynew(1,2)+Ynew(1,3)); %Cálculo Z del generador 1

V1_b = 1 - Znew(1,3)*If_b; %Calculo tensión V1
Igen_b = (1-V1_b)/Zgen_b;








