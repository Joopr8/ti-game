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
      image(cloud, posX, 110, cloud.width/1.5, cloud.height/1.5);
      image(montanhas, posX + 850, height - groundHeight - montanhas.height/2, montanhas.width/2, montanhas.height/2);
      break;
    case 1:
      image(cloud, posX, 200, cloud.width/1.5, cloud.height/1.5);
      image(montanhas, posX + 450, height - groundHeight - montanhas.height/2,montanhas.width/2, montanhas.height/2);
      break;
    }
  }

  void move(float speed) {
    posX -= speed;
  }
}
