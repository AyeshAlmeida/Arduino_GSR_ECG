public String createName(String name){
  //taking a random number
  float x = random(1000);
  int y = int(x);
  
  //taking date
  int yr,mn,day;
  yr = year();
  mn = month();
  day = day();
  
  String yyr,mnn,dayy;
  yyr = String.valueOf(yr);
  mnn = String.valueOf(mn);
  dayy = String.valueOf(day);
 
  //setting the new name
  String newName =name+String.valueOf(y)+"_"+yyr+mnn+dayy;
  
  return newName;
}