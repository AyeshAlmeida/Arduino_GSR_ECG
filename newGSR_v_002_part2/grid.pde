void Grid(){
  fill(220);
  rect(50,50,900,250);//creating a rectangle
  
  fill(220);
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

//mouse click event
void mouseClicked(){
  stroke(0,0,255);
  line(mouseX,mouseY-20,mouseX,mouseY);
}