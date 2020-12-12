Cell[][] grid = new Cell[3][3];

int posA = 100;
int cellSize = 200;
int posB = posA + cellSize * 3;

boolean turn;

void setup()
{
  size(800, 800);
  rectMode(CENTER);
  strokeWeight(8);
  
  setupGrid();
}

void draw()
{
  background(0);
  
  drawCells();
  drawGrid(); 
}

void setupGrid()
{
  for(int r = 0; r < 3; r++)
  {
    int y = posA + cellSize / 2 + cellSize * r;
    
    for(int c = 0; c < 3; c++)
    {
      int x = posA + cellSize / 2 + cellSize * c;
      
      grid[r][c] = new Cell(x, y, cellSize, r, c, -1);
    }
  }
}

void drawGrid()
{  
  stroke(255);
  
  //decor
  line(0, posA - cellSize / 4, width, posA - cellSize / 4);
  line(0, posB + cellSize / 4, width, posB + cellSize / 4);
  line(posA - cellSize / 4, 0, posA - cellSize / 4, height);
  line(posB + cellSize / 4, 0, posB + cellSize / 4, height);
  
  //horizontal
  line(posA, posA + cellSize, posB, posA + cellSize);
  line(posA, posB - cellSize, posB, posB - cellSize);
  //vertical
  line(posA + cellSize, posA, posA + cellSize, posB);
  line(posB - cellSize, posA, posB - cellSize, posB);
}

void drawCells()
{
  for(int r = 0; r < 3; r++)
  {
    for(int c = 0; c < 3; c++)
      grid[r][c].show();
  }
}

void clickCells()
{
  for(int r = 0; r < 3; r++)
  {    
    for(int c = 0; c < 3; c++)
    {
      Cell cell = grid[r][c];
      
      if(cell.cMode == -1 && cell.mHover())
      {
        cell.cMode = turn ? 0 : 1;
        turn = !turn;
      }
    }
  }
}

void mouseReleased()
{
  if(mouseX > posA && mouseX < posB && mouseY > posA && mouseY < posB)
    clickCells();
}
