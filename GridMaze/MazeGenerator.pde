abstract class MazeGenerator{
  abstract Grid generateMaze(int w,int h);
  abstract PVector getColorScalar();
  void update(){}
  void display(){}
  boolean isDone(){
    return false;
  }
  //abstract PVector getT
}