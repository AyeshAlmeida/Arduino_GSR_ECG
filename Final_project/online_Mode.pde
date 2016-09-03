void gsrSerial(Serial port){
  String input = port.readStringUntil('\n');
  if(input != null){
    //taking the input
    input = trim(input);
    float val[] = float(split(input,','));
    x = val[0];
    
    //mapping the values
    gsrX = map(x,Min,Max,mapStart,mapEnd);
    
    //drawing the lines
    stroke(255,0,0);
    line(preX_gsr,preY_gsr,xPos_gsr,300-gsrX);
    
    //setting up the previous values
    preX_gsr = xPos_gsr++;
    preY_gsr = 300 - gsrX;
    
    drawMonitor();  
  }
}

void ecgSerial(Serial port){
  String input = port.readStringUntil('\n');
  if(input!=null){
    input = trim(input);
    if(input.equals("!")){
      stroke(0,0,255);
      y = 512;
    }
    else{
      stroke(255,0,0);
      y = float(input);
    }
    
    ecgY = map(y,Min,Max,mapStart,mapEnd);
    line(preX_ecg,preY_ecg,xPos_ecg,600-ecgY);
    
    preX_ecg = xPos_ecg++;
    preY_ecg = 600-ecgY;
    
    drawMonitor();    
  }
}

void drawMonitor(){
  if(xPos_gsr > 600 || xPos_ecg > 600){
      xPos_ecg = 100;
      xPos_gsr = 100;
      preX_ecg  = 100;
      preX_gsr = 100;
      INCC++;
      background(0x263238);
      Grid();
    }
}


