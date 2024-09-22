import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

int[][] cell =new int[400][400];
int[][] savedCell=new int[400][400];
int cellSize=8;

int cellType;

boolean edit1Player=true;
boolean editPlayer=true;

boolean isShip=false;
boolean isHeavyweightSpaceShip=false;
boolean isLightweightSpaceShip=false;
boolean isGliderGun=false;
boolean isWall=false;


boolean gameStart=false;
boolean gameOpeningPhase1=true;
boolean gameOpeningPhase2=false;
int translateMatrixX=-600;
int translateMatrixY=-600;
int translateSpeed;
int cmX;
int cmY;
int direction;

int mainWindowSizeWidth=400;
int mainWindowSizeHeight=200;

int startTime;
int currentTime;
int countGeneration;

//mainWindowOpening
int[][] effectCell;
int[][] saveEffectCell;
int effectCoreX;
int effectCoreY;
int effectCellSize;
int effectCellMargin;
int lastTime;
int effectFunctionIntervalRate;
boolean effectFunctionInterval;
int frameNumber;

String[] strTitle11DBlueprint;
String[] ST1;
String[] strTitle21DBlueprint;
String[] interfaceStage1;

//____________________mainWindow_displaySituation_________________
int colorBluer1 =0;


//_______________________________subWindow___________________
int subWindowWidth=400;
int subWindowHeight=400;
int subWindowGamePhaseWidth=600;
int subWindowGamePhaseHeight=300;

//背景のライフゲーム
int openingCellSize=10;
int OCS=openingCellSize;
int subCell[][]=new int[subWindowWidth/openingCellSize][subWindowHeight/openingCellSize];
int subSaveCell[][]=new int[subWindowWidth/openingCellSize][subWindowHeight/openingCellSize];

int buttonh=25;
int buttonw=50;

//___________subWindowGamePhase___________
//____________mainDesignOfOpening_______________________________
int wardSectionWidth = 150;
int wardSectionHeight = 50;
int pictureSectionWidth = wardSectionWidth;
int pictureSectionHeight = wardSectionHeight*3;

int numberChara=5;

//_______________________UI______________________________
int circleX[] = new int[30];
int circleY[] = new int[30];
int saveCircleX[] = new int[30];
int saveCircleY[] = new int[30];
int transparentRate[] = new int[30];

boolean switchVector =true;
int x=0;
int y=0;
int vx=+4;
int vy=+4;

boolean isMousepressed=false;

//__________________cursorEffect___________________________________
int cursorEffectCircleX[] = new int[30];
int cursorEffectCircleY[] = new int[30];
int saveCursorEffectCircleX[] = new int[30];
int saveCursorEffectCircleY[] = new int[30];
int cursorEffectTransparentRate[] = new int[30];


//______________________________images______________________________
PImage spaceShip1;
PImage spaceShip2;
PImage wall;
PImage glider;
PImage spaceport;

//______________________________sounds_______________________________
import processing.sound.*;
int soundsLength=8;
int soundEffectsLength = 1;
SoundFile[] sound=new SoundFile[soundsLength];
SoundFile[] soundEffect = new SoundFile[soundEffectsLength];
SoundFile soundBGM1;
SoundFile soundBGM2;
int[] soundTime = new int[soundsLength];
boolean[] interval=new boolean[soundsLength];

boolean isSoundBGM1 = false;
boolean isSoundBGM2 = false;
//___________________________________________________________________


class MainWindow extends PApplet
{
  PApplet parent;
  String[] strTitle11DBlueprint;
  String[] strTitle21DBlueprint;
  String[] interfaceStage1;
  MainWindow(PApplet parent,int w,int h, String[] strTitle11DBlueprint, String[] strTitle21DBlueprint,String[] interfaceStage1)
  {
    this.parent = parent;
    this.strTitle11DBlueprint = strTitle11DBlueprint;
    this.strTitle21DBlueprint = strTitle21DBlueprint;
    this.interfaceStage1 = interfaceStage1;
    PApplet.runSketch(new String[]{this.getClass().getSimpleName()},this);
    surface.setSize(w,h);
  }
  
  void settings()
  {
    size(400,200);
  }
  void setup()
  {
    surface.setTitle("main Window");
    
    for(int i=0; i< cell.length; i++)
    {
      for(int j=0; j< cell[i].length; j++)
      {
        cell[i][j]=0;
      }
    }
    initialLife1();
    
    //______________mainWindowOpeningEffect1_________________
    effectCell = new int[150][150];
    saveEffectCell = new int[150][150];
    effectCellSize = 2;
    effectCellMargin=5;
    effectCoreY = effectCell.length / 2;
    
    effectFunctionIntervalRate=2000;
    
    frameNumber = 0;
    for(int i=0; i<effectCell.length; i++)
    {
      for(int j=0; j<effectCell[i].length; j++)
      {
        effectCell[i][j]=0;
        saveEffectCell[i][j]=0;
      }
    }
    
    //_______________________cursorEffect
    //  for(int i=0; i<cursorEffectCircleX.length; i++)
    //{
    //  cursorEffectCircleX[i]=0;
    //  cursorEffectCircleY[i]=0;
    //  saveCursorEffectCircleX[i]=0;
    //  saveCursorEffectCircleY[i]=0;
    //}
    //for(int i=0; i<cursorEffectTransparentRate.length; i++)
    //{
    //  cursorEffectTransparentRate[i] = i*8;
    //}
    
    initialEnemy();
    
    changeWindowSize(600,400);
  }
  
  
  void draw()
  {
    currentTime=millis();
    
    colorMode(RGB,255);
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
      if(gameOpeningPhase1)
      {
        coreProcessOfOpening1();
        colorMode(NORMAL);
        background(0);
        
      }
      else
      {
        drawInitialLife();
        preGamephase();
        presentManupulatableArea();
      }
    }
    
    popMatrix();
    
    if(countCellValue()==0)
    {
      gameStart=false;
    }
    
    if(gameStart)
    {
      displaySituation();
    }
    else
    {
      if(gameOpeningPhase1)
      {
        lineEffectCoreProcess();
        this.displayTitle1(90,100,4);
        this.displayTitle2(110,190,4);
      }
      else
      {
        displaySituation();
      }
    }
    //preDrawBlockLine();
    
    //saveCursorEffectCircle();
    //drawCursorEffectLine();
    //debag();
  }
  
  //_______________________________define coreProcessOfOpening1()_________________________________
  void coreProcessOfOpening1()
  {
    
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
  
  //___________________________________________judgeCellType___________________________________________
  
  void judgeLifeDrawFase(int i,int j)
  {
    colorMode(RGB,255);
    if(cell[i][j]==0)
    {
      fill(255);
    }
    else if(cell[i][j]==1)
    {
      if(gameStart)
      {
        int randomNumber = (int)random(10);
        if(randomNumber == 0)
        {
          fill(11,118,160);
        }
        else
        {
          fill(8,79,106);
        }
      }
      else
      {
        fill(0,0,255);
      }
    }
    else if(cell[i][j]==2)
    {
      if(gameStart)
      {
        int randomNumber = (int)random(10);
        if(randomNumber == 0)
        {
          fill(72,98,62);
        }
        else
        {
          fill(76,120,40);
        }
      }
      else
      {
        fill(0,255,0);
      }
    }
    else if(cell[i][j]==3)
    {
      fill(128,128,128);
    }
    else if(cell[i][j]==4)
    {
      fill(255,204,102);
    }
    
    int rectX=cellSize*i;
    int rectY=cellSize*j;
    stroke(0);
    strokeWeight(1);
    rect(rectX,rectY,cellSize,cellSize);
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
  
  //__________________________DATA_____________________________
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
  
  void changeWindowSize(int w,int h)
  {
    surface.setSize(w,h);
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
    colorMode(RGB,255);
    fill(0,0,0,0);
    stroke(255,0,0);
    rect(cellSize*30*i,cellSize*30*j,cellSize*30,cellSize*30);
    
    //stroke(255,100,255);
    //line(cellSize*cell.length/2, 0, cellSize*cell.length/2, cellSize*cell.length);
    //line(0, cellSize*cell.length/2, cellSize*cell.length, cellSize*cell.length/2);
  }
  
  //________________________________mainWindowOpneing_______________________________
  //________________________________mainWindowOpeningEffect1________________________
  void lineEffectCoreProcess()
  {
    effectFunctionIntervalInterface();
    setMatrixFunction();
    saveEffectCells();
    setCoreEffectCells();
    setTailEffectCells();
    effectCellTransition();
    drawEffectCells();
    
    frameNumber++;
  }
  
  void setMatrixFunction()
  {
    if(effectFunctionInterval)
    {
      effectCoreX = (frameNumber*2)%effectCell.length;
    }
    else
    {
      effectCoreX = 149;
    }
    effectCoreY = effectCoreY+30*int(sin((TWO_PI*effectCoreX/width)))+((int)random(-1,2)*5);
    effectCoreY = constrain(effectCoreY,0,effectCell[0].length -1);
  }
  
  void effectFunctionIntervalInterface()
  {
    if(effectFunctionInterval)
    {
      if(frameNumber>75)
      {
        effectFunctionInterval=false;
        lastTime=millis();
        
      }
    }
    if(!effectFunctionInterval)
    {
      if(millis()-lastTime > effectFunctionIntervalRate)
      {
        effectFunctionInterval = true;
        frameNumber=0;
      }
    }
  }
  
  void setCoreEffectCells()
  {
    if(effectCoreY>effectCell.length/4 && effectCoreY<effectCell[1].length)
    {
      effectCell[effectCoreX][effectCoreY]=1;
    }
    else
    {
      effectCoreY=effectCell.length/2;
      effectCell[effectCoreX][effectCoreY]=1;
    }
    
     for(int i=0; i<3; i++)
    {
      int randomEffectCellX = (int)random(0,effectCell.length);
      int randomEffectCellY = (int)random(0,effectCell[1].length);
      
      effectCell[randomEffectCellX][randomEffectCellY]=-1;
    }
  }
  
  void saveEffectCells()
  {
    for(int i=0; i<effectCell.length; i++)
    {
      for(int j=0; j<effectCell[i].length; j++)
      {
        saveEffectCell[i][j]=effectCell[i][j];
      }
    }
  }
  
  void setTailEffectCells()
  {
    for(int i=0; i<effectCell.length;i++)
    {
      for(int j=0; j<effectCell[i].length-1; j++)
      {
        if(saveEffectCell[i][j+1]==1)
        {
          effectCell[i][j]=1;
        }
        else if(saveEffectCell[i][j+1]==-1)
        {
          effectCell[i][j]=-1;
        }
      }
    }
  }
  
  void effectCellTransition()
  {
    for(int i=0; i<effectCell.length; i++)
    {
      for(int j=0; j<effectCell[i].length; j++)
      {
        if(saveEffectCell[i][j]>0 && saveEffectCell[i][j]<19)
        {
          effectCell[i][j]++;
        }
        else if(saveEffectCell[i][j]==9)
        {
          effectCell[i][j]=0;
        }
        
        if(saveEffectCell[i][j]<0 && saveEffectCell[i][j]>-24)
        {
          effectCell[i][j]--;
        }
        else if(saveEffectCell[i][j]==-24)
        {
          effectCell[i][j]=0;
        }
      }
    }
  }
  
  void drawEffectCells()
  {
    colorMode(HSB,360,100,100,255);
    for(int i=0; i<effectCell.length; i++)
    {
      for(int j=0; j<effectCell[i].length; j++)
      {
        if(effectCell[i][j]>0 && effectCell[i][j]<20)
        {
          for(int k=1; k<20; k++)
          {
            if(effectCell[i][j]==k)
            {
              drawEffectCellsInterface1(i,j,k);
            }
          }
        }
        else if(effectCell[i][j]<0 && effectCell[i][j]>-25)
        {
          for(int k=-1; k >- 25; k--)
          {
            if(effectCell[i][j]==k)
            {
              drawEffectCellsInterface2(i,j,k);
            }
          }
        }
      }
    }
  }
  void drawEffectCellsInterface1(int x,int y,int num)
  {
    colorMode(HSB,360,100,100,255);
    noStroke();
    fill(130+num*5,100,100,255-(num*10));
    rect((effectCellMargin+effectCellSize)*x,(effectCellMargin+effectCellSize)*y,effectCellSize,effectCellSize);
  }
  void drawEffectCellsInterface2(int x,int y,int num)
  {
    colorMode(HSB,360,100,100,255);
    noStroke();
    fill(70+num*5,100,100,255+(num*10));
    rect((effectCellMargin+effectCellSize)*x,(effectCellMargin+effectCellSize)*y,effectCellSize,effectCellSize);
  }
  
  //__________________________________________________________________________________________________________________
  
  //_______________________________________mainWindowOpening1DisplayTitle_____________________________________________
  void displayTitle1(int x,int y,int titleCellSize)
  {
    String[] strTitle11DBlueprint = this.strTitle11DBlueprint;
    String[][] strTitle1Blueprint;
    
    int[][] numberTitle1Blueprint;
    
    strTitle1Blueprint = new String[strTitle11DBlueprint.length][];
    
    for(int i=0; i<strTitle11DBlueprint.length; i++)
    {
      strTitle1Blueprint[i] = strTitle11DBlueprint[i].split("");
    }
    
    int xLength = strTitle1Blueprint.length;
    int yLength = strTitle1Blueprint[0].length;
    
    numberTitle1Blueprint = new int[xLength][yLength];
    
    int countOn =0;
    for(int i=0; i<xLength; i++)
    {
      for(int j=0; j<yLength; j++)
      {
        if(strTitle1Blueprint[i][j].equals("．"))
        {
          int interfaceValue =0;

          numberTitle1Blueprint[i][j]=interfaceValue;
        }
        else if(strTitle1Blueprint[i][j].equals("■"))
        {
          numberTitle1Blueprint[i][j]=1;
        }
        else
        {
          println("faileTitle");
        }
      }
    }
    colorMode(RGB,255);
    noStroke();
    fill(180,180,180);
    for(int i=0; i<xLength; i++)
    {
      for(int j=0; j<yLength; j++)
      {
        if(numberTitle1Blueprint[i][j]==1)
        {
          rect(x+(j*(1+titleCellSize)),y+(i*(titleCellSize+1)),titleCellSize,titleCellSize);
          countOn++;
        }
      }
    }
  }
  
  void displayTitle2(int x,int y, int titleCellSize)
  {
    String[] strTitle121DBlueprint = this.strTitle21DBlueprint;
    String[][] strTitle2Blueprint;
    
    int[][] numberTitle2Blueprint;
    
    strTitle2Blueprint = new String[strTitle21DBlueprint.length][];
    
    for(int i=0; i<strTitle21DBlueprint.length; i++)
    {
      strTitle2Blueprint[i] = strTitle21DBlueprint[i].split("");
    }
    
    int xLength = strTitle2Blueprint.length;
    int yLength = strTitle2Blueprint[0].length;
    
    numberTitle2Blueprint = new int[xLength][yLength];
    
    int countOn =0;
    for(int i=0; i<xLength; i++)
    {
      for(int j=0; j<yLength; j++)
      {
        if(strTitle2Blueprint[i][j].equals("．"))
        {
          numberTitle2Blueprint[i][j]=0;
        }
        else if(strTitle2Blueprint[i][j].equals("■"))
        {
          numberTitle2Blueprint[i][j]=1;
        }
        else
        {
          println("faileTitle");
        }
      }
    }
    colorMode(RGB,255);
    noStroke();
    fill(180,180,180);
    for(int i=0; i<xLength; i++)
    {
      for(int j=0; j<yLength; j++)
      {
        if(numberTitle2Blueprint[i][j]==1)
        {
          rect(x+(j*(titleCellSize+1)),y+(i*(titleCellSize+1)),titleCellSize,titleCellSize);
          countOn++;
        }
      }
    }
  }
  //_____________________________________________________________________________
  
  void preGamephase()
  {
    changeWindowSize(1200,800);
    if(mousePressed && !isMousepressed)
    {
      if(mouseButton==LEFT)
      {
        if(editPlayer)
        {
          if(edit1Player)
          {
            if(isShip)
            {
              createGlider(1,cmX,cmY,direction);
            }
            else if(isHeavyweightSpaceShip)
            {
              createHeavyweightSpaceShip(1,cmX,cmY);
            }
            else if(isLightweightSpaceShip)
            {
              createLightweightSpaceShip(1,cmX,cmY);
            }
            else if(isGliderGun)
            {
              createGliderGun(1,cmX,cmY,direction);
            }
            else if(isWall)
            {
              createBlock(1,cmX,cmY,direction);
            }
            else
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
              createGlider(2,cmX,cmY,direction);
            }
            else if(isHeavyweightSpaceShip)
            {
              createHeavyweightSpaceShip(2,cmX,cmY);
            }
            else if(isLightweightSpaceShip)
            {
              createLightweightSpaceShip(2,cmX,cmY);
            }
            else if(isGliderGun)
            {
              createGliderGun(2,cmX,cmY,direction);
            }
            else if(isWall)
            {
              createBlock(2,cmX,cmY,direction);
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
      else if(mouseButton==RIGHT)
      {
        direction++;
      }
      isMousepressed = true;
    }
    
    if(!mousePressed && isMousepressed)
    {
      isMousepressed = false;
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
        if(gameOpeningPhase1)
        {
          gameOpeningPhase1=false;
        }
        else
        {
          gameStart=true;
          sound[7].play();
        }
      }
      else if(gameStart==true)
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
        
        isWall = false;
        isLightweightSpaceShip=false;
        isHeavyweightSpaceShip=false;
        isGliderGun=false;
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
        
        isShip=false;
        isLightweightSpaceShip=false;
        isGliderGun=false;
        isWall=false;
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
        
        isShip=false;
        isWall=false;
        isGliderGun=false;
        isHeavyweightSpaceShip=false;
      }
    }
    
    if(key=='g')
    {
      if(isGliderGun)
      {
        isGliderGun=false;
      }
      else
      {
        isGliderGun=true;
        
        isShip=false;
        isLightweightSpaceShip=false;
        isHeavyweightSpaceShip=false;
        isWall=false;
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
          translateMatrixX=translateMatrixX-translateSpeed;
        }
      }
      else if(translateMatrixX<=(cell.length*cellSize)-width)
      {
        if(keyCode==LEFT)
        {
          translateMatrixX=translateMatrixX+translateSpeed;
        }
      }
    }
    else
    {
      if(keyCode==RIGHT)
      {
        translateMatrixX=translateMatrixX-translateSpeed;
      }
      if(keyCode==LEFT)
      {
        translateMatrixX=translateMatrixX+translateSpeed;
      }
    }
    
    if(isEdgeY)
    {
      if(translateMatrixY>=0)
      {
        if(keyCode==DOWN)
        {
          translateMatrixY=translateMatrixY-translateSpeed;
        }
      }
      else if(translateMatrixY>=height-(cell[1].length*cellSize))
      {
        if(keyCode==UP)
        {
          translateMatrixY=translateMatrixY+translateSpeed;
        }
      }
    }
    else
    {
      if(keyCode==DOWN)
      {
        translateMatrixY=translateMatrixY-translateSpeed;
      }
      if(keyCode==UP)
      {
        translateMatrixY=translateMatrixY+translateSpeed;
      }
    }
  }
  
  //_______________________________interfaceDesign_____________________________________________________
  void displaySituation()
  {
    int countCell1=MainWindow.countCell1();
    int countCell2=MainWindow.countCell2();
    textAlign(CENTER);
    textSize(30);
    fill(255,255,200);
    text(countCell1+" VS "+countCell2, mainWindowSizeWidth/2, 50);
    text("direction:"+direction%4,mainWindowSizeWidth/2,70);
    
    int[][] interfaceStage1After = arrangedNumberArray(interfaceStage1,".","■");
    int edgeOfTextX = 300-interfaceStage1After.length/2;
    int edgeOfTextY = 20;
    int cSizeX=8;
    int margin = 1;
    
    if(frameCount%5==0)
    {
      int randomNumber = (int)random(5);
      if(randomNumber==0)
      {
        colorBluer1=-20;
      }
      else
      {
        colorBluer1=0;
      }
    }
    for(int i=0; i<interfaceStage1After.length; i++)
    {
      for(int j=0; j<interfaceStage1After[i].length; j++)
      {
        if(interfaceStage1After[i][j]==1)
        {
          colorMode(HSB,360,100,100,255);
          noStroke();
          int colorBluer2;
          int randomValue = (int)random(15);
          if(randomValue==0)
          {
            colorBluer2=-30;
          }
          else
          {
            colorBluer2=0;
          }
          fill(0,80,69+colorBluer1+colorBluer2,255);
          rectMode(CENTER);
          rect(edgeOfTextX + j*(cSizeX+margin),edgeOfTextY+i*(cSizeX+margin),cSizeX,cSizeX);
        }
      }
    }
  }
  
  void presentManupulatableArea()
  {
    int i=50+int(50*(sin(frameCount)));
    strokeWeight(2);
    stroke(i,i,255);
    colorMode(RGB,255);
    fill(255,255,255,0);
    rectMode(CORNER);
    rect(0,150*cellSize,150*cellSize,150*cellSize);
    
    stroke(255,165,i);
    fill(255,255,255,0);
    rectMode(CENTER);
    rect(110*cellSize,190*cellSize,9*cellSize,9*cellSize);
  }
  
  //________________________________cursorEffectDesign_______________________
  void saveCursorEffectCircle()
  {
    for(int i=0; i<cursorEffectCircleX.length; i++)
    {
      saveCursorEffectCircleX[i]=cursorEffectCircleX[i];
      saveCursorEffectCircleY[i]=cursorEffectCircleY[i];
    }
  }
  void drawCursorEffectLine()
  {
    cursorEffectCircleX[0]=mouseX;
    cursorEffectCircleY[0]=mouseY;
    for(int i=1; i<cursorEffectCircleX.length; i++)
    {
      cursorEffectCircleX[i]=saveCursorEffectCircleX[i-1];
      cursorEffectCircleY[i]=saveCursorEffectCircleY[i-1];
    }
    
    for(int i=0; i<cursorEffectCircleX.length; i++)
    {
      noStroke();
      colorMode(HSB,360,100,100,255);
      fill((360*2/3)-(2*i),100,100,255-cursorEffectTransparentRate[i]);
      circle(cursorEffectCircleX[i],cursorEffectCircleY[i],5);
    }
  }
  
  void debag()
  {
    Garden_of_Eden_Blueprint(width/2,height/2);
  }
}
