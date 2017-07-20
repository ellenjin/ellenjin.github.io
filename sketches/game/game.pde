int xPosition = 125;

ArrayList<ball1> balls;
Points points;


void setup() {
  size(400, 400);
  balls = new ArrayList<ball1>();
  balls.add( new ball1());
  points = new Points();
  //loadImage(Leafers.svg);
}

void draw() {  
    background(240, 228, 228);  //just the background
    noStroke();

    writingOnScreen();

    for (int i = 0; i < balls.size(); i++)
    {
      ball1 ball = balls.get(i);
      fill(255, 0, 0); //initial ball 
      ellipse(ball.x, ball.y, 45, 45);
    }

    if (balls.get(balls.size() - 1).y == 150) { 
       ball1 newBall = new ball1();
   
    balls.add(newBall);
  }

  if (balls.get(0).y == 300) {
    balls.remove(0);
  }
  fill(175, 225, 240); //ground
  rect(0, 300, 400, 300);

  moveCharacter();

  //image(getImage("cute/CharacterBoy"), xPosition, 195, 100, 175);

  for (int i = 0; i < balls.size(); i++)
  {
    ball1 ball = balls.get(i);
    ball.y += 2;

    if ((xPosition <= ball.x && ball.x <= 100 + xPosition) && (ball.y == 250)) {
      points.score++;
      balls.remove(0);
    } else if ((xPosition != ball.x && ball.x != 100 + xPosition) && (ball.y ==300)) {
      points.lives--;

      if (points.lives <= 0) {
        noLoop(); 
        fill(255, 0, 0); // start color
        background(2, 5, 75); 

        endScene();
      }
    }
  }
};

//Reset game button/screen/command
void endScene() {
    fill(255, 0, 0); // start color
    background(2, 5, 75);
    rect(75, 150, 250, 100);  // the button
    // The button text
    fill(0, 0, 0);
    textSize(30);
    text("GAME OVER", 105, 195);
    textSize(21);
    text("Click screen to restart", 100, 230);
  };
  
void mousePressed() { 
    if (points.lives <= 0) {
      points.lives = 3;
      points.score = 0;
      loop();
    }
  };
  
//character movement
void moveCharacter() {
    //chara. to the right
    if (keyPressed && keyCode == RIGHT && xPosition < 315) { 
      xPosition+= 5;
    }
    if (keyPressed && keyCode == LEFT && xPosition > -15) { //chara. to the left
      xPosition -= 5;
    }
  };

//points, lives left, TESTING
void writingOnScreen() {
    textSize(21);
    fill(194, 58, 58);
    text("Points: " + points.score, 20, 60); //the player's score / number of balls caught
    text("Lives Left: " + points.lives, 20, 90); // number of lives left

    textSize(10);
    text("FOR TESTING: " + balls.size(), 310, 60); //numbers of balls on the screen
  }; 

class ball1 {
   float x, y;
  
  public ball1() {
    x = random(0, 315); 
    y = -10;
  }
}

  /*int bomb1 = {
  x: random(0, 315), 
  y: -10
  }; */

class Points {
   int score, lives;
  
  public Points() {
    score = 0;
    lives = 3;
  }
}