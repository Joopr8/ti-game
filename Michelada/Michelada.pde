PImage player, p_low, player1, bird, p_low2;
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<Bird> birds = new ArrayList<Bird>();
int obstacleTimer = 0;
int minTimeBetObs = 60;
int randomAddition = 0;
int groundCounter = 0;
float speed = 10;
int groundHeight = 100;
int playerXpos = 100;
int highScore = 0;
int lvl=0;
float pb=70;
String state="menu";

Player pl;

void setup() {
  size(800, 600);
  frameRate(60);
  player1 = loadImage("andar2.png");
  player = loadImage("andar1.png");
  p_low = loadImage("chao1.png");
  p_low2 = loadImage("chao2.png");
  bird = loadImage("vidas.png");
  pl = new Player();
}

void initGame() {
}

void draw() {
  if (state=="menu") {
    initGame();
    String s = "O Jorge é um paneleiro";
    fill(50);
    text(s, 10, 10, 70, 80);
    if (mousePressed) {
      state = "play";
    }
  }
  if (state == "play") {
    game_display();
    level();
    updateObstacles(); 
    if (pl.score > highScore) { //Upadate do melhor resultad
      highScore = pl.score;
    }
  }
}

void keyPressed() {
  switch(key) {
  case ' ': 
    pl.jump();
    break;
  case 'b': 
    if (!pl.dead) {
      pl.ducking(true);
    }
    break;
  }
}

void keyReleased() {
  switch(key) {
  case 'b': 
    if (!pl.dead) {
      pl.ducking(false);
    }
    break;
  case 'r': 
    if (pl.dead) {
      reset();
    }
    break;
  }
}

void game_display() {
  noStroke();
  background(106, 190, 219);
  fill(96, 56, 19);
  rect(0, height - groundHeight, width, height - groundHeight);
  fill(66, 33, 11);
  rect(0, height - groundHeight, width, 10);
  textSize(20);
  fill(0);
  text("Score: " + pl.score, 5, 20);
  text("Level: " + lvl, 5, 40);
  text("High Score: " + highScore, width - (140 + (str(highScore).length() * 10)), 20);
}

void level() {
  for (int i=1; i<20; i++) {
    if ( pl.score == 400*i) {
      lvl++;
      speed++;
      pb=pb+2*i;
    }
  }
}


void updateObstacles() {
  showObstacles();
  pl.show();
  if (!pl.dead) {
    obstacleTimer++; //Aumenta desde que o player inicia o jogo
    if (obstacleTimer > minTimeBetObs + randomAddition) { //Faz a temporização da adição de novos obstáculos
      addObstacle(pb);
    }
    groundCounter++;
    if (groundCounter > 10) {
      groundCounter = 0;
    }
    moveObstacles();
    pl.update();
  } else {
    textSize(32);
    fill(0);
    text("YOU DEAD! GIT GUD SCRUB!", 180, 200);
    textSize(16);
    text("(Press 'r' to restart!)", 330, 230);
  }
}

void showObstacles() {
  for (int i = 0; i < obstacles.size(); i++) {
    obstacles.get(i).show();
  }
  for (int i=0; i < birds.size(); i++) {
    birds.get(i).show();
  }
}

void addObstacle(float pb) {
  //println(lvl);
  //println(pb);
  if (random(100) < pb) { //Probabilidade de aparecer um obstáculo vai aumentando de nível para nível
    obstacles.add(new Obstacle(floor(random(2)))); //Dos 3 tipos de obstáculos possíveis seleciona 1
  } else {
    birds.add(new Bird(floor(random(2))));
  }
  randomAddition = floor(random(50));
  obstacleTimer = 0;
}

void moveObstacles() {
  for (int i = 0; i < obstacles.size(); i++) {
    obstacles.get(i).move(speed);
    if (obstacles.get(i).posX < -playerXpos) {
      obstacles.remove(i);
      i--;
    }
  }
  for (int i = 0; i < birds.size(); i++) {
    birds.get(i).move(speed);
    if (birds.get(i).posX < -playerXpos) {
      birds.remove(i);
      i--;
    }
  }
}

void reset() {
  pl = new Player();
  obstacles = new ArrayList<Obstacle>();
  birds = new ArrayList<Bird>();
  obstacleTimer = 0;
  randomAddition = floor(random(50));
  groundCounter = 0;
  speed = 10;
  lvl = 0;
  pb = 70;
}
