class ActionMessage{
  String messageToDisplay;
  int messageWidth;
  int ticks = 0;
  int numberOfFrames;
  
  ActionMessage(String messageText){
    messageToDisplay = messageText;
  }
  
  void draw(){
    messageWidth = (int) textWidth(messageToDisplay);
    numberOfFrames = messageWidth/2;
    if(ticks < numberOfFrames && ticks>0){
      textFont(f,16);
      fill(#FFFFFF);
      text(messageToDisplay, menuPosition+10, 34);
      ticks++;
    } else if(ticks == numberOfFrames){
      ticks = 0;
    }
  }
}
