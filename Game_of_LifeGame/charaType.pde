void createGlider(int i,int x, int y)
{
  cell[x-1][y]=i;
  cell[x-1][y+1]=i;
  cell[x][y+1]=i;
  cell[x][y-1]=i;
  cell[x+1][y+1]=i;
  cell[x][y]=0;
}

void createHeavyweightSpaceShip(int i,int x,int y)
{
  cell[x][y]=0;
  cell[x][y+2]=i;
  cell[x-1][y+2]=i;
  cell[x-3][y+1]=i;
  cell[x-3][y-1]=i;
  cell[x-2][y-2]=i;
  cell[x-1][y-2]=i;
  cell[x][y-2]=i;
  cell[x+1][y-2]=i;
  cell[x+2][y-2]=i;
  cell[x+3][y-2]=i;
  cell[x+3][y-1]=i;
  cell[x+3][y]=i;
  cell[x+2][y+1]=i;
}

void createLightweightSpaceShip(int i,int x,int y)
{
  cell[x][y]=0;
  cell[x-1][y+2]=i;
  cell[x-2][y+1]=i;
  cell[x-2][y-1]=i;
  cell[x+1][y-1]=i;
  cell[x+2][y]=i;
  cell[x+2][y+1]=i;
  cell[x+2][y+2]=i;
  cell[x+1][y+2]=i;
  cell[x][y+2]=i;
}
