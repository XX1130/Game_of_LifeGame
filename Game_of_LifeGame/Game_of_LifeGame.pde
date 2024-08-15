int[][] cell =new int[300][300];
int[][] savedCell=new int[300][300];
int cellSize=8;

boolean edit1Player=true;
boolean editPlayer=true;

boolean isShip=false;
boolean isHeavyweightSpaceShip=false;
boolean isLightweightSpaceShip=false;

boolean gameStart;
int translateMatrixX=0;
int translateMatrixY=0;
int cmX;
int cmY;

int startTime;
int currentTime;

//______________________________sounds_______________________________
import processing.sound.*;
int soundsLength=8;
SoundFile[] sound=new SoundFile[soundsLength];
int[] soundTime = new int[soundsLength];
boolean[] interval=new boolean[soundsLength];
//___________________________________________________________________

void setup()
{
  size(1600,800);
  background(255);
  
  //__________________sounds__________________________________________________________
  sound[0] = new SoundFile(this, "/sounds/001_zundamon_voicebox_yuseinanoda.wav");
  sound[1] = new SoundFile(this, "/sounds/002_zundamon_voicebox_resseinanoda.wav");
  sound[2] = new SoundFile(this, "/sounds/003_zundamon_voicebox_kusozakoinoda.wav");
  sound[3] = new SoundFile(this, "/sounds/004_zundamon_voicebox_mazuinoda.wav");
  sound[4] = new SoundFile(this, "/sounds/005_zundamon_voicebox_kusoge-nanoda.wav");
  sound[5] = new SoundFile(this, "/sounds/006_zundamon_voicebox_kutabarenanoda.wav");
  sound[6] = new SoundFile(this, "/sounds/007_zundamon_voicebox_maketanoda.wav");
  sound[7] = new SoundFile(this, "/sounds/008_zundamon_voicebox_startnanoda.wav");
  
  for(int i=0; i<soundTime.length;i++)
  {
    soundTime[i]=millis();
  }
  //___________________________________________________________________________________

  gameStart=false;
  
  for(int i=0; i< cell.length; i++)
  {
    for(int j=0; j< cell[i].length; j++)
    {
      cell[i][j]=0;
    }
  }
  
  //initialCell
  initialLife1();
}

void draw()
{
  currentTime=millis();
  
  background(255);
  
  pushMatrix();
  translate(translateMatrixX,translateMatrixY);
  cmX=(mouseX-translateMatrixX)/cellSize;
  cmY=(mouseY-translateMatrixY)/cellSize;
  
  if(gameStart)
  {
    judgeLifeCoreProcesse();
    
  }
  else
  {
    drawInitialLife();
  }
  
  popMatrix();
  
  if(countCellValue()==0)
  {
    gameStart=false;
  }
  
  //preDrawBlockLine();
  
  debag();
}

//_______________________________define judgeLifeCoreProcesse()_________________________________
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
  
  regularSounds();
  
  stroke(255,100,255);
  line(cellSize*cell.length/2, 0, cellSize*cell.length/2, cellSize*cell.length);
  line(0, cellSize*cell.length/2, cellSize*cell.length, cellSize*cell.length/2);
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

//__________________________DATE_____________________________
int countCellValue()
{
  int samAllCell;
  samAllCell=countCell1()+countCell2();
  return samAllCell;
}

int countCell1()
{
  int countCell1=0;
  for(int i=0; i<cell.length; i++)
  {
    for(int j=0; j<cell[i].length; j++)
    {
      if(cell[i][j]==1)
      {
        countCell1++;
      }
    }
  }
  return countCell1;
}

int countCell2()
{
  int countCell2=0;
  for(int i=0; i<cell.length;i++)
  {
    for(int j=0; j<cell[i].length; j++)
    {
      if(cell[i][j]==2)
      {
        countCell2++;
      }
    }
  }
  return countCell2;
}
//_____________________________________________________

void regularSounds()
{
  for(int i=0; i<interval.length;i++)
  {
    if(currentTime-soundTime[i]>=10000)
    {
      interval[i]=true;
    }
  }
  for(int i=0; i<interval.length; i++)
  {
    if(interval[i])
    {
      distinguishSound(i);
    }
  }
}

void distinguishSound(int i)
{
  if(i==0)
  {
    if(countCell1()>countCell2() && (countCell1()/2)<countCell2())
    {
      sound[0].play();
      interval[0]=false;
      soundTime[0]=millis();
    }
  }
  else if(i==1)
  {
    if(countCell2()>countCell1() && (countCell2()/2)<countCell1())
    {
      sound[1].play();
      interval[1]=false;
      soundTime[1]=millis();
    }
  }
  else if(i==2)
  {
    if((countCell1()/2)>countCell2() && (countCell1()/4)<countCell2())
    {
      sound[2].play();
      interval[2]=false;
      soundTime[2]=millis();
    }
  }
  else if(i==3)
  {
    if((countCell2()/2)>countCell1() && (countCell2()/4)<countCell1())
    {
      sound[3].play();
      interval[3]=false;
      soundTime[3]=millis();
    }
  }
  else if(i==4)
  {
    if(countCell2()/4>=countCell1())
    {
      sound[4].play();
      interval[4]=false;
      soundTime[4]=millis();
    }
  }
  else if(i==5)
  {
    if(countCell1()/4>countCell2())
    {
      sound[5].play();
      interval[5]=false;
      soundTime[5]=millis();
    }
  }
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
  
  //stroke(255,100,255);
  //line(cellSize*cell.length/2, 0, cellSize*cell.length/2, cellSize*cell.length);
  //line(0, cellSize*cell.length/2, cellSize*cell.length, cellSize*cell.length/2);
}

//______________________________________________________________void mousePressed____________________________
void mousePressed()
{
  
  if(!gameStart)
  {
    preGameFase();
  }
}

void preGameFase()
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
      
      if(isShip)
      {
        createGlider(1,cmX,cmY);
      }
      else if(isHeavyweightSpaceShip)
      {
        createHeavyweightSpaceShip(1,cmX,cmY);
      }
      else if(isLightweightSpaceShip)
      {
        createLightweightSpaceShip(1,cmX,cmY);
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
      if(isShip)
      {
        createGlider(2,cmX,cmY);
      }
      else if(isHeavyweightSpaceShip)
      {
        createHeavyweightSpaceShip(2,cmX,cmY);
      }
      else if(isLightweightSpaceShip)
      {
        createLightweightSpaceShip(2,cmX,cmY);
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

//___________________________void keyPressed()____________________________
void keyPressed()
{
  //start
  if(keyCode==ENTER)
  {
    if(gameStart==false)
    {
      gameStart=true;
      
      sound[7].play();
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
  
  if(key=='s')
  {
    if(isShip)
    {
      isShip=false;
    }
    else
    {
      isShip=true;
    }
  }
  
  if(key=='h')
  {
    if(isHeavyweightSpaceShip)
    {
      isHeavyweightSpaceShip=false;
    }
    else
    {
      isHeavyweightSpaceShip=true;
    }
  }
  
  if(key=='l')
  {
    if(isLightweightSpaceShip)
    {
      isLightweightSpaceShip=false;
    }
    else
    {
      isLightweightSpaceShip=true;
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
  //if(currentTime-startTime==1000)
  //{
  //  for(int i=0; i<interval.length;i++)
  //  {
  //    interval[i]=true;
  //  }
  //}
  println(interval[0]);
}
