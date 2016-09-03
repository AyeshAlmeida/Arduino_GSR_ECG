Table table1;

//graph variables
float x,gsrX;
float mapStart = 0;
float mapEnd = 240;
float gMin = 0;
float gMax = 1023;
int xPos = 50;
float preX = 50;
float preY = 220;
float preheartX = 400;
int j=0,rows;
void setup(){
  size(1100,650);
  background(0);
  String filename = "70_2016629.csv";
  table1 = loadTable(filename);
  rows = table1.getRowCount();
  println(rows);
  Grid();
  
  for(int i=0;i<rows;i++){
    float r = table1.getFloat(i,1);
    println(r);
  }
}

void draw(){
  plot();
  
}

void plot(){
  if(j<rows){
     float r = table1.getFloat(j,1);
     j++;
   
     gsrX = map(r,gMin,gMax,mapStart,mapEnd);//map the values unto our needed range
    
     stroke(255,0,0);
     line(preX,preY,xPos,100+gsrX);//drawing the line
    
     //setting previous values to next iteration
     preX = xPos;
     preY = 100+gsrX;
          
     xPos++;//incrementing the x-position
    
     if(xPos > 950){
       xPos = 50;
       preX = 50;
       background(0);
       stroke(0);
        Grid();
      }
   
    }
}
