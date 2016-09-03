//serial ports for gsr-ecg
Serial gsrPort;
Serial ecgPort;

//Control Elements
ControlP5 cp5;

Textlabel tl1,tl2,tl3,tl4;
Textlabel er1,er2,er3,er4;
Textfield fn1,fn2;
Button save,browse,refresh,play1,play2,pause1,pause2,stop1,stop2;
CheckBox module;
DropdownList gsrList,ecgList;
int INCC = 0;
//interger to find the mode
int Mode;

//boolean values to find out the modules using
boolean GSR = false;
boolean  ECG = false;
boolean GSRok = false;
boolean ECGok = false;

//Strings to hold port details
String gsrP;
String ecgP;

//boolean value to find out wheteher device is busy
boolean busy;

//opereating systems
boolean Windows = false;
boolean Linux = true;

//min-max
float Min = 0;
float Max = 1023;
float mapStart = 0;
float mapEnd = 200;

//tables
Table onlineTab,offlineTab;

//time Constant
int start = 0;
