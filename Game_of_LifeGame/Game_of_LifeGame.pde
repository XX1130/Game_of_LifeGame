int[][] cell =new int[300][300];
int[][] savedCell=new int[300][300];
int cellSize=8;

boolean edit1Player=true;
boolean editPlayer=true;

boolean gameStart;
int translateMatrixX=0;
int translateMatrixY=0;

void setup()
{
  size(1600,800);
  background(255);
  
  gameStart=false;
  
  for(int i=0; i< cell.length; i++)
  {
    for(int j=0; j< cell[i].length; j++)
    {
      cell[i][j]=0;
    }
  }
  
  //initialCell
  
}

void draw()
{
  background(255);
  
  translate(translateMatrixX,translateMatrixY);
  
  if(gameStart)
  {
    judgeLifeCoreProcesse();
  }
  else
  {
    drawInitialLife();
  }
  
  if(countCellValue()==0)
  {
    gameStart=false;
  }
  
  //preDrawBlockLine();
  
  debag();
}

void judgeLifeCoreProcesse()
{
  saveCell();
  
  for(int i=1; i<cell.length-1; i++)
  {
    for(int j=1; j<cell[i].length-1;j++)
    {
      int countAroundCell1=0;
      int countAroundCell2=0;
      
      int[] counts=judgeLifeFirstFase(i,j);
      countAroundCell1=counts[0];
      countAroundCell2=counts[1];
      
      judgeLifeSecondFase(i,j,countAroundCell1,countAroundCell2);
      judgeLifeDrawFase(i,j);
    }
  }
}

void saveCell()
{
  for(int i=0; i<cell.length; i++)
  {
    for(int j=0; j<cell[i].length; j++)
    {
      savedCell[i][j]=cell[i][j];
    }
  }
}

int[] judgeLifeFirstFase(int i,int j)
{
  int c1=0;
  int c2=0;
  
  int[][] cellDirection = {
    {-1,-1},{0,-1},{1,-1},
    {-1,0},      {1,0},
    {-1,1},{0,1},{1,1}
  };
  
  for(int[] cDir : cellDirection)
  {
    int ni = i+cDir[0];
    int nj = j+cDir[1];
    
    if(savedCell[ni][nj]==1)
    {
      c1++;
    }
    else if(savedCell[ni][nj]==2)
    {
      c2++;
    }
  }
  
  return new int[]{c1,c2};
}

void judgeLifeSecondFase(int i, int j, int c1, int c2)
{
  int randomOrder=(int)random(2);
  
  //2pのセル優先
  if(randomOrder==0)
  {
    if(cell[i][j]==1 && c1<2)
    {
      cell[i][j]=0;
    }
    if(cell[i][j]==2 && c2<2)
    {
      cell[i][j]=0;
    }
    
    if(cell[i][j]==1 || cell[i][j]==2)
    {
      if(2<=c1 && c1<4)
      {
        cell[i][j]=1;
      }
      else if(c1>3)
      {
        cell[i][j]=0;
      }
      
      if(2<=c2 && c2<4)
      {
        cell[i][j]=2;
      }
      else if(c2>3)
      {
        cell[i][j]=0;
      }
    }

    if(savedCell[i][j]==0)
    {
      if(c1==3)
      {
        cell[i][j]=1;
      }
      if(c2==3)
      {
        cell[i][j]=2;
      }
    }
  }
  
  //1pのセル優先
  else if(randomOrder==1)
  {
    if(cell[i][j]==1 && c1<2)
    {
      cell[i][j]=0;
    }
    else if(cell[i][j]==2 && c2<2)
    {
      cell[i][j]=0;
    }
      
    if(cell[i][j]==1 || cell[i][j]==2)
    {
      if(2<=c2 && c2<4)
      {
        cell[i][j]=2;
      }
      else if(c2>3)
      {
        cell[i][j]=0;
      }
      
      if(2<=c1 && c1<4)
      {
        cell[i][j]=1;
      }
      else if(c1>3)
      {
        cell[i][j]=0;
      }
    }
    
    if(savedCell[i][j]==0)
    {
      if(c2==3)
      {
        cell[i][j]=2;
      }
      else if(c1==3)
      {
        cell[i][j]=1;
      }
    }
  }
}

void judgeLifeDrawFase(int i,int j)
{
  if(cell[i][j]==0)
  {
    fill(255);
  }
  else if(cell[i][j]==1)
  {
    fill(0,0,255);
  }
  else if(cell[i][j]==2)
  {
    fill(0,255,0);
  }
  else
  {
    fill(128,128,128);
  }
  stroke(0);
  rect(cellSize*i,cellSize*j,cellSize,cellSize);
}

void drawInitialLife()
{
  for(int i=0; i<cell.length;i++)
  {
    for(int j=0; j<cell[i].length; j++)
    {
      judgeLifeDrawFase(i,j);
    }
  }
  
  stroke(255,100,255);
  line(cellSize*cell.length/2, 0, cellSize*cell.length/2, cellSize*cell.length);
  line(0, cellSize*cell.length/2, cellSize*cell.length, cellSize*cell.length/2);
}

int countCellValue()
{
  int samAllCell=0;
  for(int i=0; i<cell.length; i++)
  {
    for(int j=0; j<cell[i].length; j++)
    {
      samAllCell=samAllCell+cell[i][j];
    }
  }
  return samAllCell;
}

void preDrawBlockLine()
{
  for(int i=0; i<cell.length; i++)
  {
    for(int j=0; j<cell[i].length; j++)
    {
      drawBlockLine(i,j);
    }
  }
}

void drawBlockLine(int i,int j)
{
  fill(0,0,0,0);
  stroke(255,0,0);
  rect(cellSize*30*i,cellSize*30*j,cellSize*30,cellSize*30);
  
  stroke(255,100,255);
  line(cellSize*cell.length/2, 0, cellSize*cell.length/2, cellSize*cell.length);
  line(0, cellSize*cell.length/2, cellSize*cell.length, cellSize*cell.length/2);
}

void mousePressed()
{
  int cmX=(mouseX-translateMatrixX)/cellSize;
  int cmY=(mouseY-translateMatrixY)/cellSize;
  
  if(!gameStart)
  {
    if(editPlayer)
    {
      if(edit1Player)
      {
        if(cell[cmX][cmY]==1)
        {
          cell[cmX][cmY]=0;
        }
        else
        {
          cell[cmX][cmY]=1;
        }
      }
      else
      {
        if(cell[cmX][cmY]==2)
        {
          cell[cmX][cmY]=0;
        }
        else
        {
          cell[cmX][cmY]=2;
        }
      }
    }
    else
    {
      if(cell[cmX][cmY]==3)
      {
        cell[cmX][cmY]=0;
      }
      else
      {
        cell[cmX][cmY]=3;
      }
    }
  }
}

void keyPressed()
{
  //start
  if(keyCode==ENTER)
  {
    if(gameStart==false)
    {
      gameStart=true;
    }
    else 
    {
      gameStart=false;
    }
  }
  
  //changeEditSide
  if(keyCode==SHIFT)
  {
    if(edit1Player)
    {
      edit1Player=false;
    }
    else
    {
      edit1Player=true;
    }
  }
  
  if(keyCode==TAB)
  {
    if(editPlayer)
    {
      editPlayer=false;
    }
    else
    {
      editPlayer=true;
    }
  }
  
  //movement of viewpoint
  movementOfViewpoint();
}

void movementOfViewpoint()
{
boolean isEdgeX=true;
  boolean isEdgeY=true;
  if(translateMatrixX>=0 || translateMatrixX<=width-(cell.length*cellSize))
  {
    isEdgeX=true;
  }
  else
  {
    isEdgeX=false;
  }
  
  if(translateMatrixY>=0 || translateMatrixY<=height-(cell[1].length*cellSize))
  {
    isEdgeY=true;
  }
  else
  {
    isEdgeY=false;
  }
  
  if(isEdgeX)
  {
    if(translateMatrixX>=0)
    {
      if(keyCode==RIGHT)
      {
        translateMatrixX=translateMatrixX-4;
      }
    }
    else if(translateMatrixX<=(cell.length*cellSize)-width)
    {
      if(keyCode==LEFT)
      {
        translateMatrixX=translateMatrixX+4;
      }
    }
  }
  else
  {
    if(keyCode==RIGHT)
    {
      translateMatrixX=translateMatrixX-4;
    }
    if(keyCode==LEFT)
    {
      translateMatrixX=translateMatrixX+4;
    }
  }
  
  if(isEdgeY)
  {
    if(translateMatrixY>=0)
    {
      if(keyCode==DOWN)
      {
        translateMatrixY=translateMatrixY-4;
      }
    }
    else if(translateMatrixY>=height-(cell[1].length*cellSize))
    {
      if(keyCode==UP)
      {
        translateMatrixY=translateMatrixY+4;
      }
    }
  }
  else
  {
    if(keyCode==DOWN)
    {
      translateMatrixY=translateMatrixY-4;
    }
    if(keyCode==UP)
    {
      translateMatrixY=translateMatrixY+4;
    }
  }
}

void debag()
{
}
