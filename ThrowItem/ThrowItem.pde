PImage photo;


LaunchItem s = new LaunchItem(100,200,400,200,100);


void setup(){
  size(400,400);
  photo = loadImage("FootPrints.png");
  s.setImg(photo,16,16);
  s.setRotSpeed(0.1);
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
  float VelocityY = -2;//distX/100
  boolean firstTime = true;
  PImage img;
  int sizeX;
  int sizeY;
  
  float rotSpeed = 0;
  float rot = 0;

  LaunchItem(int SStartX, int SStartY, int SStopX,int SStopY, int STime){
    StartX = SStartX;
    StartY = SStartY;
    X = SStartX;
    Y = SStartY;    
    StopX = SStopX;
    StopY = SStopY;
    Time = STime;
  }
  void setImg(PImage file, int Width, int Height){
    img = file.copy(); 
    sizeX = Width;
    sizeY = Height;
  }
  void setRotSpeed(float RotSpeed){
    rotSpeed = RotSpeed;
  }
  void Throw(){
    
    
    float XSpeed;
    
      XSpeed = VelocityY+1;

    
    
    if(X > StopX){
      
     //X--;
      VelocityX = -abs(XSpeed);
    }else{
      //X++;
      VelocityX = abs(XSpeed);
    }
    float distX = abs(StartX-StopX);
    if(firstTime){
     VelocityY = -(distX/100); 
      firstTime = false;
    }
    
    
    print(distX/100+"\n");
    if(!(Y > StopY)){
      VelocityY +=distX/(10000); //10,000 works for a dist of 200
    }else{
      VelocityY = 0;
    }
    
    X+=VelocityX;
    Y+=VelocityY;
  }
  
  void Display(){
    //fill(255,0,0);
    //ellipse(X,Y,10,10);
    rot += rotSpeed;
    try{
      pushMatrix();
      translate(X-img.width/2,Y-img.height/2);
      rotate(rot);
      image(img,0,0,sizeX,sizeY);
      popMatrix();
    }catch(Exception e){print("You forgot to set the image, set it with .SetImage(PImage);");}
    
    
  }
  void runAll(){
    
   this.Throw();
   this.Display();
  }
  boolean isDone(){
    
    if(VelocityY == 0 && abs(StartX-StopX) < 3){
      return true;
    }
    
    return false;
  }
  
  
}


void draw(){
  clear();
  background(255);
  image(photo,10,10);
  s.runAll();

  

  
}
