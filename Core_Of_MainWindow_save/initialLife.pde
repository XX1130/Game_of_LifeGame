void initialLife1()
{
  for(int i=0; i<cell.length; i++)
  {
    for(int j=0; j<cell[i].length; j++)
    {
      cell[i][j]=3;
    }
  }
  for(int i=cell.length/4; i<cell.length*3/4; i++)
  {
    for(int j=cell[i].length/4; j<cell[i].length*3/4; j++)
    {
      cell[i][j]=0;
    }
  }
  for(int i=0; i<185-107; i++)
  {
    for(int j=0; j<107-75; j++)
    {
      cell[75+j][107+i]=3;
    }
  }
  for(int i=0; i<225-115; i++)
  {
    for(int j=0; j<225-194;j++)
    {
      cell[116+i][194+j]=3;
    }
  }
}

void initialEnemy()
{
  //createFrog(150,150,2);
  //createClock(140,140,2);
  //createClock(160,160,2);
  //createClock(140,160,2);
  //createClock(160,140,2);
  
  //createBlock(137,137,3,1);
  //createBlock(137,140,3,1);
  //createBlock(163,163,3,1);
  //createBlock(163,160,3,1);
  
  createGliderGun3(200,100,2,1);
  createBlock2(190,130,1);
  createBlock2(194,130,1);
  createBlock2(198,130,1);
  createBlock2(202,130,1);
  createBlock3(207,124,1);
  createBlock2(185,95,0);
  createBlock2(185,90,0);
  createBlock2(185,85,0);
  createBlock2(185,80,0);
  createBlock2(185,75,0);
  createBlock2(185,100,0);
  createBlock2(185,105,0);
  createBlock2(185,110,0);
  createBlock2(188,127,0);
  createBlock2(188,122,0);
  
  createGliderGun(100,95,1,0);
  createBlock2(75,106,1);//左上横方向
  createBlock2(80,106,1);
  createBlock2(85,106,1);
  createBlock2(90,106,1);
  createBlock2(95,106,1);
  createBlock2(100,106,1);
  createBlock2(104,106,1);
  createBlock2(122,105,0);//左上縦方向
  createBlock2(122,100,0);
  createBlock2(122,95,0);
  createBlock2(122,90,0);
  createBlock2(122,85,0);
  createBlock2(122,80,0);
  createBlock2(122,75,0);
  
  
  createGliderGun4(205,175,2,3);
  
  //for(int i=0; i<20; i++)
  //{
  //  createBlockCube(120+i*3,160,1);
  //}
  createBlockCube(132,180,1);
  createBlockCube(135,180,1);
  
  createGalaxcy(110,190,1);
  createGalaxcy(135,85,1);
  createGalaxcy(165,85,2);
  createFrog(170,92,1);
  createFrog(130,92,2);
  createClock(160,92,1);
  createClock(140,92,2);
}
