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
      image(cloud, posX, 100);
      image(montanhas, posX+250, 330);
      break;
    case 1:
      image(cloud, posX, 200);
      image(montanhas,posX+450, 330);
      break;
    }
  }

  void move(float speed) {
    posX -= speed;
  }
}
