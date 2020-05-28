class Obstacle {
  float posX;
  int type;
  float ts = random(90,200);
  int w = 30; //ajustar estes valores
  int h = 70;

  Obstacle(int t) {
    posX = width;
    type = t;
  }

  void show() {
    switch(type) {
    case 0:
      color(60);
      rect(posX - w/2, height-h-groundHeight, w, h);
      break;
    case 1:
      color(60);
      rect(posX - w/2, height-h-groundHeight, w*2, h);
      break;
    case 2:
      color(60);
      rect(posX - w/2, height-h-groundHeight, w*6, h);
      break;
    }
  }

  void move(float speed) {
    posX -= speed;
  }

  boolean collided(float playerX, float playerY, float playerWidth, float playerHeight) {
    float playerLeft = playerX - playerWidth / 2;
    float playerRight = playerX + playerWidth / 2;
    float thisLeft = posX - w / 2;
    float thisRight = posX + w / 2;

    if (playerLeft < thisRight && playerRight > thisLeft) { //verifica onde está o obstáculo 
      float playerDown = playerY - playerHeight / 2;
      float thisUp = h;
      if (playerDown < thisUp) { //Se nao saltou
        return true; //Houve colisão 
      }
    }
    return false;
  }
}
