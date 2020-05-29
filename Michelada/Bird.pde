class Bird {
  float w = 60;
  float h = 90;
  float posX, posY;
  int flapCount = 0;
  int y= 150;
  int type;

  Bird(int t) {
    posX = width;
    type = t;
    switch(t) {
    case 0: 
      posY = 150; //mais baixo
      image(obs1, w,h);
      break;
    case 1: 
      posY = 150;
      image(obs2, w,h);
      break;
      case 2: 
      posY = 150;
      image(obs3, w,h);
      break;
      case 3: 
      posY = 150;
      image(obs4, w,h);
      break;
      case 4: 
      posY = 150;
      image(obs5, w,h);
      break;
    }
  }

  void show() {
    flapCount++;
    /*if(flapCount < 0){
     image(bird, posX - bird.width / 2, height - groundHeight - (posY + bird.height - 20));
     }
     else{
     image(bird1, posX - bird1.width / 2, height - groundHeight - (posY + bird1.height - 20));
     }
     if(flapCount > 15){
     flapCount = -15;
     }*/
    //image(bird, posX, height - groundHeight - (posY + h ), w, h);
  }

  void move(float speed) {
    posX -= speed;
  }

  boolean collided(float playerX, float playerY, float playerWidth, float playerHeight) {
    float playerLeft = playerX - playerWidth / 2;
    float playerRight = playerX + playerWidth / 2;
    float thisLeft = posX;
    float thisRight = posX;

    if (playerLeft < thisRight && playerRight > thisLeft) { //verifica onde está o obstáculo
      float playerDown = playerY - playerHeight / 2;
      float playerUp = playerY + playerHeight / 2;
      float thisUp = posY + h / 2;
      float thisDown = posY - h / 2;
      if (playerDown <= thisUp && playerUp >= thisDown) {
        return true;
      }
    }
    return false;
  }
}
