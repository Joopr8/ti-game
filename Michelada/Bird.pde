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
      image(obs1, w, h);
      break;
    case 1: 
      posY = 150;
      break;
    case 2: 
      posY = 150;
      break;
    case 3: 
      posY = 150;
      break;
    }
  }

  void show() {
    imageMode(CORNER);
    flapCount++;
    if (flapCount <= 10) {
      image(obs1, posX - obs1.width / 2, height - groundHeight - (posY + obs1.height), w, h);
    } 
    if (flapCount <= 20 && flapCount > 10 ) {
      image(obs2, posX - obs2.width / 2, height - groundHeight - (posY + obs2.height), w, h);
    }
    if (flapCount <= 30 && flapCount > 20 ) {
      image(obs3, posX - obs2.width / 2, height - groundHeight - (posY + obs3.height), w, h);
    }
    if (flapCount <= 40 && flapCount > 30 ) {
      image(obs4, posX - obs2.width / 2, height - groundHeight - (posY + obs4.height), w, h);
    }
    if (flapCount <= 50 && flapCount > 40 ) {
      image(obs5, posX - obs2.width / 2, height - groundHeight - (posY + obs5.height), w, h);
    }
    if (flapCount > 50) {
      flapCount = 0;
    }
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
