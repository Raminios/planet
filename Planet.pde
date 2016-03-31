class Bell {
  
  float x;
  float y;
  float velx;
  float vely;
  float ballWidth;
  float ballHeight;
  float ballRadX;
  float ballRadY;
  float gravity;
  int c1;
  int c2;
  int c3;
  int c4;
  int id;
  boolean dead = false;
  boolean overBox = false;
  boolean frozen = false;
  boolean fixed = false;
  String name;
  
  public Bell(float startX, float startY,float startVelX,float startVelY, int ballWid, int ballHei, int idToSend, String namePassed) {
    y = startY;
    x = startX;
    name = namePassed;
    ballWidth = ballWid;
    ballHeight = ballHei;
    ballRadX = ballWidth/2;
    ballRadY = ballHeight/2;
    velx = startVelX;
    vely = startVelY;
    id = idToSend;
    c1 = (int) random(255);
    c2 = (int) random(255);
    c3 = (int) random(255);
    gravity = 0;
  }
  
  public void draw() {
    if(frozen == false && fixed == false){
        y += vely;
        x += velx;
    }
    
    if(y<height){
      vely+= gravity;
    }
    
    fill(c1,c2,c3);
    ellipse(x,y,ballWidth,ballHeight);
    textFont(f,16);
    fill(#FFFFFF);
    text(name, x+ballRadX+5, y+ballRadX);
    
    if (overBox){
      text("X Velocity: " + velx, x+ballRadX+5, y+ballRadX + 20);
      text("Y Velocity: " + vely, x+ballRadX+5, y+ballRadX + 40);
      text("Mass: " + ballWidth, x+ballRadX+5, y+ballRadX + 60);
    }
    if(jamesMode){
      image(img, x-(ballWidth/2), y-(ballWidth/2), ballWidth+10, ballHeight+10);
    }
    
    if(wrapMode){
      if(y>=height+ballRadY){
        y = 0-ballRadY;
      } else if(y <= 0-ballRadY){
        y = height+ballRadY;
      }
      
      if(x>=width+ballRadX){
        x = 0-ballRadX;
      } else if(x <= 0-ballRadX){
        x = width+ballRadX;
      }
    }
    //} else {
    //  if(y>=height-ballRadY){
    //    y = height-ballRadY;
    //    vely-=(vely*1.6);
    //  } else if(y <= 0+ballRadY){
    //    y = 0+ballRadY;
    //    vely-=(vely*1.6);
    //  }
      
    //  if(x>=width-ballRadX){
    //    x = width-ballRadX;
    //    velx-=(velx*1.6);
    //  } else if(x <= 0+ballRadX){
    //    x = 0+ballRadX;
    //    velx-=(velx*1.6);
    //  }
    //}
    
    for(Bell Bob : bobs){
      if(id != Bob.id){
         float diffY = ((Bob.y - y)*(Bob.y - y))/(Bob.y - y);
         float diffX = ((Bob.x - x)*(Bob.x - x))/(Bob.x - x);
         float vectorY;
         float vectorX;
         float collVector;
         
         vectorY = (diffY*diffY);
         vectorX = (diffX*diffX);
         
         collVector = (sqrt(vectorX+vectorY));
         
         if(collVector < (Bob.ballRadX*100)){
             vely -= ((Bob.ballWidth*(y-Bob.y))/(collVector*2000));
             velx -= ((Bob.ballWidth*(x-Bob.x))/(collVector*2000));
         }
                  
         if (collVector < (ballRadX + Bob.ballRadX)){;
           if(jamesMode){
             //player = minim.loadFile("merr.mp3");
             //player.play();
           }
           float COR = 0;
           float m1 = ballWidth;
           float m2 = Bob.ballWidth;
           float u1x = velx;
           float u2x = Bob.velx;
           float u1y = vely;
           float u2y = Bob.vely;
           float a1 = PI*((ballRadX)*(ballRadX));
           float a2 = PI*((Bob.ballRadX)*(Bob.ballRadX));
           float finalRadius = sqrt(((a1+a2)/PI));
           
           float vx1 = ((m1*u1x) + (m2*u2x) + ((m2*COR)*(u2x-u1x)))/(m1+m2);
           float vx2 = ((m1*u1x) + (m2*u2x) + ((m1*COR)*(u1x-u2x)))/(m1+m2);
           float vy1 = ((m1*u1y) + (m2*u2y) + ((m2*COR)*(u2y-u1y)))/(m1+m2);
           float vy2 = ((m1*u1y) + (m2*u2y) + ((m1*COR)*(u1y-u2y)))/(m1+m2);
           
           if(Bob.ballWidth > ballWidth){
             Bob.ballWidth = finalRadius*2;
             Bob.ballHeight = finalRadius*2;
             Bob.ballRadX = finalRadius;
             Bob.ballRadY = finalRadius;
             Bob.velx = vx2;
             Bob.vely = vy2; 
             dead = true;
           } else {
             ballWidth = finalRadius*2;
             ballHeight = finalRadius*2;
             ballRadX = finalRadius;
             ballRadY = finalRadius;
             frozen = Bob.frozen;
             fixed = Bob.fixed;
             velx = vx1;
             vely = vy1;
             Bob.dead = true;
           }

           
           
         }
      }
    }
  }  
}