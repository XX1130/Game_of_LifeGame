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
}
