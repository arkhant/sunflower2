function varargout = sunflower_guide(varargin)
% SUNFLOWER_GUIDE MATLAB code for sunflower_guide.fig
%      SUNFLOWER_GUIDE, by itself, creates a new SUNFLOWER_GUIDE or raises the existing
%      singleton*.
%
%      H = SUNFLOWER_GUIDE returns the handle to a new SUNFLOWER_GUIDE or the handle to
%      the existing singleton*.
%
%      SUNFLOWER_GUIDE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SUNFLOWER_GUIDE.M with the given input arguments.
%
%      SUNFLOWER_GUIDE('Property','Value',...) creates a new SUNFLOWER_GUIDE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sunflower_guide_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sunflower_guide_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sunflower_guide

% Last Modified by GUIDE v2.5 28-Nov-2016 03:56:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sunflower_guide_OpeningFcn, ...
                   'gui_OutputFcn',  @sunflower_guide_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before sunflower_guide is made visible.
function sunflower_guide_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sunflower_guide (see VARARGIN)

% Choose default command line output for sunflower_guide
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sunflower_guide wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global cIO;
global bias;
global bias2;
global put;
put = [[0;0] [0;1] [1;0] [1;1]];
global put2;
put2 = [[0;0] [0;1] [1;0] [1;1]];
global weight;
weight=[0 0];
global weight2;
weight2=[0 0];
global target;
 target = [0 0 0 1];
global target2;
 target2 = [0 0 1 1];
  vtabla=[(put(1,1)) (put(2,1)) (target(1)) ; (put(1,2)) (put(2,2)) (target(2)) ;  (put(1,3)) (put(2,3)) (target(3)) ; (put(1,4)) (put(2,4)) (target(4)) ]
    set(handles.tabla_vel,'Data',vtabla);
  vtabla2=[(put2(1,1)) (put2(2,1)) (target2(1)) ; (put2(1,2)) (put2(2,2)) (target2(2)) ;  (put2(1,3)) (put2(2,3)) (target2(3)) ; (put2(1,4)) (put2(2,4)) (target2(4)) ]
    set(handles.tabla_dir,'Data',vtabla2);

% --- Outputs from this function are returned to the command line.
function varargout = sunflower_guide_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in button_lanzar.
function button_lanzar_Callback(hObject, eventdata, handles)
delete(instrfind({'Port'},{'COM10'})); %borramos el puerto
clear cIO;
global cIO;
global y1; %velocidad s1
global y2; %velocidad s2
global r1; %velocidad ldr1
global r2; %velocidad ldr2

global put
global target
global bias
global weight;
global vA_a_salida;
global vD_a_salida;
global vyerror;
global vybias;
global vyw1;
global vyw2;

global put2
global target2
global bias2
global weight2;
global vA_a_salida2;
global vD_a_salida2;
global vyerror2;
global vybias2;
global vyw12;
global vyw22;

%-------------ldr1
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
%-------------ldr2    
global val_bruto2;
    val_bruto2=[];
global voltaje52;
    voltaje52=[];
global conver2;
    conver2=[];
global activacion2;
    activacion2=[];
global pre_Out2;
    pre_Out2=[];    
      prebias=-300;
      C_fronteraL=-3.12;
      
%-------------motor
global retardo;% Tiempo de retardo en milisegundos (Velocidad del Motor) 2 rapido, 20 lento
%retardo=0.0;
retardo=0;
global dato_rx;           % valor recibido en grados
global numero_pasos;   %Valor en grados donde se encuentra el motor
global leeCadena;      %Almacena la cadena de datos recibida

%------------------motor

try
cIO=arduino('COM10');
cIO.pinMode(2,'INPUT'); %switch 1
cIO.pinMode(3,'INPUT'); %switch 2
cIO.pinMode(14,'INPUT'); %ldr 1
cIO.pinMode(15,'INPUT'); %ldr 2
%------------------motor
cIO.pinMode(11,'OUTPUT');
cIO.pinMode(10,'OUTPUT');
cIO.pinMode(9,'OUTPUT');
cIO.pinMode(8,'OUTPUT');
%------------------motor


while(true)
   y1=cIO.digitalRead(2) %s1
   y2=cIO.digitalRead(3) %s2
   
   %-------------ldr1
val_bruto(end+1) = cIO.analogRead(0);
val_bruto(end)
voltaje5(end+1)=(val_bruto(end)*5.0)/1023;
voltaje5(end)
conver(end+1)=(val_bruto(end)/prebias);
conver(end)
activacion(end+1)=(conver(end)/C_fronteraL)-1;
activacion(end)
pre_Out(end+1)=hardlim(-1*(hardlims(activacion(end)))); %rectificando!!
pre_Out(end)
r1=pre_Out(end);
 %-------------ldr2
val_bruto2(end+1) = cIO.analogRead(1);
val_bruto2(end)
voltaje52(end+1)=(val_bruto2(end)*5.0)/1023;
voltaje52(end)
conver2(end+1)=(val_bruto2(end)/prebias);
conver2(end)
activacion2(end+1)=(conver2(end)/C_fronteraL)-1;
activacion2(end)
pre_Out2(end+1)=hardlim(-1*(hardlims(activacion2(end)))); %rectificando!!
pre_Out2(end)
r2=pre_Out2(end);   
   
   set(handles.txt_switch1,'String',y1);
   set(handles.txt_switch2,'String',y2);
   
   set(handles.txt_ldr1,'String',r1);
   set(handles.txt_ldr2,'String',r2);
   
    ne1=y1;
    ne2=y2;
    
    k1=r1;
    k2=r2;
    
    %velocidades 0 lento 1 rapido
    netabias=(weight(1)*ne1)+(weight(2)*ne2)+bias;
    a_salida=hardlim(netabias) %valores entre -1 y 1
    vD_a_salida(end+1)=a_salida; %salida de comprobacion
    
    %direccion 1 izquierda 0 derecha
    netabias2=(weight2(1)*k1)+(weight2(2)*k2)+bias2;
    a_salida2=hardlim(netabias2) %valores entre -1 y 1
    vD_a_salida2(end+1)=a_salida2; %salida de comprobacion
    
    if a_salida==1
    set(handles.txt_vel,'String','Rapido')
    else
    set(handles.txt_vel,'String','Lento')
    end
    
    if a_salida2==1
    set(handles.txt_dir,'String','Izquierda')
else
    set(handles.txt_dir,'String','Derecha')
    end
%---------------------motor
vel= a_salida
%dir= str2double(direccion)
dir= a_salida2

xvel=0;
xdir=0;

if vel==0 %lento
xvel=.2;
elseif vel==1 %rapido
    xvel=.002;
end
retardo=xvel;

if dir==0 %derecha
    for i=0:1:10
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
    end
elseif dir==1 %izquierda
    for i=0:1:10
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
    end
end
disp('apagado!! mas!----------')
 cIO.digitalWrite(11,0) 
 cIO.digitalWrite(10,0)  
 cIO.digitalWrite(9,0)  
 cIO.digitalWrite(8,0)  
pause(retardo);  
% %retardo=(vel/10);
% retardo=vel;
% numero_pasos=0;


%---------------------motor
   %pause(.5);
end
catch   
     warning('No hay arduino!!');
     return;
end

function txt_bias_Callback(hObject, eventdata, handles)
% hObject    handle to txt_bias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_bias as text
%        str2double(get(hObject,'String')) returns contents of txt_bias as a double


% --- Executes during object creation, after setting all properties.
function txt_bias_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_bias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_w1_Callback(hObject, eventdata, handles)
% hObject    handle to txt_w1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_w1 as text
%        str2double(get(hObject,'String')) returns contents of txt_w1 as a double


% --- Executes during object creation, after setting all properties.
function txt_w1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_w1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_w2_Callback(hObject, eventdata, handles)
% hObject    handle to txt_w2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_w2 as text
%        str2double(get(hObject,'String')) returns contents of txt_w2 as a double


% --- Executes during object creation, after setting all properties.
function txt_w2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_w2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_random.
function button_random_Callback(hObject, eventdata, handles)
bias=2*rand-.5 ;
set(handles.txt_bias,'String',bias);
weight=[3*rand-1 3*rand-1]; %weight=[-0.7, 0.2]%
set(handles.txt_w1,'String',weight(1));
set(handles.txt_w2,'String',weight(2));


% --- Executes on button press in button_limpiar.
function button_limpiar_Callback(hObject, eventdata, handles)
global weight; %errorrr
bias=0;
weight(1)=0;
weight(2)=0;

set(handles.txt_bias,'String','');
set(handles.txt_w1,'String','');
set(handles.txt_w2,'String','');
set(handles.tabla_p_vel,'Data','');

set(handles.txt_bias,'Enable','on');
set(handles.txt_w1,'Enable','on');
set(handles.txt_w2,'Enable','on');

set(handles.button_cal_p_vel,'Enable','on');
set(handles.button_cal_p_vel,'Visible','on');
set(handles.button_random,'Enable','on');
set(handles.button_random,'Visible','on');



% --- Executes on button press in button_cal_p_vel.
function button_cal_p_vel_Callback(hObject, eventdata, handles)
global modo; %awebo debo invocarlo en cada funcion
global weight;
weight=[0 0];
global put;
global target;
global bias;
global error;
%global a_salida;
a_salida=0;
global weight_nuevo;
weight_nuevo=0;
global bias_nuevo;
        bias_nuevo=0;
global ciclo;
       ciclo=0;
 global entradas_aprendidas;
        entradas_aprendidas=0;
        %vA_a_salida={[ ]};
 global vA_a_salida;
        %vA_a_salida = [vA_a_salida, now];
        vA_a_salida = [];
 global vD_a_salida;
        %vD_a_salida=[];
        %vD_a_salida = [vD_a_salida, now];
        vD_a_salida = [];
 %vciclo=[]; %recolector de ciclo o x en linea del tiempo
 global vybias;
        vybias=[];
 global vyw1;
        vyw1=[];
 global vyw2;
        vyw2=[];
 global vywt;
        vywt=[];
 global vyerror; %el vxerror se sobreentiende por la posicion del vector
        vyerror=[];
 global vciclo;
         vciclo=[];
 global x;

set(handles.button_cal_p_vel,'Enable','off');
set(handles.button_cal_p_vel,'Visible','off');
set(handles.button_limpiar,'Visible','on');
set(handles.button_random,'Enable','off');
set(handles.txt_bias,'Enable','off');
set(handles.txt_w1,'Enable','off');
set(handles.txt_w2,'Enable','off');

bias=str2double(get(handles.txt_bias,'String'))
    %w1 = int32(str2double(get(handles.txt_w1,'String')))
    w1 = str2double(get(handles.txt_w1,'String'))
    w2 = str2double(get(handles.txt_w2,'String'))
     weight=[w1 w2]
     disp('-----------Inicio perceptron velocidad-----------')
     
while (entradas_aprendidas<4) 
 entradas_aprendidas=0;
for i=1:length(put)
%weight(1,1)==weight(1) %put(item,grupo); %put(1-2,1-4)
netabias=(weight(1)*put(1,i))+(weight(2)*put(2,i))+bias
a_salida=hardlim(netabias) %arroja valores entre 0 y 1
%a_salida=hardlims(netabias) %valores entre -1 y 1
%vA_a_salida(end+1)=a_salida;
vA_a_salida(end+1)=a_salida;

if(target(i)~=a_salida)
disp(['.-target y salida no coinciden..se procede a aprendizaje ',num2str(i)] );
    error=target(i)-(a_salida)
    vyerror(end+1)=error;
    %put
    %weight
    %   3.3     2.2
    %errorput=error*put([1 2],1)
    %weight_nuevo=weight+errorput'
    weight_nuevo=weight+(error*put([1 2],i))'
    %(error*put([item1 de la columna item2],subgrupo1))'%apostrofe convierte de
    %horizontal a vertical o viceverza un vector. weight es h y put es v.
    bias_nuevo=bias+error    
    weight=weight_nuevo % update para el peso y bias
    vyw1(end+1)=weight(1);
    vyw2(end+1)=weight(2);
    bias=bias_nuevo
    vybias(end+1)=bias;
    else
        entradas_aprendidas=entradas_aprendidas+1
    end   
end
ciclo=ciclo+1
 vciclo(end+1)=ciclo;
 end %bucle total de iteraciones   
 
 vtabla2=table2cell(table(vybias',vyw1',vyw2',vyerror'))
  set(handles.tabla_p_vel,'Data',vtabla2);
 

% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function txt_bias2_Callback(hObject, eventdata, handles)
% hObject    handle to txt_bias2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_bias2 as text
%        str2double(get(hObject,'String')) returns contents of txt_bias2 as a double


% --- Executes during object creation, after setting all properties.
function txt_bias2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_bias2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_w12_Callback(hObject, eventdata, handles)
% hObject    handle to txt_w12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_w12 as text
%        str2double(get(hObject,'String')) returns contents of txt_w12 as a double


% --- Executes during object creation, after setting all properties.
function txt_w12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_w12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_w22_Callback(hObject, eventdata, handles)
% hObject    handle to txt_w22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_w22 as text
%        str2double(get(hObject,'String')) returns contents of txt_w22 as a double


% --- Executes during object creation, after setting all properties.
function txt_w22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_w22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_random2.
function button_random2_Callback(hObject, eventdata, handles)
bias2=2*rand-.5 ;
set(handles.txt_bias2,'String',bias2);
weight2=[3*rand-1 3*rand-1]; %weight=[-0.7, 0.2]%
set(handles.txt_w12,'String',weight2(1));
set(handles.txt_w22,'String',weight2(2));


% --- Executes on button press in button_limpiar2.
function button_limpiar2_Callback(hObject, eventdata, handles)
global weight2; %errorrr
bias2=0;
weight2(1)=0;
weight2(2)=0;

set(handles.txt_bias2,'String','');
set(handles.txt_w12,'String','');
set(handles.txt_w22,'String','');
set(handles.tabla_p_dir,'Data','');

set(handles.txt_bias2,'Enable','on');
set(handles.txt_w12,'Enable','on');
set(handles.txt_w22,'Enable','on');

set(handles.button_cal_p_dir,'Enable','on');
set(handles.button_cal_p_dir,'Visible','on');
set(handles.button_random2,'Enable','on');
set(handles.button_random2,'Visible','on');


% --- Executes on button press in button_cal_p_dir.
function button_cal_p_dir_Callback(hObject, eventdata, handles)
global modo; %awebo debo invocarlo en cada funcion
global weight2;
weight2=[0 0];
global put2;
global target2;
global bias2;
global error2;
%global a_salida;
a_salida2=0;
global weight_nuevo2;
weight_nuevo2=0;
global bias_nuevo2;
        bias_nuevo2=0;
global ciclo2;
       ciclo2=0;
 global entradas_aprendidas2;
        entradas_aprendidas2=0;
        %vA_a_salida={[ ]};
 global vA_a_salida2;
        %vA_a_salida = [vA_a_salida, now];
        vA_a_salida2 = [];
 global vD_a_salida2;
        %vD_a_salida=[];
        %vD_a_salida = [vD_a_salida, now];
        vD_a_salida2 = [];
 %vciclo=[]; %recolector de ciclo o x en linea del tiempo
 global vybias2;
        vybias2=[];
 global vyw12;
        vyw12=[];
 global vyw22;
        vyw22=[];
 global vywt2;
        vywt2=[];
 global vyerror2; %el vxerror se sobreentiende por la posicion del vector
        vyerror2=[];
 global vciclo2;
         vciclo2=[];
 global x2;

set(handles.button_cal_p_dir,'Enable','off');
set(handles.button_cal_p_dir,'Visible','off');
set(handles.button_limpiar2,'Visible','on');
set(handles.button_random2,'Enable','off');
set(handles.txt_bias2,'Enable','off');
set(handles.txt_w12,'Enable','off');
set(handles.txt_w22,'Enable','off');

bias2=str2double(get(handles.txt_bias2,'String'))
    %w1 = int32(str2double(get(handles.txt_w1,'String')))
    w12 = str2double(get(handles.txt_w12,'String'))
    w22 = str2double(get(handles.txt_w22,'String'))
     weight2=[w12 w22]
     disp('-----------Inicio perceptron velocidad-----------')
     
while (entradas_aprendidas2<4) 
 entradas_aprendidas2=0;
for i2=1:length(put2)
netabias2=(weight2(1)*put2(1,i2))+(weight2(2)*put2(2,i2))+bias2
a_salida2=hardlim(netabias2) %arroja valores entre 0 y 1

vA_a_salida2(end+1)=a_salida2;

if(target2(i2)~=a_salida2)
disp(['.-target y salida no coinciden..se procede a aprendizaje ',num2str(i2)] );
    error2=target2(i2)-(a_salida2)
    vyerror2(end+1)=error2;
    weight_nuevo2=weight2+(error2*put2([1 2],i2))'
    %(error*put([item1 de la columna item2],subgrupo1))'%apostrofe convierte de
    %horizontal a vertical o viceverza un vector. weight es h y put es v.
    bias_nuevo2=bias2+error2    
    weight2=weight_nuevo2 % update para el peso y bias
    vyw12(end+1)=weight2(1);
    vyw22(end+1)=weight2(2);
    bias2=bias_nuevo2
    vybias2(end+1)=bias2;
    else
        entradas_aprendidas2=entradas_aprendidas2+1
    end   
end
ciclo2=ciclo2+1
 vciclo2(end+1)=ciclo2;
 end %bucle total de iteraciones   
 
 vtabla22=table2cell(table(vybias2',vyw12',vyw22',vyerror2'))
  set(handles.tabla_p_dir,'Data',vtabla22);
  
  
