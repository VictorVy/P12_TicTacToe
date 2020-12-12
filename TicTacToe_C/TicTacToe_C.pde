//client
import processing.net.*;

Client client;

Cell[][] grid = new Cell[3][3];

int posAX = 100;
int posAY = 200;
int cellSize = 200;
int posBX = posAX + cellSize * 3;
int posBY = posAY + cellSize * 3;

boolean turn = false;

void setup()
{
  size(800, 1000);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  strokeWeight(8);
  
  client = new Client(this, "127.0.0.1", 1234);
  
  setupGrid();
}

void draw()
{
  background(0);
  
  listen();
  
  drawCells();
  drawGrid();
  
  textUI();
}

void setupGrid()
{
  for(int r = 0; r < 3; r++)
  {
    int y = posAY + cellSize / 2 + cellSize * r;
    
    for(int c = 0; c < 3; c++)
    {
      int x = posAX + cellSize / 2 + cellSize * c;
      
      grid[r][c] = new Cell(x, y, cellSize, r, c, -1);
    }
  }
}

void listen()
{
  if(client.available() > 0)
  {
    String incoming = client.readString();
    grid[int(incoming.substring(0, 1))][int(incoming.substring(2))].cMode = 1;
    
    turn = !turn;
  }
}

void drawGrid()
{  
  stroke(255);
  
  //decor
  line(0, posAY - cellSize / 4, width, posAY - cellSize / 4);
  line(0, posBY + cellSize / 4, width, posBY + cellSize / 4);
  line(posAX - cellSize / 4, 0, posAX - cellSize / 4, height);
  line(posBX + cellSize / 4, 0, posBX + cellSize / 4, height);
  
  //horizontal
  line(posAX, posAY + cellSize, posBX, posAY + cellSize);
  line(posAX, posBY - cellSize, posBX, posBY - cellSize);
  //vertical
  line(posAX + cellSize, posAY, posAX + cellSize, posBY);
  line(posBX - cellSize, posAY, posBX - cellSize, posBY);
}

void drawCells()
{
  for(int r = 0; r < 3; r++)
  {
    for(int c = 0; c < 3; c++)
      grid[r][c].show();
  }
}

void textUI()
{
  textSize(100);
  fill(255);
  
  text("tic tac toe", width / 2, 50 + cellSize / 32);
  
  textSize(75);
  
  text(turn ? "your turn" : "waiting...", width / 2, (height - 50) - cellSize / 5);
}

void clickCells()
{
  for(int r = 0; r < 3; r++)
  {    
    for(int c = 0; c < 3; c++)
    {
      Cell cell = grid[r][c];
      
      if(turn && cell.cMode == -1 && cell.mHover())
      {
        client.write(r + "," + c);        
        cell.cMode = 0;
        
        turn = !turn;
      }
    }
  }
}

void mouseReleased()
{
  if(mouseX > posAX && mouseX < posBX && mouseY > posAY && mouseY < posBY)
    clickCells();
}
