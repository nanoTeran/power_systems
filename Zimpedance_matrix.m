%Punto 3. Construcción de Z
z_12 = 0.25j; %Impedancia entre nodo 1 y nodo 2
z_gen = 0.07j+0.14j; % Z física entre generador y nodo

Y = [1/z_12+1/z_gen,-1/z_12;
     -1/z_12,1/z_12+1/z_gen];
Z = inv(Y);

If = 1 / Z(1,1); %Corriente de falla
V1 = 0; % Dado que es un cortocircuito rígido Zf =0 -> V=0
V2 = 1 - Z(1,2)*If;
I_21 = (V2-V1)/z_12;