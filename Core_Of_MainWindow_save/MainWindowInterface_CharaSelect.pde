//UI

void displayCharaText()
{
  image(spaceShip1,wardSectionWidth*2+10,wardSectionHeight+10,pictureSectionWidth-20,pictureSectionHeight-20);
  image(spaceShip2,wardSectionWidth*3+10,wardSectionHeight+10,pictureSectionWidth-20,pictureSectionHeight-20);
  image(wall,wardSectionWidth*0+10,wardSectionHeight+10,pictureSectionWidth-20,pictureSectionHeight-20);
  image(glider,wardSectionWidth*1+10,wardSectionHeight+10,pictureSectionWidth-20,pictureSectionHeight-20);
  image(spaceport,wardSectionWidth*4+10,wardSectionHeight+10,pictureSectionWidth-20,pictureSectionHeight-20);
  
  textAlign(CENTER,CENTER);
  textSize(30);
  fill(255);
  text("wall",wardSectionWidth*1/2,wardSectionHeight/2);
  text("glider",wardSectionWidth*3/2,wardSectionHeight/2);
  text("light",wardSectionWidth*5/2,wardSectionHeight/2);
  text("heavy",wardSectionWidth*7/2,wardSectionHeight/2);
  text("spaceport",wardSectionWidth*9/2,wardSectionHeight/2);
}

void selectCharaUI()
{
  if(mousePressed && !isMousepressed)
  {
    if(mouseX<wardSectionWidth)
    {
      if(isWall)
      {
        isWall=false;
      }
      else
      {
        isWall = true;
        
        isShip = false;
        isHeavyweightSpaceShip = false;
        isLightweightSpaceShip = false;
        isGliderGun = false;
      }
    }
    else if(mouseX>wardSectionWidth && mouseX < wardSectionWidth*2)
    {
      if(isShip)
      {
        isShip=false;
      }
      else
      {
        isShip = true; 
        
        isGliderGun = false;
        isHeavyweightSpaceShip = false;
        isLightweightSpaceShip = false;
        isWall = false;
      }
    }
    else if(mouseX > wardSectionWidth*2 && mouseX < wardSectionWidth*3)
    {
      if(isLightweightSpaceShip)
      {
        isLightweightSpaceShip = false;
      }
      else
      {
        isLightweightSpaceShip = true;
        
        isShip=false;
        isHeavyweightSpaceShip=false;
        isWall=false;
        isGliderGun=false;
      }
    }
    else if(mouseX > wardSectionWidth*3 && mouseX < wardSectionWidth*4)
    {
      if(isHeavyweightSpaceShip)
      {
        isHeavyweightSpaceShip = false;
      }
      else
      {
        isHeavyweightSpaceShip = true;
        isShip = false;
        isLightweightSpaceShip = false;
        isGliderGun = false;
        isWall = false;
      }
    }
    else
    {
      if(isGliderGun)
      {
        isGliderGun = false;
      }
      else
      {
        isGliderGun = true;
        
        isShip = false;
        isLightweightSpaceShip = false;
        isHeavyweightSpaceShip = false;
        isWall = false;
      }
    }
    isMousepressed = true;
  }
  
  if(!mousePressed && isMousepressed)
  {
    isMousepressed = false;
  }
}

void selectCharaUIDesign()
{
  saveCircle();
  if(isWall)
  {
    drawLine(0,0);
  }
  else if(isShip)
  {
    drawLine(wardSectionWidth*1,0);
  }
  else if(isLightweightSpaceShip)
  {
    drawLine(wardSectionWidth*2,0);
  }
  else if(isHeavyweightSpaceShip)
  {
    drawLine(wardSectionWidth*3,0);
  }
  else if(isGliderGun)
  {
    drawLine(wardSectionWidth*4,0);
  }
  else
  {
  }
}

void saveCircle()
{
  for(int i=0; i<circleX.length; i++)
  {
    saveCircleX[i]=circleX[i];
    saveCircleY[i]=circleY[i];
  }
}
void drawLine(int initialX,int initialY)
{
  
  if(switchVector)
  {
    x = x+vx;
  }
  else
  {
    y = y+vy;
  }
  
  if(x<0 || x > wardSectionWidth)
  {
    vx = vx * (-1);
    switchVector = false;
    if(x<0)
    {
      x=0;
    }
    else
    {
      x=wardSectionWidth;
    }
  }
  if(y<0 || y > wardSectionHeight+pictureSectionHeight)
  {
    vy = vy * (-1);
    switchVector = true;
    if(y<0)
    {
      y=0;
    }
    else
    {
      y=wardSectionHeight+pictureSectionHeight;
    }
  }
  
  circleX[0]=initialX+x;
  circleY[0]=initialY+y;
  for(int i=1; i<circleX.length; i++)
  {
    circleX[i]=saveCircleX[i-1];
    circleY[i]=saveCircleY[i-1];
  }
  
  for(int i=0; i<circleX.length; i++)
  {
    noStroke();
    fill(((360)+(2*i))%360,100,100,255-transparentRate[i]);
    circle(circleX[i],circleY[i],8);
  }
}
