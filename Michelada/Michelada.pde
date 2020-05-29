PImage player, p_low, player1, bird, p_low2, backgroundimg, play, quit, instructions, instructions2, cloud;
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<Bird> birds = new ArrayList<Bird>();
ArrayList<Cloud> clouds = new ArrayList<Cloud>();
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
int lf = 3;


Player pl;

void setup() {
  size(800, 600);
  frameRate(60);
  player1 = loadImage("andar2.png");
  player = loadImage("andar1.png");
  p_low = loadImage("chao1.png");
  p_low2 = loadImage("chao2.png");
  bird = loadImage("vidas.png");
  instructions= loadImage("instructions.png");
  play= loadImage("play.png");
  quit= loadImage("quit.png");
  cloud = loadImage("nuvens.png");
  pl = new Player();
}

void initGame() {
  background(200, 90, 36);
  backgroundimg = loadImage("background.png");
  image(backgroundimg, 0, 0);

  image(play, width/2-play.width/2, height-play.height); 
  image(quit, width/2+quit.width, height-quit.height);

  image(instructions, width-instructions.width, 0);
  if (mousePressed) {
    if ((mouseX>width/2-play.width/2)&&(mouseY>height-play.height)&&(mouseX<width/2+play.width/2)&&(mouseY<height))
    {
      state = "play";
    }
    if ((mouseX>width/2+quit.width)&&(mouseY>height-quit.height)&&(mouseX<width/2+quit.width*2)&&(mouseY<height))
    {
      exit();
    }
  }
  if ((mouseX>width-instructions.width)&&(mouseY>0)&&(mouseX<width)&&(mouseY<instructions.height))
  {
    instructions2= loadImage("instructions2.png");
    image(instructions2, width/2-instructions2.width/2, height/2-instructions2.height/2);
  }
}

void draw() {
  if (state=="menu") {
    initGame();
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
  textAlign(LEFT);
  text("Score: " + pl.score, 5, 20);
  text("Level: " + lvl, 5, 40);
  text("Lifes: " + lf, 5, 60);
  text("High Score: " + highScore, width - (140 + (str(highScore).length() * 10)), 20);
}

void level() {
  for (int i=1; i<20; i++) {
    if ( pl.score == 400*i) {
      //noLoop();
      level_up();
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
    if (pl.bump == true) {
      noLoop();
      lf-=1;
      textSize(32);
      text(lf, width/2, height/2);
      textSize(16);
      textAlign(CENTER);
      text("Click to continue!", width/2, 20);
    }
  } 
  if (lf == 0) {
    pl.dead = true;
    pl.bump = false;
    textSize(32);
    fill(0);
    text("YOU DEAD! GIT GUD SCRUB!", width/2, 200);
    textSize(16);
    text("(Press 'r' to restart!)", width/2, 230);
  }
}

void mousePressed() {
  if (pl.bump == true) {
    loop();
    pl.bump = false;
    playerXpos += 100;
  }
}

void level_up() {
  fill(255);
  textSize(16);
  text("Level up", width/2, 230);
}

void showObstacles() {
  for (int i = 0; i < obstacles.size(); i++) {
    obstacles.get(i).show();
  }
  for (int i=0; i < birds.size(); i++) {
    birds.get(i).show();
  }
  for (int i=0; i < clouds.size(); i++) {
    clouds.get(i).show();
  }
}

void addObstacle(float pb) {
  if (random(100) < pb) { //Probabilidade de aparecer um obstáculo vai aumentando de nível para nível
    obstacles.add(new Obstacle(floor(random(2))));//Dos 3 tipos de obstáculos possíveis seleciona 1
  } else {
    birds.add(new Bird(floor(random(2))));
  }
  if(random(100) < pb){
  clouds.add(new Cloud(floor(random(2))));
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
  for (int i = 0; i < clouds.size(); i++) {
    clouds.get(i).move(speed);
    if (clouds.get(i).posX < -playerXpos*10) { 
      clouds.remove(i);
      i--;
    }
  }
}

void reset() {
  loop();
  pl = new Player();
  obstacles = new ArrayList<Obstacle>();
  birds = new ArrayList<Bird>();
  obstacleTimer = 0;
  randomAddition = floor(random(50));
  groundCounter = 0;
  speed = 10;
  lvl = 0;
  pb = 70;
  playerXpos = 100;
}
