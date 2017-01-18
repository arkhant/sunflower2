function garcia2mat = garcia2mat(velocidad,direccion) %1 izquierda 0 derecha
delete(instrfind({'Port'},{'COM10'})); %borramos el puerto
clear cIO;
global cIO;

global retardo;% Tiempo de retardo en milisegundos (Velocidad del Motor) 2 rapido, 20 lento
%retardo=0.0;
retardo=0;
global dato_rx;           % valor recibido en grados
global numero_pasos;   %Valor en grados donde se encuentra el motor
global leeCadena;      %Almacena la cadena de datos recibida
vel= velocidad
%dir= str2double(direccion)
dir= direccion

%retardo=(vel/10);
retardo=vel;
numero_pasos=0;

%try
cIO=arduino('COM10');
cIO.pinMode(11,'OUTPUT');
cIO.pinMode(10,'OUTPUT');
cIO.pinMode(9,'OUTPUT');
cIO.pinMode(8,'OUTPUT');

while(true)
     pause(retardo);
     % esta parte puede omitirse ya que estamos dando saltos de 1 en uno
     % por el ldr
% leeCadena = input('Ingrese los grados: ') 
%leeCadena=str2num(leeCadena)
%  if length(leeCadena)>0
%     dato_rx = leeCadena
%     pause(retardo);
%      dato_rx = (dato_rx * 1.4222222222); 
%  end
 %--------------------------------------------------- o dejar como visual
 %de los grados que se mueve y ajustar una variable de cambio "se movio
 %tantos grados a izquierda... tantos a derecha
 if dir==1
     disp('izquierda!!----------');
     paso_izq();
     paso_izq();
     paso_izq();
     paso_izq();
     paso_izq();
     numero_pasos = numero_pasos + 1 %utilizar como Y en un plot
 elseif dir==0
     disp('derecha!!----------');
      paso_der();
      paso_der();
      paso_der();
      paso_der();
      paso_der();
        numero_pasos = numero_pasos -1
 end
 apagado();  
 
end
%catch   
%      warning('No hay arduino!!');
%      return;
%end

end

function paso_izq()
global cIO;
global retardo;
disp('izquierda!! mas!----------')
cIO.digitalWrite(11,1) 
 cIO.digitalWrite(10,1)  
 cIO.digitalWrite(9,0)  
 cIO.digitalWrite(8,0)  
  pause(retardo); 
 cIO.digitalWrite(11,0) 
 cIO.digitalWrite(10,1)  
 cIO.digitalWrite(9,1)  
 cIO.digitalWrite(8,0)  
  pause(retardo); 
 cIO.digitalWrite(11,0) 
 cIO.digitalWrite(10,0)  
 cIO.digitalWrite(9,1)  
 cIO.digitalWrite(8,1)  
  pause(retardo); 
 cIO.digitalWrite(11,1) 
 cIO.digitalWrite(10,0)  
 cIO.digitalWrite(9,0)  
 cIO.digitalWrite(8,1)  
  pause(retardo); 
end

function paso_der()
global cIO;
global retardo;
disp('derecha!! mas!----------')
 cIO.digitalWrite(11,0) 
 cIO.digitalWrite(10,0)  
 cIO.digitalWrite(9,1)  
 cIO.digitalWrite(8,1)  
   pause(retardo); 
 cIO.digitalWrite(11,0) 
 cIO.digitalWrite(10,1)  
 cIO.digitalWrite(9,1)  
 cIO.digitalWrite(8,0)  
   pause(retardo); 
 cIO.digitalWrite(11,1) 
 cIO.digitalWrite(10,1)  
 cIO.digitalWrite(9,0)  
 cIO.digitalWrite(8,0)  
  pause(retardo); 
 cIO.digitalWrite(11,1) 
 cIO.digitalWrite(10,0)  
 cIO.digitalWrite(9,0)  
 cIO.digitalWrite(8,1) 
  pause(retardo);  
end

function apagado()
global cIO;
disp('apagado!! mas!----------')
 cIO.digitalWrite(11,0) 
 cIO.digitalWrite(10,0)  
 cIO.digitalWrite(9,0)  
 cIO.digitalWrite(8,0)  
end