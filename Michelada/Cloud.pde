class Cloud {
  float posX, posY;
  int type;

  Cloud(int t) {
    posX = width;
    type = t;
  }

  void show() {
    imageMode(CORNER);
    switch(type) {
    case 0:
      image(cloud, posX, 160);
      image(montanhas, posX + 850, height - groundHeight - montanhas.height);
      break;
    case 1:
      image(cloud, posX, 260);
      image(montanhas, posX + 450, height - groundHeight - montanhas.height);
      break;
    }
  }

  void move(float speed) {
    posX -= speed;
  }
}
