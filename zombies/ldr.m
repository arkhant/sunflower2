delete(instrfind({'Port'},{'COM10'})); %borramos el puerto
clear cIO;
global cIO;
x=0;
global val_bruto;
    val_bruto=[];
global voltaje5;
    voltaje5=[];
global conver;
    conver=[];
global activacion;
    activacion=[];
global pre_Out;
    pre_Out=[];
      prebias=-300;
      C_fronteraL=-3.12;
try
cIO=arduino('COM10');
cIO.pinMode(14,'INPUT');

while(true)
disp(['Iteracion no: ',num2str(x)] );
disp('luces!!----------')
val_bruto(end+1) = cIO.analogRead(0);
val_bruto(end)
voltaje5(end+1)=(val_bruto(end)*5.0)/1023;
voltaje5(end)
disp('conversion----------')
conver(end+1)=(val_bruto(end)/prebias);
conver(end)
activacion(end+1)=(conver(end)/C_fronteraL)-1;
activacion(end)
pre_Out(end+1)=hardlim(-1*(hardlims(activacion(end)))); %rectificando!!
pre_Out(end)


%----------------
     stairs(x,pre_Out(end), 'k>-','LineWidth',5);
%      stairs(x,luz, 'r>*','LineWidth',5);
% %     %plot(x,dat, 'r.--'); 
      axis([min(x-10) max(x+10) min(-2) max(4)])
      grid on;
      hold on;
x=x+1;
 pause(.5);

end
catch   
     warning('No hay arduino!!');
     return;
end