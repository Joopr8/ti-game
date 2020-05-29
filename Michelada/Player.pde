class Player {
  float posY = 200;
  float velY = 0;
  float gravity = 1.2;
  int size = 20;
  boolean duck = false;
  boolean dead = false;
  boolean bump = false;
  int lifespan;
  int score;
  int runCount = -5;
  int w = player.width/2;
  int h = player.height/2;
  int w_low = p_low.width/2;
  int h_low = p_low.height/2;


  Player() {
  }

  void jump() {
    if (posY == 0) {
      gravity = 1.2;
      velY = 16;
    }
  }

  void show() {
    if (duck && posY == 0) { //quando o jogador está baixo
      if (runCount < 0) {
        image(p_low, playerXpos - w/2, height - groundHeight - (posY + h_low), w_low, h_low);
      } else {
        image(p_low2, playerXpos - w/2, height - groundHeight - (posY + h_low), w_low, h_low);
      }
    } else { //jogador pode estar no solo ou no ar 
      if (posY == 0) { //jogador está no solo 
        if (runCount < 0) {
          image(player, playerXpos-w/2, height - groundHeight - (posY + h), w, h);
        } else {
          image(player1, playerXpos-w/2, height - groundHeight - (posY + h), w, h);
        }
      } else { //saltar
        image(player, playerXpos-w/2, height - groundHeight - (posY + h), w, h);
      }
    }
    if (!dead) {
      runCount++;
    }
    if (runCount > 5) {
      runCount = -5;
    }
  }

  void move() {
    posY += velY;
    if (posY > 0) {
      velY -= gravity;
    } else {
      velY = 0;
      posY = 0;
    }

    for (int i = 0; i < obstacles.size(); i++) {
      if (dead) {
        if (obstacles.get(i).collided(playerXpos, posY + h_low/2, w_low*0.5, h_low)) {
          bump = true;
        }
      } else {
        if (obstacles.get(i).collided(playerXpos, posY + h/2, w*0.5, h)) {
          bump = true;
        }
      }
    }

    for (int i = 0; i < birds.size(); i++) {
      if (duck && posY == 0) {
        if (birds.get(i).collided(playerXpos, posY + h_low/2, w_low * 0.5, h_low)) {
          bump = true;
        }
      } else {
        if (birds.get(i).collided(playerXpos, posY + h/2 * 0.5, w, h)) {
          bump = true;
        }
      }
    }
  }

  void ducking(boolean isDucking) {
    if (posY != 0 && isDucking) {
      gravity = 3;
    }
    duck = isDucking;
  }

  void update() {
    incrementCounter();
    move();
  }

  void incrementCounter() {
    lifespan++;
    score += 1;
  }
}
