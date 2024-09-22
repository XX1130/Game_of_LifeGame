String[] gliderGunBlueprint1D;
String[][] gliderGunBlueprintArray;
int[][] numberGliderGunBlueprintArray;

//function_return_array_from_unNumberDate

int[][] arrangedNumberArray(String[] originStr,String sort1,String sort2)
{
  String splitedOriginStr[][] = new String[originStr.length][];
  
  for(int i=0; i<originStr.length; i++)
  {
    splitedOriginStr[i] = originStr[i].split("");
  }
  
  int numberStr[][] = new int[splitedOriginStr.length][splitedOriginStr[0].length];
  for(int i=0; i<numberStr.length; i++)
  {
    for(int j=0; j<numberStr[0].length; j++)
    {
      if(splitedOriginStr[i][j].equals(sort1))
      {
        numberStr[i][j]=0;
      }
      else if(splitedOriginStr[i][j].equals(sort2))
      {
        numberStr[i][j]=1;
      }
      else
      {
      }
    }
  }
  
  return numberStr;
}

//function_return_relativePosition_from_booleanDate

int[][] returnRelativePosition(int[][] blueprint)
{
   int countTrue = 0;
   int blueprintRowLength = blueprint.length;
   int blueprintColumnLength = blueprint[0].length;
   int centerBlueprintRow = blueprintRowLength/2;
   int centerBlueprintColumn = blueprintColumnLength/2;
   
   for(int i=0; i<blueprintRowLength; i++)
   {
     for(int j=0; j<blueprintColumnLength;j++)
     {
       if(blueprint[i][j]==1)
       {
         countTrue++;
       }
     }
   }
   int[][] blueprintInterface = new int[countTrue][2];
   int countLoop=0;
   for(int i=0; i<blueprintRowLength; i++)
   {
     for(int j=0; j<blueprintColumnLength; j++)
     {
       if(blueprint[i][j]==1)
       {
         blueprintInterface[countLoop][0] = j - centerBlueprintColumn;
         blueprintInterface[countLoop][1] = i - centerBlueprintRow;
         countLoop++;
       }
     }
   }
   
   int[][] trimmedRelativePosition = new int[countTrue][2];
   for(int i=0; i<countTrue; i++)
   {
     trimmedRelativePosition[i] = blueprintInterface[i];
   }
   return trimmedRelativePosition;
}


void createSpaceShip(int x,int y,int i,int[][] offsets,int num_offsets,int direction)
{
  float angle = direction*PI/2;
  for(int k=0; k<num_offsets; k++)
  {
    int dx = offsets[k][0];
    int dy = offsets[k][1];
    
    int newX = x+round(dx*(cos(angle))-dy*(sin(angle)));
    int newY = y+round(dx*(sin(angle))+dy*(cos(angle)));
    
    //if (newX < 0 || newY < 0 || newX >= cell.length || newY >= cell[0].length) {
    //  println("座標が範囲外です: newX = " + newX + ", newY = " + newY);
    //  continue;  // 座標が範囲外の場合、無視する
    //}
    
    cell[newX][newY]=i;
  }
}
    

void createGlider(int i,int x, int y, int direction)
{
  int[][] gliderBlueprint = {
    {-1,0},{-1,1},{0,1},{0,-1},{1,1}
  };
  
  createSpaceShip(x,y,i,gliderBlueprint,5,direction);
}

void createHeavyweightSpaceShip(int i,int x,int y)
{
  
  int heavyweightSpaceShipBlueprint[][] = {
    {0,2},{-1,2},{-3,1},{-3,-1},{-2,-2},
    {-1,-2},{0,-2},{1,-2},{2,-2},{3,-2},
    {3,-1},{3,0},{2,1}
  };
  createSpaceShip(x,y,i,heavyweightSpaceShipBlueprint,13,direction);
}

void createLightweightSpaceShip(int i,int x,int y)
{
  
  int lightweightSpaceShipBlueprint[][]={
    {-1,2},{-2,1},{-2,-1},{1,-1},{2,0},
    {2,1},{2,2},{1,2},{0,2}
  };
  createSpaceShip(x,y,i,lightweightSpaceShipBlueprint,9,direction);
}

void createGliderGun(int x,int y,int l,int d)
{
  gliderGunBlueprint1D = loadStrings("./texts/gliderGunBlueprint.txt");
  
  gliderGunBlueprintArray = new String[gliderGunBlueprint1D.length][];
  
  for(int i=0; i<gliderGunBlueprint1D.length; i++)
  {
    gliderGunBlueprintArray[i]=gliderGunBlueprint1D[i].split("");
  }
  
  numberGliderGunBlueprintArray = new int[gliderGunBlueprintArray.length][gliderGunBlueprintArray[0].length];
  for(int i=0; i<gliderGunBlueprintArray.length; i++)
  {
    for(int j=0; j<gliderGunBlueprintArray[i].length; j++)
    {
      if(gliderGunBlueprintArray[i][j].equals("□"))
      {
        numberGliderGunBlueprintArray[i][j]=0;
      }
      else if(gliderGunBlueprintArray[i][j].equals("■"))
      {
        numberGliderGunBlueprintArray[i][j]=1;
      }
      else
      {
        println("faile");
      }
    }
  }
  
  int centerXOfGliderGun = gliderGunBlueprintArray[1].length/2;
  int centerYOfGliderGun = gliderGunBlueprintArray.length/2;
  int gliderGunInterface[][] = new int[gliderGunBlueprintArray.length*gliderGunBlueprintArray[0].length][2];
  int countGliderGunBlueprintLength=0;
  
  for(int i=0; i<gliderGunBlueprintArray.length; i++)
  {
    for(int j=0; j<gliderGunBlueprintArray[i].length; j++)
    {
      if(numberGliderGunBlueprintArray[i][j]==1)
      {
        gliderGunInterface[countGliderGunBlueprintLength][0] = j - centerXOfGliderGun;
        gliderGunInterface[countGliderGunBlueprintLength][1] = i - centerYOfGliderGun;
        countGliderGunBlueprintLength++;
      }
    }
  }
  
  //gliderGunInterface配列から空集合の部分をカットする
  int[][] trimmedGliderGunInterface = new int[countGliderGunBlueprintLength][2];
  for(int i=0; i<countGliderGunBlueprintLength; i++)
  {
    trimmedGliderGunInterface[i] = gliderGunInterface[i];
  }
  
  createSpaceShip(x,y,l,gliderGunInterface,countGliderGunBlueprintLength,d);
}

void createShield(int x,int y,int i)
{
  int[][] shieldBlueprint ={
    {-2,0},{-1,0},{0,0},{1,0},{2,0}
  };
  
  createSpaceShip(x,y,3,shieldBlueprint,5,direction);
}

void createBlock(int x,int y,int i, int d)
{
  int[][] block={
    {0,0},{0,1},{1,0},{1,1}
  };
  
  createSpaceShip(x,y,i,block,4,d);
}

void createBlock1(int x,int y,int d)
{
  int[][]block1 = {
    {-1,-1},{0,0},{1,1}
  };
  
  createSpaceShip(x,y,3,block1,3,d);
}

void createFrog(int x,int y,int i)
{
  int[][] frog = {
    {0,0},{1,0},{2,0},{-1,1},{0,1},{1,1}
  };
  
  createSpaceShip(x,y,i,frog,6,direction);
}

void createClock(int x,int y,int i)
{
  String[] clockBlueprint = loadStrings("./texts/clock.txt");
  int[][]clock = returnRelativePosition(arrangedNumberArray(clockBlueprint,"□","■"));
  
  createSpaceShip(x,y,i,clock,clock.length,direction);
}

void createGliderGun2(int x,int y,int i)
{
  String[] gliderGun2Blueprint = loadStrings("./texts/gliderGun2.txt");
  int[][] gliderGun2 = returnRelativePosition(arrangedNumberArray(gliderGun2Blueprint,"□","■"));
  
  for (int l = 0; l < gliderGun2.length; l++) {
  for (int j = 0; j < gliderGun2[0].length; j++) {
    print(gliderGun2[l][j] + " ");
  }
}
  
  createSpaceShip(x,y,i,gliderGun2,gliderGun2.length,0);
}

void createGliderGun3(int x,int y,int i,int d)
{
  String[] gliderGun3Blueprint = loadStrings("./texts/gliderGun3.txt");
  int[][]gliderGun3 = returnRelativePosition(arrangedNumberArray(gliderGun3Blueprint,"□","■"));
  
  createSpaceShip(x,y,i,gliderGun3,gliderGun3.length,d);
}

void createBlock2(int x,int y,int d)
{
  int[][] block2 = {
    {0,-2},{0,-1},{0,0},{0,1},{0,2}
  };
  createSpaceShip(x,y,3,block2,5,d);
}

void createBlock3(int x,int y,int d)
{
  int[][]block3 = {
    {-3,-3},{-2,-2},{-1,-1},{0,0},{1,1},{2,2},{3,3}
  };
  createSpaceShip(x,y,3,block3,7,d);
}

void createBlockCube(int x,int y,int i)
{
  int[][]blockCube={
    {-1,-1},{0,-1},{-1,0},{0,0}
  };
  createSpaceShip(x,y,i,blockCube,4,0);
}

void createGalaxcy(int x, int y,int i)
{
  String[] galaxcyBlueprint = loadStrings("./texts/galaxcy.txt");
  int[][] galaxcy = returnRelativePosition(arrangedNumberArray(galaxcyBlueprint,"□","■"));
  
  createSpaceShip(x,y,i,galaxcy,galaxcy.length,0);
}

void createGliderGun4(int x,int y,int i,int d)
{
  String[] gliderGun4Blueprint = loadStrings("./texts/gliderGun4.txt");
  int[][] gliderGun4 = returnRelativePosition(arrangedNumberArray(gliderGun4Blueprint,"□","■"));
  
  createSpaceShip(x,y,i,gliderGun4,gliderGun4.length,d);
}
