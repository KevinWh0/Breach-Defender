ParticleSystem ps;
PImage imgSample;
void setup() {
  size(640, 360);
  imgSample = loadImage("s.jpg");
  ps = new ParticleSystem(imgSample,width/2,100);
}

void draw() {
  background(0);


  ps.addParticle();
  ps.run();
}


// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  PImage img;
  ParticleSystem(PImage LoadImg, int X, int Y) {
    origin = new PVector(X, Y);
    particles = new ArrayList<Particle>();
    img = LoadImg.copy();

  }

  void addParticle() {
    particles.add((new Particle(img,origin)));
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

  PImage img;
  Particle(PImage LoadImg,PVector l) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = l.copy();
    lifespan = 255.0;
    //img = LoadImg.copy();
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
    ellipse(position.x, position.y, 8, 8);
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
