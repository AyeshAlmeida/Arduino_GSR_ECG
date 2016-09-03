//produce date
String date(){
  String date = "";               
  date += day();
  date += "-";
  date += month();
  date += "-";
  date += year();
  return date;    
}

//function tom select a folder from file browser
void folderSelected(File select){
  if(select == null){
    println("Error");
  }else{
    path_on = select.getAbsolutePath();
    Filename_on = fileName(path_on,fn1.getText());
    fn1.setText(Filename_on);
    println(Filename_on);
  }
}

//function to select files from file browser
void fileSelected(File selection){
  if(selection == null){
    println("Error");
  }else{
     Filename_of = selection.getAbsolutePath();
     fn2.setText(Filename_of);
     println(Filename_of);  
  }
}

//function to get the list files in a directory
String[] listFileNames(String dir){
  File f = new File(dir);
  if(f.isDirectory()){
    String names[] = f.list();
    return names;
  }else{
    return null;
  }
}

//function to produce file_names
String fileName(String path,String name){
  String result = "";
  String array[];
  array = listFileNames(path);
  if(Windows == true){
    if(array == null){
      result = path+"\\"+date()+"\\"+name+"\\"+"0\\"+"record";
    }else{
      array = listFileNames(path+"\\"+date());
      if(array == null){
        result = path+"\\"+date()+"\\"+name+"\\"+"0\\"+"record";
      }else{
        array = listFileNames(path+"\\"+date()+"\\"+name);
        if(array == null){
          result = path+"\\"+date()+"\\"+name+"\\"+"0\\"+"record";
        }else{
          result = path+"\\"+date()+"\\"+name+"\\"+str(array.length-1)+"\\"+"record";
        }
      }
    }
  }else{
    println("No windows");
  }
  array = listFileNames(path);
  if(Linux == true){
    if(array == null){
      result = path+"/"+date()+"/"+name+"/"+"0/"+"record";
    }else{
      array = listFileNames(path+"/"+date());
      if(array == null){
        result = path+"/"+date()+"/"+name+"/"+"0/"+"record";
      }else{
        array = listFileNames(path+"/"+date()+"/"+name);
        if(array == null){
          result = path+"/"+date()+"/"+name+"/"+"0/"+"record";
        }else{
          result = path+"/"+date()+"/"+name+"/"+str(array.length-1)+"/"+"record";
        }
      }
    }
  }else{
    println("No linux");
  }
  
  return result+".csv";
  
}

//function to draw the grid
void Grid(){
  //GSR-grid
  
  float x = 9050;  
  x *= INCC;
  
  stroke(220);
  fill(220);
  rect(100,100,500,200);
  
  //drawing lines
  for(int i=1;i<10;i++){
    stroke(120,120,120);
    line(100+(50*i),100,100+(50*i),300);
  }
  
  for(int i=1;i<4;i++){
    stroke(120,120,120);
    line(100,100+(50*i),600,100+(50*i));
  }
  
  //setting numbers on grid
  textSize(9);
  for(int i = 0;i<4;i++){
    text(str(1023-(255.75*i)),50,110+(i*50));
  }
  for(int i=0;i<11;i++){
    text(str(x+(905*i)),100+(50*i),320);  
  }
  textSize(15);
  text("(millis)",640,340);
  //ECG-grid
  fill(220);
  rect(100,400,500,200);
  
  for(int i=1;i<10;i++){
    stroke(120,120,120);
    line(100+(50*i),400,100+(50*i),600);
  }
  
  for(int i=1;i<4;i++){
    stroke(120,120,120);
    line(100,400+(50*i),600,400+(50*i));
  }
  
  //setting numbers on grid
  textSize(9);
  for(int i = 0;i<4;i++){
    text(str(1023-(255.75*i)),50,410+(i*50));
  }
  for(int i=0;i<11;i++){
    text(str(x+(905*i)),100+(50*i),620);  
  }
  textSize(15);
  text("(millis)",640,640);
}

void customize(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.getCaptionLabel().set("dropdown");
  for (int i=0;i<10;i++) {
    ddl.addItem(Serial.list()[i], i);
  }
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
  ddl.close();
}

//checking Operating Systems
void checkOS(){
  String res = System.getProperty("os.name");
  if(res.equals("Linux")){
    Linux = true;
  }else{
    Linux = false;
  }
  if(res.equals("Windows")){
    Windows = true;
  }else{
    Windows = false;
  }
}

void gsrList(int n) {
  /* request the selected item based on index n */
  Map r = gsrList.getItem(n);
  gsrP = (String)r.get("text");
  println(gsrP);
}

void ecgList(int n) {
  /* request the selected item based on index n */
  Map r = ecgList.getItem(n);
  ecgP = (String)r.get("text");
  println(ecgP);
}


//mouse click event
void mouseClicked(){
  
  if(((mouseX > 100 && mouseX < 600) ) && ((mouseY>100 && mouseY<300) || (mouseY>400 && mouseY < 600))){
    stroke(255,0,255);
    line(mouseX,mouseY-40,mouseX,mouseY);
  }
}
