//SubWindow SubWindow;
MainWindow MainWindow;


void setup()
{
  
    //________________________mainWindow_openingTitle___________________________________
  //相対パスにてロード
  strTitle11DBlueprint = loadStrings("./texts/title1_GameOf.txt");
  strTitle21DBlueprint = loadStrings("./texts/title2_LifeGame.txt");
  interfaceStage1 = loadStrings("./texts/interfaceStage1.txt");
  
  rectMode(RADIUS);
  colorMode(RGB);
  
  cell = new int[300][300];
  savedCell = new int[300][300];
  mainWindowSizeWidth=200;
  mainWindowSizeHeight=200;
  
  translateSpeed=8;
  
  openingCellSize=10;
  OCS=openingCellSize;
  
  countGeneration=0;
  
  size(200,200);
  
  //___________________________UI___________________________________\
  for(int i=0; i<circleX.length; i++)
  {
    circleX[i]=0;
    circleY[i]=0;
    saveCircleX[i]=0;
    saveCircleY[i]=0;
  }
  for(int i=0; i<transparentRate.length; i++)
  {
    transparentRate[i] = i*8;
  }
  
  //___________________________cursorEffect_________________________
  for(int i=0; i<cursorEffectCircleX.length; i++)
  {
    cursorEffectCircleX[i]=0;
    cursorEffectCircleY[i]=0;
    saveCursorEffectCircleX[i]=0;
    saveCursorEffectCircleY[i]=0;
  }
  for(int i=0; i<cursorEffectTransparentRate.length; i++)
  {
    cursorEffectTransparentRate[i] = i*8;
  }
  
  MainWindow = new MainWindow(this,400,400,strTitle11DBlueprint,strTitle21DBlueprint,interfaceStage1);
  //SubWindow = new SubWindow(MainWindow,200,200);
  
    //__________________sounds__________________________________________________________
  sound[0] = new SoundFile(this, "/sounds/001_zundamon_voicebox_yuseinanoda.wav");
  sound[1] = new SoundFile(this, "/sounds/002_zundamon_voicebox_resseinanoda.wav");
  sound[2] = new SoundFile(this, "/sounds/003_zundamon_voicebox_kusozakoinoda.wav");
  sound[3] = new SoundFile(this, "/sounds/004_zundamon_voicebox_mazuinoda.wav");
  sound[4] = new SoundFile(this, "/sounds/005_zundamon_voicebox_kusoge-nanoda.wav");
  sound[5] = new SoundFile(this, "/sounds/006_zundamon_voicebox_kutabarenanoda.wav");
  sound[6] = new SoundFile(this, "/sounds/007_zundamon_voicebox_maketanoda.wav");
  sound[7] = new SoundFile(this, "/sounds/008_zundamon_voicebox_startnanoda.wav");
  
  soundBGM1 = new SoundFile(this,"/sounds/Method.mp3");
  soundBGM2 = new SoundFile(this,"/sounds/Response.mp3");
  
  soundEffect[0] = new SoundFile(this, "/sounds/sound_effect_1.mp3");
  
  for(int i=0; i<soundTime.length;i++)
  {
    soundTime[i]=millis();
  }
  //___________________________________________________________________________________
  //________________________images________________________________________________
  spaceShip1 = loadImage("./image/spaceShip1.png");
  spaceShip2 = loadImage("./image/spaceShip2.png");
  wall = loadImage("./image/wall.png");
  glider = loadImage("./image/glider.png");
  spaceport = loadImage("./image/spaceport.png");
  
  //________________________mainWindow_openingEffect______________________________
  effectCell = new int[150][150];
  saveEffectCell = new int[150][150];
  effectCellSize = 2;
  effectCellMargin=5;
  effectCoreY = effectCell.length / 2;
  
  effectFunctionIntervalRate=2000;
  
  frameNumber = 0;
  
  
  //________________________mainWindow_openingTitle___________________________________
  //相対パスではロードできなかったので絶対パスでロードする
  ST1=strTitle11DBlueprint;
  

  for(int i=0; i<effectCell.length; i++)
  {
    for(int j=0; j<effectCell[i].length; j++)
    {
      effectCell[i][j]=0;
      saveEffectCell[i][j]=0;
    }
  }
  gameStart=false;
}

void draw()
{
  if(gameOpeningPhase1)
  {
    background(0);
    subLifeGameCoreProcess();
    drawCover();
    
    coreProcessOfOpening1();
    
    countGeneration++;
    
    //________________sound____________________
    if(!isSoundBGM1)
    {
      soundBGM1.play();
      isSoundBGM1=true;
    }
  }
  else
  {
    background(0);
    coreProcessOfSubWindowGamePhase();
    
    //_________________sound____________
    if(!isSoundBGM2)
    {
      if(isSoundBGM1)
      {
        soundBGM1.pause();
      }
      soundBGM2.play();
      isSoundBGM2=true;
    }
  }
  //saveCursorEffectCircle();
  //drawCursorEffectLine();
}

void subLifeGameCoreProcess()
  {
    this.subSaveCell();
    this.subCellControle();
    this.drawSubCell();
    
    if(countGeneration%10==0)
    {
      addLife();
    }
  }
  
void subCellControle()
{
  for(int i=1; i<(subCell.length-1); i++)
  {
    for(int j=1; j<(subCell[i].length-1); j++)
    {
      int subCountAroundCell=0;
      int[][] subAroundCell={
        {-1,-1},{0,-1},{1,-1},
        {-1,0},        {1,0},
        {-1,1},{0,1},{1,1}
      };
      for(int[] SAC : subAroundCell)
      {
        int newI=i+SAC[0];
        int newJ=j+SAC[1];
        
        if(subSaveCell[newI][newJ]==1)
        {
          subCountAroundCell++;
        }
      }
      
      if(subSaveCell[i][j]==1)
      {
        if(subCountAroundCell<=1)
        {
          subCell[i][j]=0;
        }
        else if(subCountAroundCell<=3)
        {
          subCell[i][j]=1;
        }
        else
        {
          subCell[i][j]=0;
        }
      }
      else
      {
        if(subCountAroundCell==3)
        {
          subCell[i][j]=1;
        }
        else
        {
          subCell[i][j]=0;
        }
      }
    }
  }
}

void drawSubCell()
{
  colorMode(RGB);
  for(int i=0;i<subCell.length; i++)
  {
    for(int j=0; j<subCell[i].length; j++)
    {
      if(subCell[i][j]==1)
      {//_______________________________define judgeLifeCoreProcesse()_________________________________
        fill(51,0,204);
      }
      else
      {
        fill(0,0,0);
      }
      
      openingCellSize=10;
      int rectX=i*OCS;
      int rectY=j*OCS;
      noStroke();
      rect(i*10,j*10,10,10);
    }
  }
}

void subSaveCell()
{
  for(int i=0; i<subCell.length; i++)
  {
    for(int j=0; j<subCell[1].length; j++)
    {
      subSaveCell[i][j]=subCell[i][j];
    }
  }
}

void addLife()
{
  for(int i=0; i<subCell.length; i++)
  {
    for(int j=0; j<subCell.length; j++)
    {
      int randomNumber = (int)random(20);
      if(randomNumber == 0)
      {
        subCell[i][j]=1;
      }
    }
  }
}

void subSetInitialCell()
{
  if(frameCount%6==0)
  {
    for(int i=0; i<subCell.length; i++)
    {
      for(int j=0; j<subCell[i].length; j++)
      {
        int randomNumber=(int)random(8);
        if(randomNumber==0)
        {
          subCell[i][j]=1;
        }
        else
        {
          subCell[i][j]=0;
        }
      }
    }
  }
}

void drawCover()
{
  colorMode(RGB);
  noStroke();
  fill(51,0,205,125);
  rect(0,0,subWindowWidth,subWindowHeight);
}


void drawOpeningPhase1()
{
  //changeWindowSize(200,200);
  colorMode(RGB);
  rectMode(RADIUS);
  stroke(200,255,200);
  fill(255);
  strokeWeight(3);
  
  int rectX=mainWindowSizeWidth/2;
  int rectY=mainWindowSizeHeight/2;
  
  rect(100,100,50,25);//____________________________________HAVE A PLOBLEM HERE____________________________________________
  
  int textX=mainWindowSizeWidth/2;
  int textY=mainWindowSizeHeight/2;
  fill(0);
  textAlign(CENTER,CENTER);
  textSize(30);
  text("start",100,100);
}

void coreProcessOfOpening1()
{
  drawOpeningPhase1();
  if(judgeButtonPressed(mainWindowSizeWidth/2,mainWindowSizeHeight/2,50,25,30)==1)
  {
    gameOpeningPhase1=false;
  }
}


//______________________________________________subWindowGamePhase__________________________________CORE_________________________
void coreProcessOfSubWindowGamePhase()
{
  changeSubWindowSize();
  setSubWindowGamePhaseInterface();
}

void changeSubWindowSize()
{
  changeWindowSize(wardSectionWidth*numberChara,wardSectionHeight+pictureSectionHeight);
}
void changeWindowSize(int w,int h)
{
  surface.setSize(w,h);
}
void setSubWindowGamePhaseInterface()
{
  
  for(int i=0; i<numberChara; i++)
  {
    stroke(255);
    strokeWeight(1);
    colorMode(HSB,360,100,100);
    fill(253-(i*4),95,58);
    rectMode(CORNER);
    rect(i*wardSectionWidth,0,wardSectionWidth,wardSectionHeight);
    
    fill(257-(i*4),75,85);
    rect(i*wardSectionWidth,wardSectionHeight,pictureSectionWidth,pictureSectionHeight);
    
  }
  
  displayCharaText();
  selectCharaUI();
  selectCharaUIDesign();
}

//_________________________cursorEffectDesign____________
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
  colorMode(RGB,255);
}
