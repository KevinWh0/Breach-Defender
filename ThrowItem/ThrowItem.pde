

LaunchItem s = new LaunchItem(200,200,400,200,1,100);


void setup(){
  size(400,400);
  
}

class LaunchItem{
  int StartX;
  int StartY;
  float X;
  float Y;
  int StopX;
  int StopY;
  int Time;
  
  float VelocityX;
  float VelocityY = -2;
  LaunchItem(int SStartX, int SStartY, int SStopX,int SStopY, int Grav, int STime){
    StartX = SStartX;
    StartY = SStartY;
    X = SStartX;
    Y = SStartY;    
    StopX = SStopX;
    StopY = SStopY;
    Time = STime;
  }
  
  void Throw(){
    if(X > StopX){
      
     //X--;
      VelocityX = -1;
    }else{
      //X++;
      VelocityX = 1;
    }
    
    if(!(Y > StopY)){
      VelocityY +=0.1;
    }else{
      VelocityY = 0;
    }
    
    X+=VelocityX;
    Y+=VelocityY;
  }
  
  void Display(){
    fill(255,0,0);
    ellipse(X,Y,10,10);
    
    
    
  }
  
  
}


void draw(){
  clear();
  background(255);
  s.Throw();
  s.Display();
  
  
}
