
void setup(){
  
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
  
  
  //ECG - Grid
  for(int i=1;i<5;i++){
    line(50,350 + (50*i),950,350 + (50*i));
  }
  
  for(int i = 1;i<9;i++){
    line(50+(50*2*i),350,50+(50*2*i),600);
  }
}