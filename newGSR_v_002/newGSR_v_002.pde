import processing.serial.*;


//setting up a port
Serial port;

//graph variables
float x,gsrX;
float mapStart = 0;
float mapEnd = 240;
float gMin = 0;
float gMax = 1023;
int xPos = 50;
float preX = 50;
float preY = 290;

void setup(){
  
  //create a serial-port object instance
  port = new Serial(this,Serial.list()[1],19200);
  
  size(1100,650);//creating the basic GUI
  background(0);//setting background color
  
  fill(200);
  rect(50,50,900,250);//creating a rectangle
  
  fill(200);
  rect(50,350,900,250);//creating a rectangle

  //GSR - Grid
  for(int i=1;i<5;i++){
    line(50,50 + (50*i),950,50 + (50*i));
  }
  
  for(int i = 1;i<9;i++){
    line(50+(50*2*i),50,50+(50*2*i),300);
  }
  
  /*Adding a title*/
  textSize(32);
  text("Galvanic Skin Response",50,336);
  
  
  //ECG - Grid
  for(int i=1;i<5;i++){
    line(50,350 + (50*i),950,350 + (50*i));
  }
  
  for(int i = 1;i<9;i++){
    line(50+(50*2*i),350,50+(50*2*i),600);
  }
  
  /*Adding a title*/
  textSize(32);
  text("Electrocardiogram",50,636);
}

void draw(){
 //everything happens here
 serialEvent();
}

void serialEvent(){
  
  //taking the input
  String input = port.readStringUntil('\n');
  
  if(input != null){
    input = trim(input);//removing the whitespace characters
    float[] values = float(split(input,','));
  
    x = values[0];
    
    gsrX = map(x,gMin,gMax,mapStart,mapEnd);//map the values unto our needed range
    
    stroke(255,0,0);
    line(preX,preY,xPos,100+gsrX);//drawing the line
    
    //setting previous values to next iteration
    preX = xPos;
    preY = 100+gsrX;
    
    xPos++;
    
    println(100+gsrX);
  }
  

} 