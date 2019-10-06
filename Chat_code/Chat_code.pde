

void setup(){
  
  size(400,400);
  
  
  
}
int lastRun; //the last time in millisecs it ran
int charAddNum; //the position that the adding is at
String RamAdderText = ""; //the text to return
Boolean doneWithStatment = true; // basicly a reset
String lastText = "";
String Say(String Text, boolean skip){
  int textLength = Text.length();
  if(doneWithStatment){
      lastRun = 0;
      charAddNum = 0;
      RamAdderText = "";
      doneWithStatment = false;
    
  }
  
  if(lastRun != millis() && textLength > charAddNum){
    lastRun = second();
    try{
      RamAdderText = RamAdderText + Text.charAt(charAddNum);
    }catch(Exception e){
      
    }
    charAddNum++;
    
  }
  if(skip){
   RamAdderText = Text;   
  }
    if(lastText.equals(Text)){
    RamAdderText = lastText;
  }
  if(RamAdderText.equals(Text)){
    doneWithStatment = true;
    lastText = RamAdderText;
    
  }
  return RamAdderText;
  
}



void draw(){
  background(0);
  fill(255);
  text(Say("Hello Test Lol Hello Test Lol", mousePressed),50,50);
  
  
  
  
  
}
