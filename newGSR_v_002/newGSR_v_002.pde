import processing.serial.*;


//setting up a port
Serial port;

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
}

void serialEvent(){
  
  //taking the input
  String input = port.readStringUntil('\n');
  input = trim(input);//removing the whitespace characters
  float[] values = float(split(input,','));
  
  println(values);
  
  

} 