class Star{
  float x,y,corewidth, edgewidth, brightness;
  boolean upDown = true;
  
  public Star(int starx, int stary){
    x = starx;
    y = stary;
    brightness = random(255);
    corewidth = random(1, 4);
  }
  
  public void draw() {
     if(brightness <= 100 || brightness >= 254){
        upDown = !upDown;
     }
     if(upDown == true){
       brightness++;
     } else {
       brightness--;
     }
     fill(#FFFFFF, brightness);
     rect(x,y,corewidth, corewidth);
  }
}

