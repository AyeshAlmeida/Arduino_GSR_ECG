import processing.serial.*;


int myColor = color(255);

//setting the mode
int Mode = 0;

//creating a table
Table table,revtable;

int rownumber = 0;

//variables to hold date
int yr,mn,dt;
int hr,mins,sec,mili;

//varibles to use to name 
String date,time;
String y,m,d;
String h,min,s,ms;

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
float preY = 220;

void setup(){
  
  //create a serial-port object instance
  port = new Serial(this,"/dev/ttyUSB2",19200);
  
  size(1100,650);//creating the basic GUI
  background(0);//setting background color
  
  //date : file name
  yr = year();
  mn = month();
  dt = day();
  
  y = String.valueOf(yr);
  m = String.valueOf(mn);
  d = String.valueOf(dt);
  
  date = y+"_"+m+"_"+d;
  
  table = new Table();//creating table instance
  //adding columns to table
  table.addColumn("X-Position");
  table.addColumn("Current_Reading");
  table.addColumn("Time_Stamp");
  
  Grid();
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
    
    xPos++;//incrementing the x-position
    
    if(xPos > 950){
      xPos = 50;
      preX = 50;
      background(0);
      stroke(0);
      Grid();
    }
    
    /*setting the time-stamp*/
    hr = hour();
    mins = minute();
    sec = second();
    mili = millis();
    
    h = String.valueOf(hr);
    min = String.valueOf(mins);
    s = String.valueOf(sec);
    ms = String.valueOf(mili);
    
    time = h+"_"+min+"_"+s+"_"+ms;
    
    //adding a row to the table
    TableRow newRow = table.addRow();
    newRow.setInt("X-Position",rownumber);
    newRow.setFloat("Current_Reading", x);
    newRow.setString("Time_Stamp",time);
    
    rownumber++;
    
    //save the table
    saveTable(table,"./data/"+date+".csv");
    
  }
  

} 

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