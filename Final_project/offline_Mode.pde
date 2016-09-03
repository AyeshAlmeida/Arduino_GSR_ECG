void offlineSerial(){
  if(currentRow < rowCount){
    Table temp = loadTable(Filename_of,"csv");
    float gsr = temp.getFloat(currentRow,1);
    float ecg = temp.getFloat(currentRow,2);
    currentRow++;
    
    stroke(255,0,0);
    
    if(Float.isNaN(gsr) || gsr == 0.0){
      println("GSR not a number");
    }else{
      gsrR = map(gsr,Min,Max,mapStart,mapEnd);
      line(preX_of,preY_of_gsr,xPos_of,300-gsrR);
      preY_of_gsr = 300-gsrR; 
    }
    if(Float.isNaN(ecg) || ecg == 0.0){
      println("ECG not a number");
    }else{
      ecgR = map(ecg,Min,Max,mapStart,mapEnd);    
      line(preX_of,preY_of_ecg,xPos_of,600-ecgR);
      preY_of_ecg = 600-ecgR;  
    }
    
    preX_of = xPos_of;
    
    xPos_of++;
    drawMonitor_offline();
  }else{
    Mode = 3;
  }
}

void drawMonitor_offline(){
  if(xPos_of > 600 || xPos_of > 600){
      xPos_of = 100;
      preX_of  = 100;     
      background(0x263238);
      INCC++;
      Grid();
    }
}
