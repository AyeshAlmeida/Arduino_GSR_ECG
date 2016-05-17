import processing.serial.*;

//creating a table
Table table;
//instance of a Serial-port object
Serial myport;

/*GSr variables*/
float x,gsrX;
int xPos = 0;
float preX = 0;
float preY = 250;

/*setting variables for GSRval range*/
float gsrMax = 1023;
float gsrMin = 0;
/*setting variables for mapping value range*/
float mapEnd = 500;
float mapStart = 0;

void setup(){
  
  size(1200,600);
  
  //print the seirial ports you have
  printArray(Serial.list());
  
  //create a Serial-port object
  myport = new Serial(this,"/dev/ttyUSB2",19200);
  background(0);
  
  /*creating a table*/
  table = new Table();
  /*Add Column*/
  table.addColumn("X-Position");
  table.addColumn("Reading");
  
}

void draw(){
  //do the stuff you want to do
  serialEvent();  
}

void serialEvent(){
  /*Adding a title*/
  textAlign(CENTER);
  textSize(32);
  text("Galvanic Skin Response",600,36);
  
  /*taking an input*/
  String instring = myport.readStringUntil('\n');
  
  if(instring != null)
  {
    //trim the white spaces
    instring = trim(instring);
    //split the values using commas
    float[] val = float(split(instring,','));
    /*taking the mean of two values*/
    println(val);
    
    x = val[0];
    
    println(x,xPos);
    gsrX = map(x,gsrMin,gsrMax,mapStart,mapEnd); 
    
    stroke(230,0,0);
    line(preX,preY,xPos,gsrX);
    
    preX = xPos;
    preY = gsrX;
    
    /*adding a row to table*/
    TableRow newRow = table.addRow();
    newRow.setInt("X-Position",xPos);
    newRow.setFloat("Reading", x);
    
    /*Save the Table*/ 
    saveTable(table, "./data/new.csv");
  
    if (xPos >= width) {
        xPos = 0;
        background(0);   // erase screen with white
        preX = 0;  
    } else {
        xPos++;          // increment the graph's horizontal position
    }   
  }
}

void mouseClicked(){
  stroke(100,100,100);
  line(mouseX,mouseY-20,mouseX,mouseY);
}