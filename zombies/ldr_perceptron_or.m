function ldr_perceptron_or=ldr_perceptron_or(n1,n2)
% 
% global weight;
% weight=[0 0];
% global put;
% global target;
% global bias;
% global error;
% %global a_salida;
% a_salida=0;
% global weight_nuevo;
% weight_nuevo=0;
% global bias_nuevo;
%         bias_nuevo=0;
% global ciclo;
%        ciclo=0;
%  global entradas_aprendidas;
%         entradas_aprendidas=0;
%         %vA_a_salida={[ ]};
%  global vA_a_salida;
%         %vA_a_salida = [vA_a_salida, now];
%         vA_a_salida = [];
%  global vD_a_salida;
%         %vD_a_salida=[];
%         %vD_a_salida = [vD_a_salida, now];
%         vD_a_salida = [];
%         %vciclo=[]; %recolector de ciclo o x en linea del tiempo
%  global vybias;
%         vybias=[];
%  global vyw1;
%         vyw1=[];
%  global vyw2;
%         vyw2=[];
%  global vywt;
%         vywt=[];
%  global vyerror; %el vxerror se sobreentiende por la posicion del vector
%         vyerror=[];
%  global vciclo;
%          vciclo=[];
%  global x;
% global target;
% global put;
% %put = [[1023;850] [1023;850] [850;1023] [850;850]];        
% put = [[0;1] [0;1] [1;0] [1;1]];  
% 
% 
% disp('contruyendo---------------')        
% bias=2*rand-.5;
% bias
% weight=[3*rand-1 3*rand-1];
% weight
% put
% %target = [1023 850 850 850];
% target = [0 1 1 1];
% target
% 
% disp('aprendiendo---------------')  
%  while (entradas_aprendidas<4) 
%  entradas_aprendidas=0;
% for i=1:length(put)
% %weight(1,1)==weight(1) %put(item,grupo); %put(1-2,1-4)
% netabias=(weight(1)*put(1,i))+(weight(2)*put(2,i))+bias
% a_salida=hardlim(netabias) %arroja valores entre 0 y 1
% %a_salida=hardlims(netabias) %valores entre -1 y 1
% %vA_a_salida(end+1)=a_salida;
% vA_a_salida(end+1)=a_salida;
% 
% if(target(i)~=a_salida)
% disp(['.-target y salida no coinciden..se procede a aprendizaje ',num2str(i)] );
%     error=target(i)-(a_salida)
%     vyerror(end+1)=error;
%     %put
%     %weight
%     %   3.3     2.2
%     %errorput=error*put([1 2],1)
%     %weight_nuevo=weight+errorput'
%     weight_nuevo=weight+(error*put([1 2],i))'
%     %(error*put([item1 de la columna item2],subgrupo1))'%apostrofe convierte de
%     %horizontal a vertical o viceverza un vector. weight es h y put es v.
%     bias_nuevo=bias+error    
%     weight=weight_nuevo % update para el peso y bias
%     vyw1(end+1)=weight(1);
%     vyw2(end+1)=weight(2);
%     bias=bias_nuevo
%     vybias(end+1)=bias;
%     else
%         entradas_aprendidas=entradas_aprendidas+1
%     end   
% end
% ciclo=ciclo+1
%  vciclo(end+1)=ciclo;
%  end %bucle total de iteraciones
 
%  disp('inicia comprobacion---------------')  
%     netabias=(weight(1)*ne1)+(weight(2)*ne2)+bias;
%     netabias
%     a_salida=hardlim(netabias) %valores entre -1 y 1
%     a_salida
%     vD_a_salida(end+1)=a_salida; %salida de comprobacion
ne1=n1;
ne2=n2;
 disp('inicia comprobacion---------------')  
    netabias=(1.7174*ne1)+(1.3810*ne2)+(-.8705);
    netabias
    a_salida=hardlim(netabias) %valores entre -1 y 1
    a_salida
    
end