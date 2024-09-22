void Garden_of_Eden_Blueprint(int x,int y)
{
  
  int cellsideX=x-3;
  int cellsideY=y-3;
  for(int l=0; l<7; l++)
  {
    cell[cellsideX+0][cellsideY+l]=3;
    cell[cellsideX+7][cellsideY+l]=3;
    cell[cellsideX+l][cellsideY+0]=3;
    cell[cellsideX+l][cellsideY+7]=3;
  }
  cell[x][y]=4;
  cell[x+1][y]=4;
  cell[x][y+1]=4;
  cell[x+1][y+1]=4;
}
