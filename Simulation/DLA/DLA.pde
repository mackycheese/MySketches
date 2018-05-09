float colSpeed=0.0025;

//1000x1000,10000,0.01
void setup() {
  size(1024, 1024);
  //size(500,500);
  //size(1000, 1000);
  //fullScreen();
  seed=new Thing(width/2, height/2);
  seed.done=true;
  seed.r=50;
  seed.col=color(255, 200, 200);
  for (int i=0; i<10000; i++) {
    things.add(new Thing(random(width), random(height)));
  }
  things.add(seed);
}
int numDone=0;
void draw() {
  background(0);
  surface.setTitle("DLA, frameRate="+nf(frameRate, 2, 3)+", numNotDone="+numNotDone());
  //for (int i=0; i<5; i++) {
  //if(numDone<600)
  //for(int i=0;i<30;i++)things.add(new Thing(random(width), random(height)));
  //}
  //for (int k=0; k<10; k++) {
  ArrayList<Thing>toRem=new ArrayList<Thing>();
  for (Thing t : things) {
    t.update(frameCount);
    if (t.dead)toRem.add(t);
  }
  things.removeAll(toRem);
  for (int i=0; i<toRem.size(); i++) {
    things.add(new Thing(random(width), random(height)));
    //}
  }
  for (Thing t : things) {
    if(!t.done)continue;
    t.display();
  }
  seed.display();
  if (numNotDone()>0) {
    saveFrame("data/frame-#####.png");
  }
}
int numNotDone() {
  int i=0;
  for (Thing t : things) {
    if (!t.done)i++;
  }
  return i;
}
Thing seed;
ArrayList<Thing>things=new ArrayList<Thing>();
class Thing {
  float x, y;
  float r;
  color stroke=color(250);
  color col;
  boolean done=false;
  Thing(float x, float y) {
    this.x=x;
    this.y=y;
    this.r=5;
    this.col=color(255);
  }
  void display() {
    fill(col);
    //stroke(stroke);
    noStroke();
    ellipseMode(CENTER);
    ellipse(x, y, r, r);
  }
  boolean dead=false;
  void update(int frames) {
    if (done)return;
    float a=10;
    if (x<a)dead=true;
    if (y<a)dead=true;
    if (x>width-a)dead=true;
    if (y>height-a)dead=true;
    if (collides()) {
      //if(collidesOther()){
      done=true;
      numDone++;
      //col=color(255, 200, 200);
      colorMode(HSB, 100);
      col=color((frameCount*colSpeed)%100, 100, 100);
      colorMode(RGB, 255);
    } else {

      x+=random(-2, 2);
      y+=random(-2, 2);
    }
    //r+=1;
  }
  boolean collides() {
    for (Thing t : things) {
      if (t==this)continue;
      if (!t.done)continue;
      if (collides(t))return true;
    }
    return false;
  }
  boolean collidesOther() {
    for (Thing t : things) {
      if (t==this)continue;
      //if (!t.done)continue;
      if (collides(t))return true;
    }
    return false;
  }
  boolean collides(Thing other) {
    return dist(x, y, other.x, other.y)<other.r/2+r/2;
  }
}