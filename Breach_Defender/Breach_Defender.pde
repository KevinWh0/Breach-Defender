import processing.sound.*;
import processing.net.*;
//Debug graph import
import grafica.*;


GPlot fps;



ParticleSystem ps;
ParticleSystem FootSteps;



boolean ServerStarted = false;
boolean Connected = false;
String ServerType = "";

Server s; 
Client c;
String input;
int data[];

int Player2X;
int Player2Y;
/************************************************************************************
 ------------------------USE CNTRL+F and search "TODO"--------------------------------
 
 Add Shake Funtion
 
 
 
 
 **************************************************************************************/

SoundFile MainTheme;
SoundFile CreitsTheme;

//SFX
SoundFile Shoot;
SoundFile ClipFence;
SoundFile Explosion;

PImage player;

//Footprint
PImage Footprints;
//icons and stuff
PImage icons;
PImage tilesB;
PImage items;
PImage TransportV;
PImage NPCS;
PImage GunCrosshair;
PImage Heart;



//NPCS
PImage GuardLegUp1;
PImage GuardLegUp2;


//TILES
PImage Grass;
PImage Dirt;
PImage Floor;
PImage Fence;
PImage FenceR;
PImage FenceC;
PImage FenceCR;
PImage Tar;
PImage TrafficCone;
PImage Wall;
PImage WallRot;
PImage Easel;

//Credits Paralax Things
PImage b1;
PImage b2;
PImage b3;
PImage b4;
PImage b5;
boolean loadingCreditsFiles = true;


//ITEMS
PImage WireCutters;
PImage Pistol;
PImage Dynamite;


Boolean DevTools = false;
Boolean DevVis = false;
Boolean isBuilding = false;
Boolean openGraph = false;

//Trucks cars ect...
PImage STruck;
PImage STruckRot1;

int maxFrameRate = 60;

boolean mouseP = false;

//Enviorment

color SkyColor = color(69, 205, 252);

int global_time = 0;
int timeSpeed = 1;

float shaderIntensity = 1.0;

//Player Data

float PlayerX = 0;
float PlayerY = 0;
int OldPlayerX = 0;
int OldPlayerY = 0;

int MouseXOnGrid;
int MouseYOnGrid;


int PlayerOffsetX = 0;
int PlayerOffsetY = 0;

int SpawnX = 0;
int SpawnY = 0;

int Coins = 500;

boolean showPlayer = true;
boolean OnV = false;
int PlayerWidth = 50;
int PlayerHeight = 50;
int MaxPlayerSpeed = 8;
int PlayerSpeed = 1;
int xp = 10;
int MaxHealth = 20;
int Health = 20;
boolean dead = false;
String DeathMSG = "";
boolean HealTick = false;
boolean walking = false;
String facing = "Right";
String fceing = "Right";
String Team;


int WeaponDmg[] = {20, 20, 20};


String Inv[] = {"", "", "", "", "", ""};

//String Inv[] = {"Wire-Cutters", "Dev Wand", "Speed Wand", "", "", ""};
float Cooldown = 0;
int SelectedItem;


//Map Data
int MWidth = 90;
int MHeight = 90;

int BlockSize = 60;



boolean hitSomthing = false;



//Objects on map
Guard G1 = new Guard(64, 69, 50); 
Vehicle Van1 = new Vehicle(1, 1, "VAN", 5); 

String[] sellItems = {"Wire-Cutters", "50", "Pistol", "200", "Dynamite", "500"};  ///text(Say(Text[Clicks]+" //"+Clicks, false), OnScreenGX-50, OnScreenGY-60, PlayerWidth+100, PlayerHeight+10);
String[] NPCTalk = {"If we Naruto run we can move faster than their bullets.", "Want somthing, if so I got you covered.", "Want to buy some Wire Cutters for 50$", "Want to buy a Pistol for 200$", "Want to buy some Dynamite for 500$"};
NPC NPC1 = new NPC(50, 50, "Bill", sellItems, NPCTalk); 


//BUILD MODE (DEV)
int RectSize = 50;
color Placing = color(1, 0, 0, 0);




//ScreenShake
int ShakeLimits = 0;




boolean settingsOpen = false;
boolean paused = false;



int blockHardnesses[] = {1000, 1000, 1000, 15, 0, 0};




//Settings stuff
int SettingsTitleOffset;

//location on where the player is on the menu if the player is on the menu
String DispMenu = "MainMenu";





int pressingMouse = 0;




PImage MAP;



void settings() {

  noSmooth();  
  size(800, 800);
}
void setup() {
  frameRate(maxFrameRate);
  surface.setResizable(true);
  fps = new GPlot(this);
  fps.setPos(0, 0);
  fps.setDim(200, 200);
  fps.setPointColor(color(0, 0, 0, 255));
  fps.setPointSize(2);

  player = loadImage("Player.png");
  icons = loadImage("Icons.png");
  tilesB = loadImage("TilesB.png");
  items = loadImage("Items.png");
  TransportV = loadImage("Transport.png");
  NPCS = loadImage("NPCS.png");




  //LOAD SOUND
  MainTheme = new SoundFile(this, "theme_main.mp3");


  //SFX
  Shoot = new SoundFile(this, "/Sounds/Shoot.mp3");
  ClipFence = new SoundFile(this, "/sounds/ClipFence.mp3");
  Explosion = new SoundFile(this, "/sounds/Explosion.mp3");


  //NPCS
  GuardLegUp1 = loadImg(NPCS, 0, 0, 16, 16, false);
  GuardLegUp2 = loadImg(NPCS, 16, 0, 16, 16, false);

  //TILES
  Grass = loadImg(tilesB, 0, 0, 16, 16, false);
  Dirt = loadImg(tilesB, 16, 0, 16, 16, false);
  Floor = loadImg(tilesB, 32, 0, 16, 16, false);
  Fence = loadImg(tilesB, 48, 0, 16, 16, false);//keep
  FenceR = loadImg(tilesB, 48, 0, 16, 16, true);
  FenceC = loadImg(tilesB, 48, 16, 16, 16, false);//keep
  FenceCR = loadImg(tilesB, 48, 16, 16, 16, true); // keep
  Tar = loadImg(tilesB, 32, 16, 16, 16, false);
  TrafficCone = loadImg(tilesB, 32, 32, 16, 16, false);
  Wall = loadImg(tilesB, 16, 16, 16, 16, false);
  WallRot = loadImg(tilesB, 16, 16, 16, 16, true);
  Easel = loadImg(tilesB, 32, 48, 16, 16, false);

  //ITEMS
  WireCutters = loadImg(items, 0, 0, 16, 16, false);
  Pistol = loadImg(items, 16, 0, 16, 16, false);
  Dynamite = loadImg(items, 32, 0, 16, 16, false);
  //Icons
  GunCrosshair = loadImg(icons, 0, 16, 16, 16, false);
  Heart = loadImg(icons, 0, 0, 16, 16, false);
  Footprints = loadImage("FootPrints.png");

  //FootPrints.png

  //Trucks Cars ect...
  STruck = loadImg(TransportV, 0, 0, 16, 16, false);
  STruckRot1 = loadImg(TransportV, 0, 0, 16, 16, true);

  MAP = loadImage("MapOutput.png");
  MWidth = MAP.width;
  MHeight = MAP.height;


  SettingsTitleOffset = -width;


  ps = new ParticleSystem(Tar, -10, -10, 0, 0, 50, 100, false);
  FootSteps = new ParticleSystem(loadImg(Footprints, 0, 0, 16, 16, false), -10, -10, 0, 0, 50, 255, true);



  if (DevTools) {
    MainTheme.amp(0);
  }
}


class Vehicle {
  //TODO make it so there is a seprate PImage for each state so it increses fps
  int OnScreenVX;
  int OnScreenVY;
  int VanSize = 100;
  int TurnSpeed;
  int VX;
  int VY;
  float Vel;
  float playerCVel;
  boolean controlled = false;
  boolean shouldDriveOnOwn = true; //set to false if the player has already hijacked the vicle so it does not drive away

  boolean placeBackNeeded = false;
  int placeBack[][] ={{0, 0, 0, 0}, 
    {0, 0, 0, 0}, 
    {0, 0, 0, 0}, 
    {0, 0, 0, 0}};

  //int VelY;
  float topSpeed;
  String OldHeading = "NULL";

  String Heading = "NULL";

  String TypeofV;
  Vehicle(int SpawnX, int SpawnY, String TypeofVS, int SpawnTopSpeed) {
    VX = SpawnX;
    VY = SpawnY;
    TypeofV = TypeofVS;
    topSpeed = SpawnTopSpeed;
    if (TypeofVS.equals("VAN")) {
      TurnSpeed = 2;
    }
  }
  void runAll() {
    if (controlled == false && shouldDriveOnOwn) {
      this.drive();

      this.RunoverHumans();
    }
    OnScreenVX = VX+round(PlayerX);
    OnScreenVY = VY+round(PlayerY);
    if ((OnScreenVX > 0 && OnScreenVX < width && OnScreenVY > 0 && OnScreenVY < height)) {

      this.displayV();
      this.hijackVeicle();
    }
    ps.run();
  }
  void Speedometer() {
    fill(200, 200, 200, 100);
    ellipse(width, height, 200, 200);
    stroke(255, 0, 0);
    arc(width, height, 200, 200, 0, PI+(playerCVel/20)+0.1, PIE);
    fill(255);
    textSize(20);
    text("MPH:"+playerCVel*2, width-80, height-20);
    textSize(12);
    noStroke();
  }
  void OpenGates() {
  }
  void hijackVeicle() {

    if (dead) {
      showPlayer = true;
      controlled = false;
      PlayerSpeed = MaxPlayerSpeed;
      Health = 20;
      OnV = false;
    }

    if (inArea(width/2, height/2, OnScreenVX-((5/16)*VanSize), OnScreenVY-((5/16)*VanSize), VanSize-((5/16)*VanSize), VanSize-((5/16)*VanSize))) { 

      if (mouseLifted() && inArea(mouseX, mouseY, (width/2)-60, height-160, 120, 50) && dead == false) {
        fill(0, 0, 0, 150);

        controlled = true;
        mouseP = false;
        OnV = true;
        shouldDriveOnOwn = false;
      } else {
        fill(25, 25, 25, 100);
      }
      rect((width/2)-60, height-160, 120, 50);
      fill(255);

      text("Press Here to enter the Vehicle", (width/2)-60, height-160, 120, 50);
    }
    if (controlled == true) {
      Speedometer();
      if (hitSomthing) {
        playerCVel = 5;  
        hitSomthing = false;
      }

      if (keyPressed) {
        if (keyCode == UP || keyCode == DOWN || keyCode == LEFT || keyCode == RIGHT) {
          if (playerCVel < 20) {
            if (IsSolid(VX, VY) && blockHardnesses[3] < playerCVel) {
              playerCVel = 5;
            } else {
              playerCVel += 0.5;
            }
          } else {
            playerCVel-=random(0.5);
          }
        }
      } else {

        //PlayerSpeed = 0; 
        //playerCVel = 0;
      }
      if (IsSolid(VX, VY) && blockHardnesses[3] < playerCVel) {
        playerCVel = 5;
      }

      //playerCVel is the vans speed;=
      PlayerSpeed=round(playerCVel);

      VX = abs(round(PlayerX)-(width/2));
      VY = abs(round(PlayerY)-(height/2));//              shakeScreen(20,0.1);

      Heading = fceing;
      showPlayer = false;
      Health = 100;
      if (mouseLifted() && inArea(mouseX, mouseY, (width/2)-60, height-160, 120, 50)) {
        fill(0, 0, 0, 150);
        showPlayer = true;
        controlled = false;
        PlayerSpeed = MaxPlayerSpeed;
        Health = 20;
        OnV = false;
      } else {
        fill(25, 25, 25, 100);
      }
      rect((width/2)-60, height-160, 120, 50);
      fill(255);
      text("Press Here to EXIT the Vehicle", (width/2)-60, height-160, 120, 50);
    }
  }
  void RunoverHumans() {
    //OnScreenVX, OnScreenVY, 100, 100 
    if (inArea(width/2, height/2, OnScreenVX-((5/16)*VanSize), OnScreenVY-((5/16)*VanSize), VanSize-((5/16)*VanSize), VanSize-((5/16)*VanSize)) && DevTools == false) {
      if (Vel > 1) {
        Health-=20;
        DeathMSG = "Next time dont get run over?!?";
      } else {
      }
    }
    //This detects a motor gate close by (1 block radius)

    if (GetBlock(VX+BlockSize, VY) == color(8, 0, 0, 255)) {
      setMap(int((VX+BlockSize)/BlockSize), int(VY/BlockSize), color(5, 0, 0, 255));
      //placeBackNeeded = true;
      //placeBack[0][0] = int(VY/BlockSize);
      //placeBack[0][1] = int((VX+BlockSize)/BlockSize);
    } else if (GetBlock(VX-BlockSize, VY) == color(8, 0, 0, 255)) {
      setMap(int((VX-BlockSize)/BlockSize), int(VY/BlockSize), color(5, 0, 0, 255));
      //placeBackNeeded = true;
      //placeBack[1][0] = int((VX-BlockSize)/BlockSize);
      //placeBack[1][1] = int(VY/BlockSize);
    } else if (GetBlock(VX, VY+BlockSize) == color(8, 0, 0, 255)) {
      setMap(int(VX/BlockSize), int((VY+BlockSize)/BlockSize), color(5, 0, 0, 255));
      //placeBackNeeded = true;
      //placeBack[2][0] = int(VX/BlockSize);
      //placeBack[2][1] = int((VY+BlockSize)/BlockSize);
    } else if (GetBlock(VX, VY-BlockSize) == color(8, 0, 0, 255)) {
      setMap(int(VX/BlockSize), int((VY-BlockSize)/BlockSize), color(5, 0, 0, 255));
      //placeBackNeeded = true;
      //placeBack[3][0] = int(VX/BlockSize);
      //placeBack[3][1] = int((VY-BlockSize)/BlockSize);
    } else if (GetBlock(VX, VY) == color(8, 0, 0, 255)) {
    } else if (placeBackNeeded == true) {
      placeBackNeeded = false;

      for (int i = 0; i < 4; i++) {
        setMap(placeBack[i][0], placeBack[i][1], color(8, 0, 0, 255));
      }
    }
  }

  void displayV() {
    OnScreenVX = VX+round(PlayerX);
    OnScreenVY = VY+round(PlayerY);
    ps.addParticle();

    if (Heading.equals("Down")) {
      image(STruck, OnScreenVX, OnScreenVY, VanSize, VanSize);
      ps.SetPos(VX+20, VY);
    } else if (Heading.equals("Up")) {
      image(flipImg(STruck, "Y"), OnScreenVX, OnScreenVY, VanSize, VanSize);
      ps.SetPos(VX+20, VY+VanSize);
    } else if (Heading.equals("Right")) {
      image(flipImg(STruckRot1, "Y"), OnScreenVX, OnScreenVY, VanSize, VanSize);
      ps.SetPos(VX, VY+VanSize-20);
    } else if (Heading.equals("Left")) {
      image(flipImg(flipImg(STruckRot1, "X"), "Y"), OnScreenVX, OnScreenVY, VanSize, VanSize);
      ps.SetPos(VX+VanSize, VY+VanSize-20);
    }
    fill(255);
    //text(Vel+"", OnScreenVX, OnScreenVY, VanSize, VanSize);
  }
  boolean IsPathBlock(float X, float Y) {
    color tile = MAP.get(int(X/BlockSize), int(Y/BlockSize));

    //Tar 
    if (tile == color(5, 0, 0, 255)) {
      return true;
    } else {
      return false;
    }
  }
  boolean IsSolid(float X, float Y) {
    try {
      color tile = MAP.get(int(X/BlockSize), int(Y/BlockSize));

      //Tar 
      if (tile == color(4, 0, 0, 255)) {
        return true;
      } else {
        return false;
      }
    }
    catch(Exception e) {
      return false;
    }
  }
  color GetBlock(float X, float Y) {
    try {
      color tile = MAP.get(int(X/BlockSize), int(Y/BlockSize));

      return tile;
    }
    catch(Exception e) {
      return color(0, 0, 0, 0);
    }
  }
  void drive() {




    if (Vel < topSpeed) {
      //Vel = topSpeed;
      Vel+=0.1;
    }
    if (IsPathBlock(VX+20, VY+BlockSize) && !Heading.equals("Up")) {
      VY+=getSpeedPerFrame(Vel);
      Heading = "Down";
    } else if (IsPathBlock(VX+BlockSize, VY) && !Heading.equals("Left")) {
      VX+=getSpeedPerFrame(Vel);
      Heading = "Right";
    } else if (IsPathBlock(VX, VY-BlockSize) && !Heading.equals("Down")) {
      VY-=getSpeedPerFrame(Vel);
      Heading = "Up";
    } else if (IsPathBlock(VX-BlockSize, VY) && !Heading.equals("Right")) {
      VX-=getSpeedPerFrame(Vel);
      Heading = "Left";
    } else {
      Vel = 0;
    }
    if (!Heading.equals(OldHeading)) {
      Vel = TurnSpeed; 
      OldHeading = Heading;
    }
  }
}



class Guard {
  //TODO make it so there is a seprate PImage for each state so it increses fps

  int GuardX;
  int GuardY;
  int OGuardX;
  int OGuardY;
  int GSpeed = 4;

  int SaveGXTP;
  int SaveGYTP;

  int Health;
  int MaxHealth;

  int OnScreenGX;
  int OnScreenGY;
  int GuardGoingTo = 0;
  float DistFromP;
  float DistFromObjective;
  String Heading = "NULL";

  int RespawnX;
  int RespawnY;
  Guard(int SpawnX, int SpawnY, int SpawnHealth) {
    GuardX = SpawnX*BlockSize;
    GuardY = SpawnY*BlockSize;
    Health = SpawnHealth;
    MaxHealth = SpawnHealth;


    RespawnX = SpawnX;
    RespawnY = SpawnY;
  }
  void go() {
    OnScreenGX = GuardX+round(PlayerX);
    OnScreenGY = GuardY+round(PlayerY);
    if ((OnScreenGX > 0 && OnScreenGX < width && OnScreenGY > 0 && OnScreenGY < height) && Health > 0) {

      this.displayGard();
    }

    if (dist(PlayerOffsetX, PlayerOffsetY, OnScreenGX, OnScreenGY) < width+height && Health > 0) {

      this.moveGard();
    }
    if (this.Health < 1) {
      SpawnX = this.RespawnX;
      SpawnY = this.RespawnY;
      Health = this.MaxHealth;
    }
  }
  void displayGard() {
    OnScreenGX = GuardX+round(PlayerX);
    OnScreenGY = GuardY+round(PlayerY);
    //image(loadImg(player, 0, 30, 16, 16, false), OnScreenGX, OnScreenGY, PlayerWidth, PlayerHeight);


    //Get shot


    fill(255, 0, 0);
    rect(OnScreenGX, OnScreenGY-10, MaxHealth, 5);
    fill(0, 255, 0);
    rect(OnScreenGX, OnScreenGY-10, Health, 5);
    if (Health < 0) {
    } else if (mouseLifted() && inArea(mouseX, mouseY, OnScreenGX, OnScreenGY, PlayerWidth, PlayerHeight) && Inv[SelectedItem].equals("Pistol")) {

      Health -=WeaponDmg[0];
    }



    if (second() % 2 == 0) {
      image(GuardLegUp1, OnScreenGX, OnScreenGY, PlayerWidth, PlayerHeight);
    } else {
      image(GuardLegUp2, OnScreenGX, OnScreenGY, PlayerWidth, PlayerHeight);
    }
    //fill(255);
    //text(DistFromP, OnScreenGX, OnScreenGY);
  }
  void pushBackG() {
    if (OGuardX != PlayerX) {
      GuardX = GuardX + (OGuardX - GuardX);
    }
    if (OGuardY != GuardY) {
      GuardY = GuardY + (OGuardY - GuardY);
    }
  }
  boolean IsPathBlock(int X, int Y) {
    color tile = MAP.get(int(X/BlockSize), int(Y/BlockSize));

    //round(X/BlockSize);  
    //round(Y/BlockSize);  
    if (tile == color(6, 0, 0, 255)) {
      return true;
    } else {
      return false;
    }
  }
  void moveGard() {
    OGuardX = GuardX;
    OGuardY = GuardY;

    DistFromP = dist(OnScreenGX, OnScreenGY, (width/2), (height/2));


    if (DistFromP < 200 && dead == false) {
      if (IsPathBlock(GuardX, GuardY)) {
        SaveGXTP = GuardX;
        SaveGYTP = GuardY;
      }
      //dead = true;
      if (GuardX-GSpeed > abs(PlayerX-(width/2))) {
        GuardX-=getSpeedPerFrame(GSpeed);
      } else if (GuardX+GSpeed < abs(PlayerX-(width/2))) {
        GuardX+=getSpeedPerFrame(GSpeed);
      }
      if (GuardY-GSpeed > abs(PlayerY-(height/2))) {
        GuardY-=getSpeedPerFrame(GSpeed);
      } else if (GuardY+GSpeed < abs(PlayerY-(height/2))) {
        GuardY+=getSpeedPerFrame(GSpeed);
      } else {
        //GuardX = abs(PlayerX-(width/2));
        //GuardY = abs(PlayerY-(height/2));
      }
      //GPtrlRouteX[GuardGoingTo] = (PlayerX+(width/2));
      //GPtrlRouteY[GuardGoingTo] = (PlayerY+(height/2));

      if (DistFromP < 10) {
        dead = true; 
        DeathMSG = "Avoid the Guards...";

        GuardX = SaveGXTP;
        GuardY = SaveGYTP;
      }
    } else {
      //DistFromObjective = dist(GuardX,GuardY,GPtrlRouteX[GuardGoingTo],GPtrlRouteY[GuardGoingTo]);
      /*if(GuardX-GSpeed > GPtrlRouteX[GuardGoingTo]*BlockSize){
       GuardX-=GSpeed;
       }else if(GuardX+GSpeed < GPtrlRouteX[GuardGoingTo]*BlockSize){
       GuardX+=GSpeed;
       }if(GuardY-GSpeed > GPtrlRouteY[GuardGoingTo]*BlockSize){
       GuardY-=GSpeed;
       }else if(GuardY+GSpeed < GPtrlRouteY[GuardGoingTo]*BlockSize){
       GuardY+=GSpeed;
       }else if(DistFromObjective < GSpeed){
       if(GuardGoingTo < GPtrlRouteX.length-1){
       GuardGoingTo++;  
       }else{
       GuardGoingTo--;  
       }
       }else{
       //GuardX = GPtrlRouteX[GuardGoingTo];
       //GuardY = GPtrlRouteY[GuardGoingTo];
       }*/
      if (IsPathBlock(GuardX, GuardY+BlockSize) && !Heading.equals("UP")) {
        GuardY+=GSpeed;
        Heading = "DOWN";
      } else if (IsPathBlock(GuardX+BlockSize, GuardY) && !Heading.equals("LEFT")) {
        GuardX+=GSpeed;
        Heading = "RIGHT";
      } else if (IsPathBlock(GuardX, GuardY-BlockSize) && !Heading.equals("DOWN")) {
        GuardY-=GSpeed;
        Heading = "UP";
      } else if (IsPathBlock(GuardX-BlockSize, GuardY) && !Heading.equals("RIGHT")) {
        GuardX-=GSpeed;
        Heading = "LEFT";
      } else {
        GuardX = SaveGXTP;
        GuardY = SaveGYTP;
      }
    }
    if (IsBlockSolid(GuardX, GuardY)) {
      this.pushBackG();
    }
  }
}
class NPC {
  int X;
  int Y;
  String Name;
  int OnScreenGX;
  int OnScreenGY;
  String Said = "";
  int Clicks = -1;
  boolean speaking = false;
  boolean selling = true;
  String[] SellItems;
  String[] Text;
  int Buyid = 0;

  NPC(int NPCSpawnX, int NPCSpawnY, String SpawnName, String[] Selling, String[] SpawnText) {
    this.X = NPCSpawnX;
    this.Y = NPCSpawnY;
    this.Name = SpawnName;
    SellItems = Selling.clone();
    Text = SpawnText;
  }
  void RunAll() {
    OnScreenGX = this.X+round(PlayerX);
    OnScreenGY = this.Y+round(PlayerY);
    if (OnScreenGX > 0 && OnScreenGX < width && OnScreenGY > 0 && OnScreenGY < height) {
      image(loadImg(player, 0, 30, 16, 16, false), OnScreenGX, OnScreenGY, PlayerWidth, PlayerHeight);
      this.SayStuff();
    }
  }

  void SayStuff() {
    textAlign(CENTER, CENTER);
    textSize(20);
    if (inArea(width/2, height/2, OnScreenGX-10, OnScreenGY-30, PlayerWidth, PlayerHeight+30)) { 

      if (mouseLifted() && inArea(mouseX, mouseY, (width/2)-60, height-160, 120, 50) && dead == false) {
        fill(0, 0, 0, 150);
        speaking = true;
        try {
          if (Text[Clicks].contains("buy")) {
            Buyid+=2;
          }
        }
        catch(Exception e) {
        }


        Clicks++;
      } else {
        fill(25, 25, 25, 100);
      }
      rect((width/2)-60, height-160, 120, 50);
      fill(255);

      text("Speak!", (width/2)-60, height-160, 120, 50);
    } else {
      speaking = false;
      Clicks = -1;
      Buyid = 0;
    }
    fill(255);
    textSize(11);

    if (speaking) {
      try {

        text(Say(Text[Clicks]+" //"+Clicks, false), OnScreenGX-50, OnScreenGY-60, PlayerWidth+100, PlayerHeight+10);

        if (Text[Clicks].contains("buy")) {
          try {
            shop(SellItems[Buyid], int(SellItems[Buyid+1]));
          }
          catch(Exception e) {
            Buyid = 0;
          }
        }
        //buy
        //
      }
      catch(Exception e) {
        Clicks = 0;
      }

      if (Clicks > 98) {
        Clicks = 0;
      }
    } else {
      textSize(20);

      text("?", OnScreenGX+5, OnScreenGY-40, PlayerWidth/2, PlayerHeight);
    }
    textAlign(LEFT, TOP);
    textSize(12);
  }

  void shop(String Item, int Price) {
    if (inArea(mouseX, mouseY, (width/2)-60, height-220, 120, 50) && dead == false) {
      fill(0, 0, 0, 150);
      if (mouseLifted()) {
        //speaking = false;

        if (Coins >= Price) {
          text(Say("Thanks man, watch out for the guards sneaking around //"+Clicks, false), OnScreenGX-50, OnScreenGY-60, PlayerWidth+100, PlayerHeight+10);
          GiveItem(Item);
          Coins -= Price;
        } else {
          text(Say("Sorry you dont have enouph money, good luck with the raid. //"+Clicks, false), OnScreenGX-50, OnScreenGY-60, PlayerWidth+100, PlayerHeight+10);
        }
      }
    } else {
      fill(25, 25, 25, 100);
    }
    rect((width/2)-60, height-220, 120, 50);
    fill(255);
  }
  int saidCharNum = 0;
  boolean AddChars(String Msg) {
    int msGLength = Msg.length();
    try {
      if (saidCharNum != -1) {
        Said = Said + Msg.charAt(saidCharNum);
      }
    }
    catch(Exception e) {
      saidCharNum = -1;

      return true;
    }
    saidCharNum ++;
    if (saidCharNum > msGLength-1) {
      return true;
    } else {
      return false;
    }
  }
}


boolean IsBlockSolid(int X, int Y) {
  color tile = MAP.get(int(X/BlockSize), int(Y/BlockSize));

  //round(X/BlockSize);  
  //round(Y/BlockSize);  
  if (tile == color(4, 0, 0, 255)) {
    //Fence
    return true;
  } else {
    return false;
  }
}






boolean inArea(int X, int Y, int x, int y, int w, int h) {
  if (X > x && Y > y && X < x+w && Y < y+h) {
    return true;
  } else {
    return false;
  }
}
boolean mouseLifted() {
  if (mouseP == true && mousePressed == false) {
    return true;
  } else {
    return false;
  }
}

PImage flipImg(PImage file, String side) {

  //TODO
  PImage ramImg = createImage(file.width, file.height, ARGB);
  int ramCount = 0;

  if (side.equals("X")) {
    for (int i = 0; i < file.width; i++) {
      for (int j = file.height; j > 0; ) {

        color ramCol;
        ramCol = file.get(j-1, i);

        try {
          ramImg.pixels[ramCount] = ramCol;

          ramCount++;
        }
        catch(Exception e) {
        }
        j--;
      }
    }
  } else if (side.equals("Y")) {
    for (int i = file.width; i > 0; i--) {
      for (int j = 0; j < file.height; ) {

        color ramCol;
        ramCol = file.get(j, i-1);

        try {
          ramImg.pixels[ramCount] = ramCol;

          ramCount++;
        }
        catch(Exception e) {
        }
        j++;
      }
    }
  } 
  ramImg.updatePixels();
  return ramImg;
}
PImage loadImg(PImage file, int cropWStart, int cropHStart, int cropWStop, int cropHStop, Boolean Rot90) {

  PImage ramImg = createImage(cropWStop, cropHStop, ARGB);

  int ramCount = 0;


  for (int i = 0; i < cropWStop; i++) {
    for (int j = 0; j < cropHStop; j++) {

      color ramCol;
      if (Rot90 == false) {
        ramCol = file.get(cropWStart+j, cropHStart+i);
      } else {
        ramCol = file.get(cropWStart+i, cropHStart+j);
      }

      try {
        //fiter this color out
        if (ramCol != -9568146) {
          ramImg.pixels[ramCount] = ramCol;
        }
        ramCount++;
      }
      catch(Exception e) {
        //TODO: optimise this so the try catch is not needed, try print out ramCount
      }
    }
  }
  ramImg.updatePixels();
  return ramImg;
}


PImage shadeImg(PImage file, int X, int Y, float intensity) {

  PImage ramImg = file.copy();

  int ramCount = 0;


  for (int i = 0; i < file.width; i++) {
    for (int j = 0; j < file.height; j++) {

      color ramCol;
      float distFromLight = dist(X, Y, i, j);

      ramCol = file.get(i, j);
      int lightToAdd = 0;

      if (distFromLight < intensity) {
        lightToAdd = round(intensity - distFromLight);
      }

      color insertCol = color(red(ramCol)+lightToAdd, green(ramCol)+lightToAdd, blue(ramCol)+lightToAdd);

      //distFromLight
      ramImg.pixels[ramCount] = insertCol;
      ramCount++;
    }
  }
  ramImg.updatePixels();
  return ramImg;
}


int lastRun; //the last time in millisecs it ran
int charAddNum; //the position that the adding is at
String RamAdderText = ""; //the text to return
Boolean doneWithStatment = true; // basicly a reset
String lastText = "";
String Say(String Text, boolean skip) {
  int textLength = Text.length();
  if (doneWithStatment) {
    lastRun = 0;
    charAddNum = 0;
    RamAdderText = "";
    doneWithStatment = false;
  }
  // //"
  if (lastRun != millis() && textLength > charAddNum) {
    lastRun = second();
    try {
      RamAdderText = RamAdderText + Text.charAt(charAddNum);
    }
    catch(Exception e) {
    }
    charAddNum++;
  }
  if (skip) {
    RamAdderText = Text;
  }
  if (lastText.equals(Text)) {
    RamAdderText = lastText;
  }
  if (RamAdderText.equals(Text)) {
    doneWithStatment = true;
    lastText = RamAdderText;
  }
  for (int i = 0; i < 10; i++) {
    RamAdderText = RamAdderText.replace("//"+i, "");
    RamAdderText = RamAdderText.replace("//"+i+"0", "");
  }
  return RamAdderText;
}



void pushBackPlayer() {
  if (OldPlayerX != PlayerX) {
    PlayerX = PlayerX + (OldPlayerX - PlayerX);
  }
  if (OldPlayerY != PlayerY) {
    PlayerY = PlayerY + (OldPlayerY - PlayerY);
  }
}

void move() {
  if (keyPressed) {

    //TODO make it so speed is concistent no matter the frame rate
    //TODO add boarders
    walking = true;
    if (dead == false) {
      if (keyCode == UP  && PlayerY < PlayerOffsetY) {
        fceing = "Up";
        PlayerY+=getSpeedPerFrame(PlayerSpeed);//PlayerSpeed;
      } else if (keyCode == DOWN && abs(PlayerY-PlayerOffsetY)+BlockSize < MHeight*BlockSize) {
        //print(PlayerY);
        fceing = "Down";
        PlayerY-=getSpeedPerFrame(PlayerSpeed);//PlayerSpeed;
      } else if (keyCode == LEFT && PlayerX < PlayerOffsetX) {
        fceing = "Left";
        facing = "Left";
        PlayerX+=getSpeedPerFrame(PlayerSpeed);//PlayerSpeed;
      } else if (keyCode == RIGHT && abs(PlayerX-PlayerOffsetX)+BlockSize < MWidth*BlockSize) {
        fceing = "Right";
        facing = "Right";
        PlayerX-=getSpeedPerFrame(PlayerSpeed);//PlayerSpeed;
      }
    }
    if (!OnV) {
      if (DevTools == true) {
        PlayerSpeed = 10;
      } else {
        PlayerSpeed = MaxPlayerSpeed;
      }
    }
  } else {
    //not walking 
    walking = false;
  }
}

void GenCode() {

  MAP.updatePixels();
  MAP.save("MapOutput"+minute()+".png");
}

void drawPlayer() {
  PlayerOffsetX = width/2;
  PlayerOffsetY = height/2;


  FootSteps.run();//FootSteps

  if (showPlayer) {
    if (walking) {
      FootSteps.SetPos(round(PlayerOffsetX-PlayerX)+13, round(PlayerOffsetY-PlayerY)+player.height-30);

      FootSteps.addParticle();

      if (second() % 2 == 0) {
        if (facing.equals("Right")) {
          image(loadImg(player, 0, 30, 16, 16, dead), PlayerOffsetX, PlayerOffsetY, PlayerWidth, PlayerHeight);
        } else {
          image(loadImg(player, 16, 30, 16, 16, dead), PlayerOffsetX, PlayerOffsetY, PlayerWidth, PlayerHeight);
        }
      } else {
        if (facing.equals("Right")) {
          image(loadImg(player, 0, 15, 16, 16, dead), PlayerOffsetX, PlayerOffsetY, PlayerWidth, PlayerHeight);
        } else {
          image(loadImg(player, 16, 15, 16, 16, dead), PlayerOffsetX, PlayerOffsetY, PlayerWidth, PlayerHeight);
        }
      }
    } else {
      if (facing.equals("Right")) {
        image(loadImg(player, 0, 0, 16, 16, dead), PlayerOffsetX, PlayerOffsetY, PlayerWidth, PlayerHeight);
      } else {
        image(loadImg(player, 16, 0, 16, 16, dead), PlayerOffsetX, PlayerOffsetY, PlayerWidth, PlayerHeight);
      }
    }
  }
}
void buildMode() {
  fill(255);
  for (int i = 0; i < 50; i++) {
    rect(0, i*RectSize, RectSize, RectSize);  
    if (i == 0) {
      image(Grass, 0, i*RectSize, RectSize, RectSize);
    } else if (i == 1) {
      image(Dirt, 0, i*RectSize, RectSize, RectSize);
    } else if (i == 2) {
      image(Floor, 0, i*RectSize, RectSize, RectSize);
    } else if (i == 3) {
      image(Floor, 0, i*RectSize, RectSize, RectSize);
      image(Fence, 0, i*RectSize, RectSize, RectSize);
    } else if (i == 4) {
      image(Tar, 0, i*RectSize, RectSize, RectSize);
    } else if (i == 5) {
      fill(0);
      text("Path Block (retextures to block to grass)", 0, i*RectSize, RectSize, RectSize);
      fill(255);
    } else if (i == 6) {
      image(Tar, 0, i*RectSize, RectSize, RectSize);
      image(TrafficCone, 0, i*RectSize, RectSize, RectSize);
    } else if (i == 7) {
      image(Wall, 0, i*RectSize, RectSize, RectSize);
    }
    if (mousePressed && inArea(mouseX, mouseY, 0, i*RectSize, RectSize, RectSize)) {
      if (i == 0) {
        //Grass
        Placing = color(1, 0, 0, 255);
      } else if (i == 1) {
        //Dirt
        Placing = color(2, 0, 0, 255);
      } else if (i == 2) {
        //Floor
        Placing = color(3, 0, 0, 255);
      } else if (i == 3) {
        //Fence
        Placing = color(4, 0, 0, 255);
      } else if (i == 4) {
        //Fence
        Placing = color(5, 0, 0, 255);
      } else if (i == 5) {
        //Path Block (retextures to block to grass)
        Placing = color(6, 0, 0, 255);
      } else if (i == 6) {
        //Path Block (retextures to block to grass)
        Placing = color(7, 0, 0, 255);
      } else if (i == 7) {
        //Path Block (retextures to block to grass)
        Placing = color(8, 0, 0, 255);
      } else if (i == 15) {
        //Path Block (retextures to block to grass)
        GenCode();
      }
      //PressingGui = true;
    } else {
      //PressingGui = false;
    }
  }
}
void PressMap(int X, int Y, int Width, int Height) {


  try {
    for (int i = 0; i < MWidth; i++) {
      for (int j = 0; j < MHeight; j++) {
        if ((i*Width)+X < width && (j*Height)+Y < height && ((i+1)*Width)+X > 0 && ((j+1)*Height)+Y > 0) {

          if (mouseX > (i*Width)+X && mouseY > (j*Height)+Y && mouseX < ((i*Width)+X)+Width && mouseY < ((j*Height)+Y)+Width && mouseX > RectSize) {
            //Map[i][j] = Placing;
            if (mousePressed) {
              MAP.set(i, j, Placing);
            }
            //print(i+":I  J:"+j+"\n");
            //overTileX = i;
            //overTileY = j;
          }
        }
      }
    }
  }
  catch(Exception e) {
    print(""+e);
  }
}





void GiveItem(String item) {

  for ( int i = 0; i < Inv.length; i ++) {
    if (Inv[i].equals("") && isBuilding == false) {
      Inv[i] = item;
      break;
    }
  }
}
void pauseButton() {
  fill(0, 0, 0, 150);

  rect(width-30, 3, 25, 25, 5);
  //pause
  fill(255, 255, 255, 250);
  if (settingsOpen) {
    text("<", width-30, 3, 25, 25);
  } else if (paused) {
    triangle(width-26, 7, width-10, 14, width-26, 24);
  } else {
    rect(width-26, 7, 8, 17, 5);
    rect(width-16, 7, 8, 17, 5);
  }
  if (mouseLifted() && inArea(mouseX, mouseY, width-30, 3, 25, 25)) {
    if (paused) {
      paused = false;
      DispMenu = "Playing";
    } else {
      paused = true;
      DispMenu = "paused";
    }
    SettingsTitleOffset = -width;
    settingsOpen = false;
  }
}
void GUI() {

  if (isBuilding) {
    buildMode();
  }




  //XP
  //for (int i = 0; i < xp/5; i ++) {
  //image(loadImg(icons, 15, 0, 16, 16, false), width-(((i*40))), 10, 50, 50);
  //}
  //Coins
  fill(255);
  image(loadImg(icons, 16, 0, 16, 16, false), 0, 40, 30, 30);
  text(Coins, 30, 45); 

  for (int i = 0; i < Health/2; i ++) {
    image(Heart, (((i*35))), 10, 30, 30);
  }  
  if (Health < 0) {
    dead = true;
  }



  if (Health < MaxHealth+1 && second() % 2 == 0 && HealTick == false) {
    HealTick = true;
    Health++;
  }
  if (second() % 2 != 0) {
    HealTick = false;
  }
  //xp++;


  //Inventory
  for (int i = 0; i < Inv.length; i++) {
    if (i == SelectedItem) {
      fill(0, 0, 0, 150);
    } else {
      fill(25, 25, 25, 100);
    }

    rect(((width/2)+i*60)-((Inv.length/2)*60), height-100, 50, 50);
    if (inArea(mouseX, mouseY, ((width/2)+i*60)-((Inv.length/2)*60), height-100, 50, 50)) {
      if (mousePressed) {
        SelectedItem = i;
      } else if (!Inv[i].equals("")) {
        fill(25, 25, 25, 100);
        rect((((width/2)+i*60)-((Inv.length/2)*60))-10, height-120, 70, 15); 
        fill(255);
        textSize(10);
        text(Inv[i], (((width/2)+i*60)-((Inv.length/2)*60))-10, height-120, 70, 15);  
        textSize(14);
      }
    }

    fill(255);
    switch(Inv[i]) {
    case "Wire-Cutters":
      image(WireCutters, ((width/2)+i*60)-((Inv.length/2)*60), height-100, 50, 50);
      break;
    case "Pistol":
      image(Pistol, ((width/2)+i*60)-((Inv.length/2)*60), height-100, 50, 50);
      if (Inv[SelectedItem].equals("Pistol")) {
        image(GunCrosshair, mouseX-(GunCrosshair.width/2), mouseY-(GunCrosshair.height/2));
        if (mouseLifted()) {
          //Shoot.stop();        
          Shoot.play(); 

          Shake(5);
          //KillThings
          //TODO
          //Kill Guards on line 580
        }
      }
      break;
    case "Dynamite":
      image(Dynamite, ((width/2)+i*60)-((Inv.length/2)*60), height-100, 50, 50);
      if (Inv[SelectedItem].equals("Dynamite")) {
        if (mouseLifted()) {
          LaunchItem tnt = new LaunchItem(round(PlayerOffsetX),round(PlayerOffsetY),mouseX,mouseY,100);
          if(tnt.getDone()){
            tnt.setImg(Dynamite,50,50);
            tnt.setDone(false);
          }
          tnt.runAll();
          Explosion.play();
        }
      }

      break;
    case "Traffic Cone":
      image(TrafficCone, ((width/2)+i*60)-((Inv.length/2)*60), height-100, 50, 50);
      break;
    default:
      text(Inv[i], ((width/2)+i*60)-((Inv.length/2)*60), height-100, 50, 50);
      break;
    }
  }

  //Cooldown
  if (Cooldown > 0) {
    Cooldown  -=getSpeedPerFrame(2);
    if (Cooldown < 0) {
      Cooldown = 0;
    }
  }
  text(Cooldown, mouseX, mouseY);

  if (dead) {
    fill(255, 0, 0, 200);
    rect(0, 0, width, height);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(40);
    text("Dead!", width/2, height/2);
    textSize(20);
    text(DeathMSG, width/2, (height/2)+60);


    /*
   fill(#B9B9B9);
     rect((width/2)-60,(height/2)+100,100,30);
     fill(#CECECE);
     rect((width/2)-60,(height/2)+100,120,50);
     */
    if (inArea(mouseX, mouseY, (width/2)-60, (height/2)+100, 120, 50)) {
      fill(#CECECE);
      if (mouseLifted()) {
        dead = false;
        Health = MaxHealth;
        PlayerX = SpawnX;
        PlayerY = SpawnY;
      }
    } else {
      fill(#B9B9B9);
    }

    rect((width/2)-60, (height/2)+100, 120, 50);


    fill(0);
    text("Respawn", width/2, (height/2)+120);
    textSize(12);
    textAlign(LEFT, TOP);
  }
}
/*void loadMap(int X, int Y, int Width, int Height) {
 
 
 try {
 for (int i = 0; i < Width; i++) {
 for (int j = 0; j < Height; j++) {
 if ((i*Width)+X < width && (j*Height)+Y < height && ((i+1)*Width)+X > 0 && ((j+1)*Height)+Y > 0) {
 
 if (Map[i][j].equals("G")) {
 image(Grass, i*Width, j*Height, Width, Width);
 } else if (Map[i][j].equals("D")) {
 image(Dirt, i*Width, j*Height, Width, Width);
 }
 if (mousePressed && mouseX > (i*Width)+X && mouseY > (j*Height)+Y && mouseX < ((i*Width)+X)+Width && mouseY < ((j*Height)+Y)+Width) {
 //Map[i][j] = "D";
 }
 }
 }
 }
 }
 catch(Exception e) {
 print(""+e);
 }
 }*/
void setMap(int X, int Y, color type) {
  MAP.set(X, Y, type);
}
void doMapInteractions(int X, int Y) {

  //fence
  if (MAP.get(X, Y) == color(4, 0, 0, 255) || MAP.get(X, Y) == color(8, 0, 0, 255)) {

    setMap(X, Y, color(3, 0, 0, 255));
  }
}
void loadMap(int X, int Y, int Width, int Height) {


  try {
    for (int i = 0; i < MWidth; i++) {
      for (int j = 0; j < MHeight; j++) {

        if ((i*Width)+X < width && (j*Height)+Y < height && ((i+1)*Width)+X > 0 && ((j+1)*Height)+Y > 0) {


          if (inArea(mouseX, mouseY, (i*Width)+X, (j*Height)+Y, Width, Width)) {
            MouseXOnGrid = i;
            MouseYOnGrid = j;
            //print(MouseXOnGrid +"  "+MouseYOnGrid+"\n");
          }

          color tile = MAP.get(i, j);
          color tileR = color(0, 0, 0);
          color tileL = color(0, 0, 0) ;
          color tileU = color(0, 0, 0);
          color tileD = color(0, 0, 0);
          if (!(i < 0 || i > MWidth-1 || j > MHeight-1 || j < 0)) {
            tileR = MAP.get(i+1, j);
            tileL = MAP.get(i-1, j);
            tileU = MAP.get(i, j-1);
            tileD = MAP.get(i, j+1);
          }
          //TODO fix it so its "Width, Height", not "Width, Width"
          if (tile == color(1, 0, 0, 255)) {
            //Grass
            image(Grass, (i*Width)+X, (j*Height)+Y, Width, Height);
          } else if (tile == color(2, 0, 0, 255)) {
            //Dirt
            image(Dirt, (i*Width)+X, (j*Height)+Y, Width, Height);
          } else if (tile == color(3, 0, 0, 255)) {
            //Floor
            image(Floor, (i*Width)+X, (j*Height)+Y, Width, Height);
          } else if (tile == color(4, 0, 0, 255)) {
            //Fence
            image(Floor, (i*Width)+X, (j*Height)+Y, Width, Height);
            if (!(i < 0 || i > MWidth-1 || j > MHeight-1 || j < 0)) {
              if (tileD == color(4, 0, 0, 255) && tileL == color(4, 0, 0, 255)) {
                image(FenceCR, (i*Width)+X, (j*Height)+Y, Width, Height);
              } else if (tileL == color(4, 0, 0, 255) && tileU == color(4, 0, 0, 255)) {

                image(flipImg(FenceCR, "Y"), (i*Width)+X, (j*Height)+Y, Width, Height);
              } else if (tileR == color(4, 0, 0, 255) && tileD == color(4, 0, 0, 255)) {

                image(flipImg(FenceCR, "X"), (i*Width)+X, (j*Height)+Y, Width, Height);
              } else if (tileU == color(4, 0, 0, 255) && tileR == color(4, 0, 0, 255)) {
                image(FenceC, (i*Width)+X, (j*Height)+Y, Width, Width);
              } else if (tileD == color(4, 0, 0, 255) || tileU == color(4, 0, 0, 255)) {
                image(Fence, (i*Width)+X, (j*Height)+Y, Width, Height);
              } else {
                image(FenceR, (i*Width)+X, (j*Height)+Y, Width, Height);
              }
            }
            if (inArea(PlayerOffsetX+PlayerWidth/2, PlayerOffsetY+PlayerHeight/2, (i*Width)+X, (j*Height)+Y, Width, Width)) {
              Health--;
              if (dead == true) {
                //String DeathMSGS[] = {"Find a way to cut the fence", "It hurts!", "Cmon' dont die to a fence"};

                DeathMSG = "Find a way to cut the fence";
              }
              //break fence if player is in a truck/van/stuff
              //print(PlayerSpeed+"\n");
              if (OnV == false || PlayerSpeed < blockHardnesses[3]+1) {
                pushBackPlayer();
              } else if (PlayerSpeed > blockHardnesses[3]) {
                PlayerSpeed = 5;
                setMap(i, j, color(3, 0, 0, 255));

                hitSomthing = true;
              }
            } else if (Cooldown < 1 && mousePressed && Inv[SelectedItem].equals("Wire-Cutters") && inArea(mouseX, mouseY, (i*Width)+X, (j*Height)+Y, Width, Width)) {
              MAP.set(i, j, color(3, 0, 0, 255));
              if (!ClipFence.isPlaying()) {
                ClipFence.play();
              } else {
                ClipFence.stop();
                ClipFence.play();
              }
              Cooldown = 100;
            }
          } else if (tile == color(8, 0, 0, 255)) {
            image(Floor, (i*Width)+X, (j*Height)+Y, Width, Height);
            if (!(i < 0 || i > MWidth-1 || j > MHeight-1 || j < 0)) {
              for (int fe = 0; fe < 2; fe++) {
                int f = 0;
                if (fe == 0) {
                  f = 4;
                }
                if (tileD == color(4+f, 0, 0, 255) && tileL == color(4+f, 0, 0, 255)) {
                  image(FenceCR, (i*Width)+X, (j*Height)+Y, Width, Height);
                } else if (tileL == color(4+f, 0, 0, 255) && tileU == color(4+f, 0, 0, 255)) {

                  image(flipImg(FenceCR, "Y"), (i*Width)+X, (j*Height)+Y, Width, Height);
                } else if (tileR == color(4+f, 0, 0, 255) && tileD == color(4+f, 0, 0, 255)) {

                  image(flipImg(FenceCR, "X"), (i*Width)+X, (j*Height)+Y, Width, Height);
                } else if (tileU == color(4+f, 0, 0, 255) && tileR == color(4+f, 0, 0, 255)) {
                  image(FenceC, (i*Width)+X, (j*Height)+Y, Width, Width);
                } else if (tileD == color(4+f, 0, 0, 255) || tileU == color(4+f, 0, 0, 255)) {
                  image(Fence, (i*Width)+X, (j*Height)+Y, Width, Height);
                } else if (tileL == color(4+f, 0, 0, 255) || tileR == color(4+f, 0, 0, 255)) {
                  image(FenceR, (i*Width)+X, (j*Height)+Y, Width, Height);
                }
              }
            }
            if (inArea(PlayerOffsetX+PlayerWidth/2, PlayerOffsetY+PlayerHeight/2, (i*Width)+X, (j*Height)+Y, Width, Width)) {
              Health--;
              if (dead == true) {
                //String DeathMSGS[] = {"Find a way to cut the fence", "It hurts!", "Cmon' dont die to a fence"};

                DeathMSG = "Find a way to cut the fence";
              }
              //break fence if player is in a truck/van/stuff
              //print(PlayerSpeed+"\n");
              if (OnV == false || PlayerSpeed < blockHardnesses[3]+1) {
                pushBackPlayer();
              } else if (PlayerSpeed > blockHardnesses[3]) {
                PlayerSpeed = 5;
                setMap(i, j, color(3, 0, 0, 255));

                hitSomthing = true;
              }
            } else if (Cooldown < 1 && mousePressed && Inv[SelectedItem].equals("Wire-Cutters") && inArea(mouseX, mouseY, (i*Width)+X, (j*Height)+Y, Width, Width)) {
              MAP.set(i, j, color(3, 0, 0, 255));
              if (!ClipFence.isPlaying()) {
                ClipFence.play();
              } else {
                ClipFence.stop();
                ClipFence.play();
              }
              Cooldown = 100;
            }
            if (DevVis) {
              fill(255, 0, 0, 100);
              rect((i*Width)+X, (j*Height)+Y, Width, Height);
            }
          } else if (tile == color(5, 0, 0, 255)) {
            //tar
            image(Tar, (i*Width)+X, (j*Height)+Y, Width, Height);
            //Place trafic cones
            if (mouseLifted() && Inv[SelectedItem].equals("Traffic Cone") && inArea(mouseX, mouseY, (i*Width)+X, (j*Height)+Y, Width, Width)) {
              MAP.set(i, j, color(7, 0, 0, 255));
              Inv[SelectedItem] = "";
            }
          } else if (tile == color(6, 0, 0, 255)) {
            //Path Block (retextures to block to the left of this one)
            image(Grass, (i*Width)+X, (j*Height)+Y, Width, Height);
            if (DevVis) {
              fill(255, 0, 0, 100);
              rect((i*Width)+X, (j*Height)+Y, Width, Height);
            }
          } else if (tile == color(7, 0, 0, 255)) {
            //Traffic Cone Block
            image(Tar, (i*Width)+X, (j*Height)+Y, Width, Height);
            image(TrafficCone, (i*Width)+X, (j*Height)+Y, Width, Height);
            if (mouseLifted() && inArea(mouseX, mouseY, (i*Width)+X, (j*Height)+Y, Width, Width) && isBuilding == false) {
              MAP.set(i, j, color(5, 0, 0, 255));
              GiveItem("Traffic Cone");
            }
          } else if (tile == color(8, 0, 0, 255)) {

            //image(Wall, (i*Width)+X, (j*Height)+Y, Width, Height);


            if (tileD == color(8, 0, 0, 255) || tileU == color(8, 0, 0, 255)) {
              image(Wall, (i*Width)+X, (j*Height)+Y, Width, Height);
            } else {
              image(WallRot, (i*Width)+X, (j*Height)+Y, Width, Height);
            }
          } else if (tile == color(9, 0, 0, 255)) {
            image(Grass, (i*Width)+X, (j*Height)+Y, Width, Height);
            image(Easel, (i*Width)+X, (j*Height)+Y, Width, Height);
            if (inArea(PlayerOffsetX+PlayerWidth/2, PlayerOffsetY+PlayerHeight/2, (i*Width)+X, (j*Height)+Y, Width, Width)) {
              pushBackPlayer();
            }
          }
          /*if (mousePressed && mouseX > (i*Width)+X && mouseY > (j*Height)+Y && mouseX < ((i*Width)+X)+Width && mouseY < ((j*Height)+Y)+Width && PressingGui == false) {
           Map[i][j] = Placing;
           }*/
        }
      }
    }
  }
  catch(Exception e) {
    print(""+e);
  }
}
/*void loadMap(int X, int Y, int Width, int Height) {
 
 
 try {
 for (int i = 0; i < Width; i++) {
 for (int j = 0; j < Height; j++) {
 if ((i*Width)+X < width && (j*Height)+Y < height && ((i+1)*Width)+X > 0 && ((j+1)*Height)+Y > 0) {
 if (Map[i][j].equals("G")) {
 image(Grass, (i*Width)+X, (j*Height)+Y, Width, Width);
 } else if (Map[i][j].equals("D")) {
 image(Dirt, (i*Width)+X, (j*Height)+Y, Width, Width);
 } else if (Map[i][j].equals("F")) {
 image(Floor, (i*Width)+X, (j*Height)+Y, Width, Width);
 } else if (Map[i][j].equals("Fence")) {
 image(Floor, (i*Width)+X, (j*Height)+Y, Width, Width);
 if (!(i < 1 || i > Width-1 || j > Height-1 || j < 1)) {
 if (Map[i][j+1].equals("Fence") && Map[i-1][j].equals("Fence")) {
 image(FenceCR, (i*Width)+X, (j*Height)+Y, Width, Width);
 } else if (Map[i-1][j].equals("Fence") && Map[i][j-1].equals("Fence")) {
 
 image(flipImg(FenceCR, "Y"), (i*Width)+X, (j*Height)+Y, Width, Width);
 } else if (Map[i+1][j].equals("Fence") && Map[i][j+1].equals("Fence")) {
 
 image(flipImg(FenceCR, "X"), (i*Width)+X, (j*Height)+Y, Width, Width);
 } else if (Map[i][j-1].equals("Fence") && Map[i+1][j].equals("Fence")) {
 image(FenceC, (i*Width)+X, (j*Height)+Y, Width, Width);
 } else if (Map[i][j+1].equals("Fence") || Map[i][j-1].equals("Fence")) {
 image(Fence, (i*Width)+X, (j*Height)+Y, Width, Width);
 } else {
 image(FenceR, (i*Width)+X, (j*Height)+Y, Width, Width);
 }
 }
 if (inArea(PlayerOffsetX+PlayerWidth/2, PlayerOffsetY+PlayerHeight/2, (i*Width)+X, (j*Height)+Y, Width, Width)/*PlayerOffsetX > (i*Width)+X && PlayerOffsetY > (j*Height)+Y && PlayerOffsetX < ((i*Width)+X)+Width && PlayerOffsetY < ((j*Height)+Y)+Width)) {
 Health--;
 pushBackPlayer();
 }
 }
 if (mousePressed && mouseX > (i*Width)+X && mouseY > (j*Height)+Y && mouseX < ((i*Width)+X)+Width && mouseY < ((j*Height)+Y)+Width) {
 //Map[i][j] = "D";
 }
 }
 }
 }
 }
 catch(Exception e) {
 print(""+e);
 }
 }*/
float getSpeedPerFrame(float speedPer60frames) {
  float speedPerFrame = speedPer60frames*60;

  return speedPerFrame/frameRate;
}

// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  int LifeTime;
  PImage img;
  float Xvel;
  float Yvel;
  int Fadedness;
  boolean randomVel;

  ParticleSystem(PImage LoadImg, int X, int Y, float XVel, float YVel, int Life, int StartFadedness, boolean Scatter) {
    origin = new PVector(X, Y);
    particles = new ArrayList<Particle>();
    try {
      img = LoadImg.copy();
    }
    catch(Exception e) {
    }
    LifeTime = Life;
    Xvel = XVel;
    Yvel = YVel;
    Fadedness = StartFadedness;
    randomVel = Scatter;
  }

  void SetPos(int X, int Y) {
    origin = new PVector(X, Y);
  }

  void addParticle() {
    particles.add((new Particle(img, origin, Xvel, Yvel, LifeTime, Fadedness, randomVel)));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}


// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float OriginalLife;
  int Fadedness;
  PImage img;
  Particle(PImage LoadImg, PVector l, float XVel, float YVel, int Life, int StartFadedness, boolean randomVel) {
    acceleration = new PVector(XVel, YVel);
    if (randomVel == false) {
      velocity = new PVector(random(-1, 1), random(-2, 0));
    } else {
      velocity = new PVector(0, 0);
    }
    position = l.copy();
    lifespan = Life;
    OriginalLife = Life;
    try {
      img = LoadImg.copy();
    }
    catch(Exception e) {
    }
    Fadedness = StartFadedness;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    stroke(255, lifespan);
    fill(255, lifespan);
    //ellipse(position.x, position.y, 8, 8);
    tint(255, ((lifespan/OriginalLife)*255)-(255-Fadedness));
    try {
      //    OnScreenVX = VX+round(PlayerX);
      image(img, position.x+round(PlayerX), position.y+round(PlayerY));
    }
    catch(Exception e) {
      //ellipse(position.x, position.y, 8, 8);
    }
    tint(255, 255);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}


int SliderX = 0;
float Slider(int X, int Y, int Width, int Height, int MinVal, int MaxVal) {

  if (mousePressed && inArea(mouseX, mouseY, X, Y, Width-((MaxVal/9)-11)/*MaxVal-MinVal*/, Height)) {

    SliderX = mouseX;
  }

  float Div = (((SliderX)-X)+MinVal)/MaxVal;
  float Value = (((SliderX)-X)+MinVal)/(Div+1);
  if (Value > MaxVal) {
    Value = MaxVal;
  } else if (Value < -1) {
    Value = 0;
  }

  noStroke();
  //Slider Bar
  fill(255);
  rect(X, Y, Width/*MaxVal-MinVal*/, Height);
  //Slider Handle
  fill(230);
  rect(SliderX, Y, Width/10, Height);




  return (Value);
}
void multiplayer() {

  if (ServerStarted) {
    if (Connected) {


      if (mousePressed) {
        pressingMouse = 1;
      } else {
        pressingMouse = 0;
      }
      if (walking || mousePressed) {
        s.write(round((-PlayerX)+PlayerOffsetX) + " " + round((-PlayerY)+PlayerOffsetY) + " " + MouseXOnGrid + " " + MouseYOnGrid + " " + pressingMouse + "\n");
      }

      // Receive data from client
      c = s.available();
      if (c != null) {
        input = c.readString(); 
        input = input.substring(0, input.indexOf("\n"));  // Only up to the newline
        data = int(split(input, ' '));  // Split values into an array


        Player2X = abs(round(int(data[0])));
        Player2Y = abs(round(int(data[1])));
        try {
          if (data[4] == 1) {
            doMapInteractions(data[2], data[3]);
          }//inArea(data[3], data[4], (i*Width)+X, (j*Height)+Y, Width, Width)
        }
        catch(Exception e) {
        }
        //print("Received: "+data[0]+"  "+data[1]+"\n");
      }
    } else {
      //Server
      try {
        s = new Server(this, 12345, "127.0.0.1");  // Start a simple server on a port


        Connected = true;
      }
      catch(Exception e) {
        print(e);
        //Connected = false;
      }
    }
    //ellipse(Player2X + PlayerX, Player2Y + PlayerY, 100, 100);

    image(loadImg(player, 0, 30, 16, 16, false), Player2X + PlayerX, Player2Y + PlayerY, PlayerWidth, PlayerHeight);
  }
}
void gameSettings() {
  fill(20, 20, 20);
  rect(-1, -1, width+2, height+2);

  fill(255);
  noStroke();
  rect(-1+SettingsTitleOffset, 100, width-200, 100);
  triangle((width-201)+SettingsTitleOffset, 100, (width-201)+SettingsTitleOffset, 200, (width-100)+SettingsTitleOffset, 200);
  stroke(0);
  fill(0);
  textSize(80);
  textAlign(LEFT, CENTER);
  text("Settings", 20, 90, width-200, 100);
  textSize(10);
  if (SettingsTitleOffset < 0) {
    SettingsTitleOffset+=50;
  }


  //Settings
  frameRate(maxFrameRate);
  fill(255);
  //bar
  rect(SettingsTitleOffset+50, 400, 200, 50);
  //slider
  rect(maxFrameRate+(50-15), 400, 20, 50);
  fill(0);
  text(maxFrameRate+"", maxFrameRate+(50-15), 400, 20, 50);
  //title
  fill(255);
  textSize(20);
  text("Max FPS:", (50-15), 380);
  textSize(12);

  if (mousePressed && inArea(mouseX, mouseY, SettingsTitleOffset+50, 400, 200, 50)) {
    if (mouseX-(50-15) > 205) {
      maxFrameRate = 100000000;
    } else {
      maxFrameRate = mouseX-(50-15); //50 but to make it so you cant go under 15 frames we subtract 15
    }
  }
  MainTheme.amp(Slider(20, 700, 300, 50, -1, 1));
  //cursor(WireCutters);


  //Set Up server
  fill(255);
  textSize(20);
  text("Play With friends:", (50-15), 480);
  textSize(12);

  if (mousePressed && inArea(mouseX, mouseY, 50, 500, 100, 50)) {
    //Start Lan Server
    ServerStarted = true;
    //Start
    ServerType = "Server";
    Connected = false;
  }

  if (mousePressed && inArea(mouseX, mouseY, 50, 560, 100, 50)) {
    //Start Lan Server
    ServerStarted = true;
    //Join
    ServerType = "Join";
    Connected = false;
  }    

  rect(50, 500, 100, 50);
  rect(50, 560, 100, 50);

  fill(0);
  text("Start LAN Server", 50, 500, 100, 50);
  text("Join LAN Server", 50, 560, 100, 50);
}



int visualX[] = {0, 0, 0, 0, 0};
boolean hasSeenSign = false;
void parallax() {
  if (!CreitsTheme.isPlaying()) {
    MainTheme.stop();
    CreitsTheme.play();
  }

  for (int i = 0; i < 200; i++) {
    if (i == 0) {
      visualX[i]-=getSpeedPerFrame(10/5);
    } else if (i == 1) {
      visualX[i]-=getSpeedPerFrame(10/4);
    } else if (i == 2) {
      visualX[i]-=getSpeedPerFrame(10/3);
    } else if (i == 3) {
      visualX[i]-=getSpeedPerFrame(10/2);
    } else if (i == 4) {
      visualX[i]-=getSpeedPerFrame(10);
      if (visualX[i] < -width*2) {
        hasSeenSign = true;
      }
      print(visualX[i]+"\n");
    }

    //float BackgroundWidth =  width*((sqrt(b1.width)/10)/4);
    //float BackgroundHeight = height*((sqrt(b1.height)/10)/3);
    float BackgroundWidth =  b1.width;
    float BackgroundHeight = b1.height;
    while (BackgroundWidth < width) {
      if (BackgroundWidth < width || BackgroundHeight < height) {

        BackgroundWidth = BackgroundWidth * 2;
        BackgroundHeight = BackgroundHeight * 2;
      }
    }





    image(b1, (visualX[0]/*/5*/)+BackgroundWidth*i, 0, BackgroundWidth, BackgroundHeight);
    image(b2, (visualX[1])+BackgroundWidth*i, 0, BackgroundWidth, BackgroundHeight);
    image(b3, (visualX[2])+BackgroundWidth*i, 0, BackgroundWidth, BackgroundHeight);
    image(b4, (visualX[3])+BackgroundWidth*i, 0, BackgroundWidth, BackgroundHeight);
    if (hasSeenSign == false) {
      image(b5, (visualX[4])+BackgroundWidth*i, 0, BackgroundWidth, BackgroundHeight);
    }
  }
}

int frameRatePos;
boolean resizingGraph = false;
void graph() {
  fps.addPoint(frameRatePos, frameRate); 
  if (keyPressed) {
    if (key == 's') {
      openGraph = true;
    } else if (key == 'h') {
      openGraph = false;
    }
  }

  if (openGraph) {

    if (millis() % 2 == 0) {

      frameRatePos ++;
    }

    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Draw Plot
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    if (resizingGraph) {
      fps.setDim(mouseX, mouseY);
    }
    if (keyPressed && key == 'r') {

      resizingGraph = true;
    } else {
      resizingGraph = false;
    }




    fps.beginDraw();
    fps.drawBackground();
    fps.drawBox();
    fps.drawXAxis();
    fps.drawYAxis();
    fps.drawTitle();
    fps.drawGridLines(GPlot.BOTH);
    fps.drawPoints();
    fps.endDraw();
  }
}

void debug() {
  fill(0);
  text("FPS: "+ frameRate, 20, height-20);
}

void Shake(int Amt) {
  ShakeLimits = Amt;
}
void UpdateShake() {
  translate(random(-ShakeLimits, ShakeLimits), random(-ShakeLimits, ShakeLimits));
  if (ShakeLimits > 0) {
    ShakeLimits --;
  }
}
void draw() {
  clear();

  UpdateShake();


  if (DispMenu.equals("Playing")) {
    background(SkyColor);

    global_time += getSpeedPerFrame(timeSpeed);
    loadMap(round(PlayerX), round(PlayerY), BlockSize, BlockSize);

    OldPlayerX = round(PlayerX);
    OldPlayerY = round(PlayerY);



    NPC1.RunAll();
    G1.go();
    Van1.runAll();


    move();
    drawPlayer();


    if (isBuilding) {
      PressMap(round(PlayerX), round(PlayerY), BlockSize, BlockSize);
    }

    //G1.displayGard();

    GUI();
    pauseButton();



    if (!MainTheme.isPlaying()) {
      MainTheme.play();
    }
  } else if (DispMenu.equals("MainMenu")) {
    background(SkyColor);
    loadMap(round(PlayerX), round(PlayerY), BlockSize, BlockSize);
    fill(0, 0, 0, 100);
    rect(-1, -1, width+2, height+2);
    noStroke();
    if (inArea(mouseX, mouseY, width/2-(150/2), height/2-30, 150, 60)) {
      fill(0, 0, 0, 200);
      if (mouseLifted()) {
        DispMenu = "TeamSelect";
      }
    } else {
      fill(0, 0, 0, 100);
    }
    rect(width/2-(150/2), height/2-30, 150, 60);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(40);
    text("Play", width/2-(150/2), height/2-30, 150, 60);

    //Credits Button

    if (inArea(mouseX, mouseY, width/2-(150/2), height/2+50, 150, 60)) {
      fill(0, 0, 0, 200);
      if (mouseLifted()) {
        DispMenu = "Credits";
      }
    } else {
      fill(0, 0, 0, 100);
    }
    rect(width/2-(150/2), height/2+50, 150, 60);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(40);
    text("Credits", width/2-(150/2), height/2+50, 150, 60);


    textAlign(TOP, LEFT);
    textSize(12);
  } else if (DispMenu.equals("TeamSelect")) {


    background(SkyColor);
    loadMap(round(PlayerX), round(PlayerY), BlockSize, BlockSize);

    noStroke();
    if (inArea(mouseX, mouseY, 0, 0, width/2, height)) {
      fill(0, 0, 0, 200);
      if (mouseLifted()) {
        //
        DispMenu = "Playing";
        Team = "Naruto Runner";
        MaxPlayerSpeed = 12;
      }
    } else {
      fill(0, 0, 0, 100);
    }

    //Left rectangle
    rect(0, 0, width/2, height);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(40);
    text("Naruto Runner", 0, 0, width/2, height);
    //Right Rect
    if (inArea(mouseX, mouseY, width/2, 0, width/2, height)) {
      fill(0, 0, 0, 200);
      if (mouseLifted()) {
        DispMenu = "Playing";
        Team = "Nomad";
      }
    } else {
      fill(0, 0, 0, 100);
    }
    rect(width/2, 0, width/2, height);


    fill(255);
    text("Nomad", width/2, 0, width/2, height);

    textAlign(TOP, LEFT);
  } else if (DispMenu.equals("Credits")) {
    //TODO bit image files lag
    //Paralax Credits
    if (loadingCreditsFiles) {
      CreitsTheme = new SoundFile(this, "Credits_Theme.mp3");
      b1 = loadImage("/Paralax_Files/Sky.png");
      b2 = loadImage("/Paralax_Files/ufo.png");
      b3 = loadImage("/Paralax_Files/mountains.png");
      b4 = loadImage("/Paralax_Files/grassyHills.png");
      b5 = loadImage("/Paralax_Files/sign.png");
      loadingCreditsFiles = false;
    }

    parallax();
  } else if (settingsOpen || paused) {
    if (paused) {
      fill(20, 20, 20, 20);
      rect(-1, -1, width+2, height+2);

      if (inArea(mouseX, mouseY, (width/2)-60, (height/2)+80, 120, 50)) {
        fill(255, 255, 255, 100);
        if (mouseLifted()) {
          settingsOpen = true;
          paused = false;
        }
      } else {
        fill(255, 255, 255, 150);
      }
      rect((width/2)-60, (height/2)+80, 120, 50);
    } else if (settingsOpen) {
      gameSettings();
    }
    pauseButton();
  } 





  if (mousePressed) {
    mouseP = true;
  } else {
    mouseP = false;
  }
  if (DevTools) {
    if (Inv[SelectedItem].equals("Dev Wand")) {
      isBuilding = true;
    } else if (Inv[SelectedItem].equals("Speed Wand")) {
      PlayerSpeed = 50;
      isBuilding = false;
    } else {
      isBuilding = false;
    }
  }
  graph();
  debug();


  multiplayer();
}
