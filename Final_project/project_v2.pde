import controlP5.*;
import processing.serial.*;
import java.util.*;

void setup(){
  //setting up size and background color
  size(700,700);
  background(0x263238);
  Mode = 0;
  frame.setTitle("Biophysical Signal Capturer");
  //adding the 'cp5' element
  cp5 = new ControlP5(this);
  
  cp5.getTab("default")
     .setColorBackground(color(0,160,100))
     .setLabel("ONLINE")
     .setSize(90,45)
     .activateEvent(true)
     .setColorActive(color(255,128,1))
     .setId(1)
     .getCaptionLabel().setFont(createFont("Georgia",15)); 
  
  cp5.addTab("offline")
     .setColorBackground(color(0,160,100))
     .setLabel("OFFLINE")
     .setSize(90,45)
     .setColorActive(color(255,128,1))
     .activateEvent(true)
     .setId(2)
     .getCaptionLabel().setFont(createFont("Georgia",15));
   
  /*Elements in Online Tab*/
  tl1 = cp5.addTextlabel("label1")
           .setText("File Name ")
           .setPosition(10,30)
           .setColorBackground(color(100))
           .setFont(createFont("Georgia",15));
  
  fn1 = cp5.addTextfield("file1") 
           .setColorBackground(color(100))
           .setPosition(100,30)
           .setSize(110,20)
           .setFont(createFont("arial",10));
  fn1.getCaptionLabel().hide();
  
  er1 = cp5.addTextlabel("label3")
           .setText("**")
           .setPosition(212,30)
           .setColor(color(255,0,0))
           .setColorBackground(color(100))
           .setFont(createFont("Georgia",15));
  er1.hide();
  
  save = cp5.addButton("save")
            .setPosition(250,30)
            .setColorBackground(color(100,100,100))
            .setSize(80,20)
            .setCaptionLabel("Save");
  save.getCaptionLabel().setFont(createFont("arial",15));  
  
  play1 = cp5.addButton("play1")
             .setPosition(340,30)
             .setColorBackground(color(100,100,100))
             .setSize(80,20)
             .setCaptionLabel("Play");
  play1.getCaptionLabel().setFont(createFont("arial",15));
  
  pause1 = cp5.addButton("pause1")
              .setPosition(430,30)
              .setColorBackground(color(100,100,100))
              .setSize(80,20)
              .setCaptionLabel("Pause");
  pause1.getCaptionLabel().setFont(createFont("arial",15));
  
  stop1 = cp5.addButton("stop1")
             .setPosition(520,30)
             .setColorBackground(color(100,100,100))
             .setSize(80,20)
             .setCaptionLabel("Stop");
  stop1.getCaptionLabel().setFont(createFont("arial",15));
  
  module = cp5.addCheckBox("module")
              .setColorActive(color(207,0,15))
              .setPosition(100,60)
              .setSize(35,35)
              .setItemsPerRow(1)
              .setSpacingRow(265)
              .addItem("GSR",0)
              .addItem("ECG",1);
 
  module.getItem(0).getCaptionLabel().setFont(createFont("Georgia",15));         
  module.getItem(1).getCaptionLabel().setFont(createFont("Georgia",15));
  module.getItem(1).setColorBackground(color(238,130,238));
  
  gsrList = cp5.addDropdownList("gsrList")
               .setPosition(200,70)
               .setSize(125,100);
  gsrList.lock();
  
  er2 = cp5.addTextlabel("label4")
           .setText("**")
           .setPosition(330,70)
           .setColor(color(255,0,0))
           .setColorBackground(color(100))
           .setFont(createFont("Georgia",15));
  er2.hide();
  
  ecgList = cp5.addDropdownList("ecgList")
                .setPosition(200,370)
                .setSize(125,100);
  ecgList.lock();
  
  er3 = cp5.addTextlabel("label5")
           .setText("**")
           .setPosition(330,370)
           .setColor(color(255,0,0))
           .setColorBackground(color(100))
           .setFont(createFont("Georgia",15));
  er3.hide();
  
  customize(gsrList);
  customize(ecgList);
  
  module.deactivateAll();
  
  cp5.getController("label1").moveTo("default");
  cp5.getController("label3").moveTo("default");
  cp5.getController("file1").moveTo("default");
  cp5.getController("save").moveTo("default");
  cp5.getController("play1").moveTo("default");
  cp5.getController("pause1").moveTo("default");
  cp5.getController("stop1").moveTo("default");
  cp5.getController("gsrList").moveTo("default");
  cp5.getController("ecgList").moveTo("default");
  cp5.getController("label4").moveTo("default");
  cp5.getController("label5").moveTo("default");
  
  /*Elements in Offline Tab*/
  tl2 = cp5.addTextlabel("label2")
           .setText("File Name ")
           .setPosition(10,30)
           .setColorBackground(color(100))
           .setFont(createFont("Georgia",15));
  
  fn2 = cp5.addTextfield("file2") 
           .setColorBackground(color(100))
           .setPosition(100,30)
           .setSize(110,20)
           .setFont(createFont("arial",10));
  fn2.getCaptionLabel().hide();

  browse = cp5.addButton("browse")
              .setPosition(220,30)
              .setColorBackground(color(100,100,100))
              .setSize(80,20)
              .setCaptionLabel("Browse");
  browse.getCaptionLabel().setFont(createFont("arial",15));
  
  play2 = cp5.addButton("play2")
             .setPosition(310,30)
             .setColorBackground(color(100,100,100))
             .setSize(80,20)
             .setCaptionLabel("Play");
  play2.getCaptionLabel().setFont(createFont("arial",15));
  
  pause2 = cp5.addButton("pause2")
              .setPosition(400,30)
              .setColorBackground(color(100,100,100))
              .setSize(80,20)
              .setCaptionLabel("Pause");
  pause2.getCaptionLabel().setFont(createFont("arial",15));
         
  stop2 = cp5.addButton("stop2")
             .setPosition(490,30)
             .setColorBackground(color(100,100,100))
             .setSize(80,20)
             .setCaptionLabel("Stop");
  stop2.getCaptionLabel().setFont(createFont("arial",15));
  
  tl3 = cp5.addTextlabel("label6")
           .setText("GSR - Reading")
           .setPosition(100,70)
           .setColorBackground(color(100))
           .setFont(createFont("Georgia",20));
  tl4 = cp5.addTextlabel("label7")
           .setText("ECG - Reading")
           .setPosition(100,370)
           .setColorBackground(color(100))
           .setFont(createFont("Georgia",20));
  
  er4 = cp5.addTextlabel("label8")
           .setText("Invalid File")
           .setPosition(400,70)
           .setColor(color(255,0,0))
           .setColorBackground(color(100))
           .setFont(createFont("Georgia",15));
  er4.hide();
  cp5.getController("label2").moveTo("offline");
  cp5.getController("label6").moveTo("offline");
  cp5.getController("label7").moveTo("offline");
  cp5.getController("label8").moveTo("offline");
  cp5.getController("file2").moveTo("offline");
  cp5.getController("browse").moveTo("offline");
  cp5.getController("play2").moveTo("offline");
  cp5.getController("pause2").moveTo("offline");
  cp5.getController("stop2").moveTo("offline");
  
  checkOS();
  Grid();
}


void draw(){

  //normal-Mode
  if(Mode == 0){
   background(0x263238);
   Grid();
  }
  
 //online-Mode
 else if(Mode == 1){
   
   TableRow newrow = onlineTab.addRow();
   newrow.setInt("Row",Pos++);
   if(GSRok == true){
     gsrSerial(gsrPort);
   }else{
     x = 0;
   }
   newrow.setFloat("gsr_Reading",x);
   if(ECGok == true){
     ecgSerial(ecgPort);
   }else{
     y = 0;
   }
   newrow.setFloat("ecg_Reading",y);
   newrow.setInt("Time",millis()-start);
   
 }
 
 //offline-Mode
 else if(Mode == 2){
   if(rowCount > 0){
     offlineSerial();
   }else{
     println("Error : File is empty.");
   }
 }
 
 //paused-Mode
 else if(Mode == 3){
   println("Serial paused");
 }
 
 delay(40);
 
}



