class Menu{
  String boxText;
  String boxMessage;
  float x,y,boxWidth, boxHeight, textBoxHeight, textBoxWidth, spacer;
  boolean hoverOver = false;
  
  public Menu(String hoverText, String Message){
    spacer = 4;
    boxText = hoverText;
    boxMessage = Message;
    x = menuPosition;
    y = 20;
    boxWidth = textWidth(Message) + spacer*3;
    boxHeight = 20;
    textBoxWidth = 200;
    textBoxHeight = ((round(((textWidth(hoverText)/(textBoxWidth-5)))+0.5))* 27);
    if(textBoxHeight < 20){
      textBoxHeight = 20;
    }
    menuPosition += boxWidth + spacer;
  }
  
  public void draw(){
    textFont(f,16);
    fill(#D8D4D4, 150);
    rect(x,y,boxWidth, boxHeight);
    fill(#FFFFFF);
    text(boxMessage, x+spacer, y+14);
    if(hoverOver){
       fill(#D8D4D4, 150);
       rect(x,y + boxHeight + spacer,textBoxWidth+spacer, textBoxHeight+spacer);
       fill(#FFFFFF);
       text(boxText, x+spacer, y+ boxHeight + spacer, textBoxWidth, textBoxHeight+spacer);
    }
  }
}
