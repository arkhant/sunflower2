%subplot(4,2,3), plot(sin(x))
%4= numero de graficas totales
%2 numero de columnas en que se dividira
%3 el numero de grafica en la queva  , tipo matrix

%s tanh, sigmoidal , y de gauss
title('Funciones de activacion : Arturo Barroso');
x= 850:1:1023;
y = gaussmf(x,[-1 1]);
%z = rand >= 0.5;

subplot(5,1,1), plot(tanh(x));
xlabel('Funcion tan h');
   % ylabel('Entrada del sensor')
grid on;   

subplot(5,1,2), plot(tansig(x));
xlabel('Funcion tan sigmoidal hiperbolica');
grid on;   

subplot(5,1,3), plot(logsig(x));
xlabel('Funcion sigmoidal ');
grid on;   

subplot(5,1,4), plot(x,y);
xlabel('Funcion gauss membresia ');
grid on;   

subplot(5,1,5), plot(sign(x),'r');
xlabel('Funcion signo (Segmentacion de señal)');
grid on;   

hold on;