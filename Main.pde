//import ddf.minim.*;

//Minim minim;
//AudioPlayer player;
//AudioInput input;

PFont f;
PImage img; 
ArrayList<Bell> bobs;
ArrayList<Star> stars;
ArrayList<Menu> menus;
int noOfBalls = 100;
int noOfStars = 1000;
int maxSize = 10;
int minSize = 1;
int jamesModeCounter = 0;
int id = 0;
int namestarter, nameender;
int menuPosition = 20;
int[] xCoords;
int[] yCoords;
int[] diameters;
String[] nameStarts;
String[] nameEnds;
String[] menuText;
String name;
boolean jamesMode = false;
boolean wrapMode = false;
ActionMessage message;

void setup(){
  size(1440, 900);
  frame.setTitle("Planet Simulator Alpha/Prerelease");
  
  img = loadImage("james.png");
  
  //minim = new Minim(this);
  //input = minim.getLineIn();
  //player = minim.loadFile("merr.mp3");
  
  f = createFont("calibri", 20, true);
  nameStarts = loadStrings("starts.txt");
  nameEnds = loadStrings("ends.txt");
  menuText = loadStrings("menutext.txt");
  
  bobs = new ArrayList<Bell>();
  stars = new ArrayList<Star>();
  menus = new ArrayList<Menu>();
  xCoords = new int[noOfBalls];
  yCoords = new int[noOfBalls];
  diameters = new int[noOfBalls];
  message  = new ActionMessage("");
  
  noStroke();
  frameRate(60);
  ellipseMode(CENTER);
  
  for(int i=0; i<menuText.length; i++){
    Menu menu = new Menu(menuText[i+1], menuText[i]);
    menus.add(menu);
    i++;
  }
  
  for(int i=0; i<noOfStars; i++){
    int xpos = (int) random(width);
    int ypos = (int) random(height);
    Star star = new Star(xpos, ypos);
    stars.add(star);
  }
  
  for(int i=0; i<noOfBalls; i++){
     int xpos = (int) random(width);
     int ypos = (int) random(height);
     int diameter = (int) random(minSize, maxSize);
     int namestarter = (int) random(nameStarts.length);
     int nameender = (int) random(nameEnds.length);
     if(id>0){
       int[] xypos = checker(xpos, ypos, diameter, 0, 0);
       xpos = xypos[0];
       ypos = xypos[1];
       diameter = xypos[2];
     }
     if(xpos != -1){
       xCoords[id] = xpos; 
       yCoords[id] = ypos;
       diameters[id] = diameter;
       name = (nameStarts[namestarter]);
       name +=  nameEnds[nameender];
       Bell Bob = new Bell(xpos, ypos, random(-1, 1), random(-1, 1), diameter, diameter, id, name);
       bobs.add(Bob); 
       id++;
     } else {
       i = noOfBalls; 
     }
  } 
}

void draw(){
  background(#000000);
  cursor(CROSS);
  for(Star star : stars){
    star.draw();
  }
  for(int a=0; a<bobs.size(); a++){
    Bell Bob = bobs.get(a);
    if (mouseX > (Bob.x - Bob.ballRadX) && mouseX < (Bob.x + Bob.ballRadX) 
    && mouseY > (Bob.y - Bob.ballRadY) && mouseY < (Bob.y + Bob.ballRadY)) {
      Bob.overBox = true;
    } else {
      Bob.overBox = false; 
    }
    if(Bob.frozen||Bob.fixed){
      Bob.velx = 0;
      Bob.vely = 0;
    }
    Bob.draw(); 
    if(Bob.dead == true){
        bobs.remove(a); 
        a--;
    }
  }
  for(Menu menu : menus){
    if (mouseX > menu.x && mouseX < menu.x+menu.boxWidth 
    && mouseY > menu.y && mouseY < menu.y+menu.boxHeight){
      menu.hoverOver = true;
    } else {
      menu.hoverOver = false;
    }
    menu.draw();
  }
  message.draw();
}

void mousePressed() {
  if (mouseButton == LEFT){
    for(Bell Bob : bobs){
      if(Bob.overBox == true) { 
        Bob.velx = 0;
        Bob.vely = 0; 
        Bob.frozen = true;
      }
    }
  } else if (mouseButton == RIGHT){
   int xpos = mouseX;
   int ypos = mouseY;
   int diameter = minSize;
   int namestarter = (int) random(nameStarts.length);
   int nameender = (int) random(nameEnds.length);
   name = (nameStarts[namestarter]);
   name +=  nameEnds[nameender];
   Bell Bob2 = new Bell(xpos, ypos, random(-1, 1), random(-1, 1), diameter, diameter, id, name);
   bobs.add(Bob2); 
   id++;
   Bob2.velx = 0;
   Bob2.vely = 0; 
   Bob2.frozen = true;
   Bob2.ballWidth += 5;
   Bob2.ballHeight += 5;
   Bob2.ballRadX = Bob2.ballWidth/2;
   Bob2.ballRadY = Bob2.ballWidth/2;
  } else if (mouseButton == CENTER){
    for(Bell Bob : bobs){
      if(Bob.overBox == true) { 
        Bob.velx = 0;
        Bob.vely = 0; 
        Bob.frozen = true;
        Bob.fixed = !Bob.fixed;
      } 
    }
 }
}

void mouseWheel(MouseEvent event) {
   float e = event.getAmount();
   for(Bell Bob : bobs){
      if(Bob.overBox == true) { 
        Bob.ballWidth -= e*5;
        Bob.ballHeight -= e*5;
        Bob.ballRadX = Bob.ballWidth/2;
        Bob.ballRadY = Bob.ballWidth/2;
      } 
   }
}

void mouseDragged() {
  for(Bell Bob : bobs){
    if(Bob.frozen == true && Bob.overBox == true) {
        float mouseDiffX = mouseX - Bob.x;
        float mouseDiffY = mouseY - Bob.y;
        Bob.velx = mouseDiffX*3;
        Bob.vely = mouseDiffY*3; 
        Bob.x = mouseX;
        Bob.y = mouseY; 
    } 
  }
}

void mouseReleased() {
  for(Bell Bob : bobs){
    Bob.frozen = false; 
  }
}

void keyPressed() {
  if(key == 'j'){
    if(jamesMode){
      jamesMode = false;
      jamesModeCounter = 0;
      message.messageToDisplay = "Secret James Mode Deactivated... Merrr :(";
      message.ticks = 1;
    } else {
      jamesModeCounter++;
    }
    
    if(jamesModeCounter == 5){
      jamesMode = true;
      message.messageToDisplay = "Secret James Mode Activated! MERRR";
      message.ticks = 1;
    }
  } else if(key == 'w'){
    wrapMode = !wrapMode;
    if(wrapMode == true){
      message.messageToDisplay = "Wrapping Mode Activated";
      message.ticks = 1;
    } else {
      message.messageToDisplay = "Wrapping Mode Deactivated";
      message.ticks = 1;
    }
  }
}

public int[] checker(int posx, int posy, int diameter, int iterator, int iterator2){
    int[] returns = new int[3];
    for(int i=0; i<xCoords.length; i++){
       int proximity = diameter + diameters[i];
       if (posx <= (xCoords[i] + proximity) && posx >= (xCoords[i] - proximity)){
         if (posy <= (yCoords[i] + proximity) && posy >= (yCoords[i] - proximity)){
            posx = (int) random(width);
            posy = (int) random(height);
            if((maxSize - iterator)>minSize && iterator2 == 100){
              diameter--;
              iterator++;
              iterator2 = 0;
            } else if ((maxSize - iterator)<=minSize && iterator2 == 100){               
              returns[0] = -1;
              returns[1] = -1;
              returns[2] = -1;
              return returns;
            }
            iterator2++;
            int deeper[] = checker(posx, posy, diameter, iterator, iterator2);
            posx = deeper[0];
            posy = deeper[1];
            diameter = deeper[2];
         }
       } 
     }
  returns[0] = posx;
  returns[1] = posy;
  returns[2] = diameter;
  return returns;
}