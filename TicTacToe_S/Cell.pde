class Cell
{
  int x, y, size, row, column, cMode;
  
  public Cell(int x, int y, int size, int row, int column, int cMode)
  {
    this.x = x;
    this.y = y;
    this.size = size;
    this.row = row;
    this.column = column;
    this.cMode = cMode;
  }
  
  void show()
  {
    noStroke();
    fill(255, mHover() ? 64 : 0);
    square(x, y, cellSize);
    
    stroke(255);
    fill(255);
    
    switch(cMode)
    {
      case 0:
        noFill();
        circle(x, y, cellSize / 1.75);
        break;
      case 1:
        line(x - cellSize / 4, y - cellSize / 4, x + cellSize / 4, y + cellSize / 4);
        line(x - cellSize / 4, y + cellSize / 4, x + cellSize / 4, y - cellSize / 4);
        break;
    }
  }
  
  boolean mHover(){ return mouseX > x - cellSize / 2 && mouseX < x + cellSize / 2 && mouseY > y - cellSize / 2 && mouseY < y + cellSize / 2; }
  
  //void test(){ if(mHover()) println(row + ", " + column); }
}
