void displaySituation()
{
  int countCell1=MainWindow.countCell1();
  int countCell2=MainWindow.countCell2();
  textAlign(CENTER);
  textSize(30);
  fill(255,255,200);
  text(countCell1+" VS "+countCell2, mainWindowSizeWidth/2, 50);
}
