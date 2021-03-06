ArrayList<PVector>stuck;
void setup(){
  size(500,500);
  pixelDensity(2);
  stuck=new ArrayList<PVector>();
  stuck.add(new PVector(width/2,height/2));
  //stuck.add(new PVector(width/2,0));
}
float rad=2;
float fract(float f){
  float fract= f-floor(f);
  return cos(TWO_PI*fract)/2+0.5;
}
int iters=0;
void draw(){
  background(0);
  for(int i=0;i<10;i++)doPoint();
  for(PVector p:stuck){
    //fill(255,0,0);
    colorMode(HSB,100);
    fill(color(fract(p.z*0.00005)*100,100,100));
    noStroke();
    ellipse(p.x,p.y,rad,rad);
  }
}
boolean notTouching(PVector p){
  for(PVector p1:stuck){
    if(dist(p.x,p.y,p1.x,p1.y)<rad)return false;
  }
  return true;
}
PVector createNewVector(){
  int i=int(random(4));
  if(i==0)return new PVector(random(width),0);
  if(i==1)return new PVector(random(width),height);
  if(i==2)return new PVector(0,random(width));
  if(i==3)return new PVector(height,random(width));
  return new PVector(0,0);
}
float marg=-100;
void doPoint(){
  iters++;
  PVector p=createNewVector();
  while(notTouching(p)){
    p.x+=random(-5,5);
    p.y+=random(-5,5);
    if(p.x<0)p.x=width;
    if(p.y<0)p.y=height;
    if(p.x>width)p.x=0;
    if(p.y>height)p.y=0;
  }
  p.z=iters;
  stuck.add(p);
}