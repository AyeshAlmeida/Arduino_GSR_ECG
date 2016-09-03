void controlEvent(ControlEvent ce){
  if(ce.isTab()){
    cp5.getTab(ce.getTab().getName()).bringToFront();
    fn2.setText("");
    fn1.setText("");
    er1.hide();
    er2.hide();
    er3.hide();
    Filename_on = "";
    Filename_of = "";
  }
  try{
    if(ce.isFrom(save)){
        if(Filename_on.equals("")){
          if(fn1.getText().equals("")){
            er1.show();
          }else{
            selectFolder("Folder to process","folderSelected");          
        }
      }else{
        println("There is no need to save.");
      }
    }
    
    //handling events from check-boxes  
    if(ce.isFrom(module)){
      
      if(module.getState(0) == true){
        GSR = true;
        gsrList.unlock();
      }else{
        GSR = false;
        gsrList.lock();
      }
      if(module.getState(1) == true){
        ECG = true;
        ecgList.unlock();
      }else{
        ECG = false;
        ecgList.lock();
      }
      
    }
    
    //handling the events from 'play button : online'
    if(ce.isFrom(play1)){
      if(Mode == 3){
        Mode = 1;
        loop();
      }else{
        if(Filename_on.equals("")){
          er1.show();      
        }else{
          er1.hide();
          if(GSR == true){
            gsrPort = new Serial(this,gsrP,9600);
            
            if(gsrPort.available() > 0){
              GSRok = true;
              er2.hide();
            }else{
              GSRok = false;
              er2.show();
              println("Port is busy");
            }
          }
        
          if(ECG == true){
            ecgPort = new Serial(this,ecgP,9600);
            
            if(ecgPort.available() > 0){
              ECGok = true;
              er3.hide();
            }else{
              ECGok = false;
              er3.show();
              println("Port is busy");
            }
          }
        
          if(GSRok == true || ECGok == true){
            
            onlineTab = new Table();
            onlineTab.addColumn("Row");
            onlineTab.addColumn("gsr_Reading");
            onlineTab.addColumn("ecg_Reading");
            onlineTab.addColumn("Time");
            
            busy = true;
            Mode = 1;
            start = millis();
            cp5.getTab("offline").setVisible(false);
          }else{
            busy = false;
            Mode = 0;
            cp5.getTab("offline").setVisible(true);
          }
          println("");    
        }
      
    }
  }
    
    //handling events from pause - button
    if(ce.isFrom(pause1)){
      if(busy == true){
        Mode = 3;
      }else{
        println("Nothing to get busy");
      }
    }
    
    //handling events from stop-button
    if(ce.isFrom(stop1)){
      er1.hide();
      er2.hide();
      er3.hide();
      if(busy == true){
        noLoop();
        saveTable(onlineTab,Filename_on);
        GSR = false;
        INCC = 0;
        ECG = false;
        GSRok = false;
        ECGok = false;
        gsrP = "";
        ecgP = "";
        Filename_on = "";
        fn1.setText("");
        module.deactivateAll();
        Mode = 0;
        start = 0;
        cp5.getTab("offline").setVisible(true);
        loop();
      }else{
        noLoop();
        gsrP = "";
        INCC = 0;
        ecgP = "";
        Filename_on = "";
        fn1.setText("");
        module.deactivateAll();
        Mode = 0;
        start = 0;
        cp5.getTab("offline").setVisible(true);
        loop();
        println("Nothing to get busy");
      }   
    }
  
    //control event to handle browse-files
    if(ce.isFrom(browse)){
      if(Filename_of.equals("")){
        selectInput("file","fileSelected");
      }else{
        println("No need to browse.");
      }
    }
    
    //control event to handle play-offline
    if(ce.isFrom(play2)){
      if(Filename_of.equals("")){
        er4.show();
      }else{
        er4.hide();
        offlineTab = loadTable(Filename_of);
        rowCount = offlineTab.getRowCount();
        currentRow = 0;
        if(rowCount > 0){
          er4.hide();
          busy = true;
          Mode = 2;
          cp5.getTab("default").setVisible(false);   
        }else{
          busy = false;
          er4.show();
          fn2.setText("");
          Filename_of = "";
          cp5.getTab("default").setVisible(true);
        }
        
      }
      
    }
    
    //control event to handle pause-offline
    if(ce.isFrom(pause2)){
      if(busy == true){
        noLoop();
        Mode = 3;
        loop();
      }else{
        println("Nothing to get busy");
      }
    }
    
    //control event to handle stop-offline
    if(ce.isFrom(stop2)){
      if(busy == true){
        noLoop();
        busy = false;
        Filename_of = "";
        fn2.setText("");
        offlineTab.clearRows();
        Mode = 0;
        er4.hide();
        INCC = 0;
        currentRow = 0;
        cp5.getTab("default").setVisible(true);
        loop();
      }else{
        noLoop();
        er4.hide();
        INCC = 0;
        Filename_of = "";
        fn2.setText("");
        currentRow = 0;
        cp5.getTab("default").setVisible(true);
        loop();
      }
    }
    
    
  }catch(Exception e){
    println(e);
  } 
}

