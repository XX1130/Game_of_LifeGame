
int judgeButtonPressed(int centerX,int centerY,int buttonw,int buttonh,int radius)
{
  if(mousePressed)
  {
    boolean inRect = mouseX > (centerX-buttonw) && mouseY < (centerX +buttonw) && mouseY > (centerY-buttonh) && mouseY<(centerY+buttonh);
    
    if(inRect)
    {
      return 1;
    }
    else
    {
      return 0;
    }
  }
  else
  {
    return 0;
  }
}
