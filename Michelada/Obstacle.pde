class Obstacle {
  float posX;
  int type;
  int w = 60; //ajustar estes valores
  int h = 90;

  Obstacle(int t) {
    posX = width;
    type = t;
  }

  void show() {
    imageMode(CORNER);
    switch(type) {
    case 0:
      image(obs1, posX, height-groundHeight-h, w,h);
      break;
    case 1:
      image(obs2, posX , height-groundHeight-h, w,h);
      break;
    case 2:
      image(obs3, posX, height-groundHeight-h, w,h);
      break;
      case 3:
      image(obs4, posX, height-groundHeight-h, w,h);
      break;
      case 4:
      image(obs5, posX, height-groundHeight-h, w,h);
      break;
    }
  }

  void move(float speed) {
    posX -= speed;
  }

  boolean collided(float playerX, float playerY, float playerWidth, float playerHeight) {
    float playerLeft = playerX - playerWidth / 2;
    float playerRight = playerX + playerWidth / 2;
    float thisLeft = posX;
    float thisRight = posX + w;

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
