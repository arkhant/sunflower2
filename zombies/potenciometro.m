delete(instrfind({'Port'},{'COM10'})); %borramos el puerto
clear cIO;
global cIO;
pot=0;
x=0;
global val_bruto;
    val_bruto=[];
global voltaje5;
    voltaje5=[];
global conver;
    conver=[];
global activacion;
    activacion=[];
    %---------------------- perceptron luz. oscuridad , entrenamiento
    
    %---------------------- perceptron luz. oscuridad , entrenamiento
    
    
try
cIO=arduino('COM10');
cIO.pinMode(14,'INPUT');
% cIO.pinMode(15,'INPUT');

while(true)
%dat = cIO.analogRead(0)*3.3/1023;
% pot = cIO.analogRead(0)*3.3/728;
% pot
disp(['Iteracion no: ',num2str(x)] );
disp('luces!!----------')
val_bruto(end+1) = cIO.analogRead(0);
val_bruto(end)
voltaje5(end+1)=(val_bruto(end)*5.0)/1023;
voltaje5(end)
%dato=(luz/1000)*3;
disp('conversion----------')
conver(end+1)=(val_bruto(end)/2046);
conver(end)
% dato2=hardlims(dato);
%----------------
% if (dato<.5)
%     disp('menor----------')
%     dato=dato*-1;
% end
activacion(end+1)=hardlim(conver(end)); %funcion de activacion 0-1, 0 en 0 <= y 1 0>=1
activacion(end)
%----------------
%     stairs(x,pot, 'k>-','LineWidth',5);
%      stairs(x,luz, 'r>*','LineWidth',5);
% %     %plot(x,dat, 'r.--'); 
%      axis([min(x-10) max(x+10) min(-2) max(4)])
%      grid on;
%      hold on;
x=x+1;
 pause(.5);

end
catch   
     warning('No hay arduino!!');
     return;
end