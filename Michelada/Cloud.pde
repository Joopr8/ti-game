class Cloud {
  float posX, posY;
  int type;
  int w = 30; //ajustar estes valores
  int h = 70;


  Cloud(int t) {
    posX = width;
    type = t;
  }

  void show() {
    imageMode(CORNER);
    switch(type) {
    case 0:
      image(cloud, posX, 50);
      break;
    case 1:
      image(cloud, posX, 200);
      break;
    }
  }

  void move(float speed) {
    posX -= speed;
  }
}
