PImage player, p_low, player1, bird, p_low2, backgroundimg, play, quit, instructions, instructions2, cloud, obs1, obs2, obs3, obs4, obs5, lvl1, lvl2, lvl3, lvl4, lvl5, gif, gif2, gif3, square, square2, montanhas;
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
boolean level_up = false;
PFont f;


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
  obs1 = loadImage("obs1.png");
  obs2 = loadImage("obs2.png");
  obs3 = loadImage("obs3.png");
  obs4 = loadImage("obs4.png");
  obs5 = loadImage("obs5.png");
  lvl1 = loadImage("popup1.png");
  lvl2 = loadImage("popup2.png");
  lvl3 = loadImage("popup3.png");
  lvl4 = loadImage("popup4.png");
  lvl5 = loadImage("popup5.png");
  pl = new Player();
  f = loadFont("ArcadeClassic.vlw");
  gif = loadImage("gif.png");
  gif2 = loadImage("gif2.png");
  gif3 = loadImage("gif3.png");
  square = loadImage("square.png");
  square2 = loadImage("square2.png");
  montanhas = loadImage("montanhas.png");
}

void initGame() {
  background(241, 90, 36);
  backgroundimg = loadImage("background.png");
  image(backgroundimg, 0, 0);
  image(play, width/2-play.width/2, height-play.height); 
  image(quit, width/2+quit.width, height-quit.height);
  image(instructions, width-instructions.width, 0);
  if (mousePressed) {
    if ((mouseX>width/2-play.width/2)&&(mouseY>height-play.height)&&(mouseX<width/2+play.width/2)&&(mouseY<height)) {
      state = "play";
    }
    if ((mouseX>width/2+quit.width)&&(mouseY>height-quit.height)&&(mouseX<width/2+quit.width*2)&&(mouseY<height)) {
      exit();
    }
  }
  if ((mouseX>width-instructions.width)&&(mouseY>0)&&(mouseX<width)&&(mouseY<instructions.height)) {
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
    updateObstacles(); 
    level();
    //println(pb);

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
      loop();
    }
    break;
  }
}

void mousePressed() {
  if (level_up == true) {
    loop();
  }
  if (pl.bump == true) {
    loop();
    pl.bump = false;
    playerXpos += 100;
  }
}

void game_display() {
  noStroke();
  background(106, 190, 219);
  rectMode(CORNER);
  fill(96, 56, 19);
  rect(0, height - groundHeight, width, height - groundHeight);
  fill(66, 33, 11);
  rect(0, height - groundHeight, width, 10);
  textSize(20);
  fill(0);
  textAlign(LEFT);
  textFont(f);
  imageMode(CORNER);
  image(square2, 10, 10);
  text("Level: " + lvl, 60, 60);
  imageMode(CENTER);
  image(square, width/2, 550);
  textAlign(CENTER);
  text("Lives: " + lf, width/2, 560);
  textAlign(CORNER);
  text("High Score: " + highScore, width - 350, 60);
}

void level() {
  for (int i=1; i<20; i++) {
    if ( pl.score == 2000*i) {
      noLoop();
      level_up = true;   
      lvl++;
      speed++;
      pb=pb+2*i;
      if (lvl==1) {
        imageMode(CENTER);
        image(lvl1, width/2, height/2, lvl1.width/1.2, lvl1.height/1.2);
      } else if (lvl==2) {
        imageMode(CENTER);
        image(lvl2, width/2, height/2, lvl2.width/1.2, lvl2.height/1.2);
      } else if (lvl==3) {
        imageMode(CENTER);
        image(lvl3, width/2, height/2, lvl3.width/1.2, lvl3.height/1.2);
      } else if (lvl==4) {
        imageMode(CENTER);
        image(lvl4, width/2, height/2, lvl4.width/1.2, lvl4.height/1.2);
      } else if (lvl==5) {
        imageMode(CENTER);
        image(lvl5, width/2, height/2, lvl5.width/1.2, lvl5.height/1.2);
      }
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
      lf -= 1;
      if (lf==2) {
        imageMode(CENTER);
        image(gif, width/2, height/2, gif.width/1.5, gif.height/1.5);
      } else if (lf==1) {
        imageMode(CENTER);
        image(gif2, width/2, height/2, gif2.width/1.5, gif2.height/1.5);
      }
      //
    }
  } 
  if (lf == 0) {
    pl.dead = true;
    pl.bump = false;
    imageMode(CENTER);
    image(gif3, width/2, height/2, gif3.width/1.5, gif3.height/1.5); 
    noLoop();
  }
}

void showObstacles() {
  for (int i=0; i < clouds.size(); i++) {
    clouds.get(i).show();
  }
  for (int i = 0; i < obstacles.size(); i++) {
    obstacles.get(i).show();
  }
  for (int i=0; i < birds.size(); i++) {
    birds.get(i).show();
  }
}

void addObstacle(float pb) {
  if (random(100) < pb) {
    clouds.add(new Cloud(floor(random(2))));
  }
  if (random(100) < pb) { //Probabilidade de aparecer um obstáculo vai aumentando de nível para nível
    //obstacles.add(new Obstacle(floor(random(2)))); //Dos 3 tipos de obstáculos possíveis seleciona 1
    birds.add(new Bird(floor(random(4))));
  } else {
    birds.add(new Bird(floor(random(4))));
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
  pl.bump = false;
  pl.dead = false;
  pl = new Player();
  obstacles = new ArrayList<Obstacle>();
  birds = new ArrayList<Bird>();
  clouds = new ArrayList<Cloud>();
  obstacleTimer = 0;
  randomAddition = floor(random(50));
  groundCounter = 0;
  speed = 10;
  lvl = 0;
  pb = 70;
  playerXpos = 100;
  lf = 3;
}
