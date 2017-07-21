int xPosition = 200; //original x position of the character; all of these integer/variables are for the character
int eyeY = 245;
int eyeSize = 12;
int hairY = 205;
int hairSize = 30;
things falling;

ArrayList<things> objects;
Points points;

void setup() {
  size(400, 400);
  objects = new ArrayList<things>();
  objects.add(new things("ball"));
  points = new Points();
}

void draw() {  
    background(240, 228, 228);  //just the background
    noStroke();

    writingOnScreen();

    for (int i = 0; i < objects.size(); i++)
    {
      things ball = objects.get(i); //actually draws the initial ball
      fill(255, 0, 0); //initial ball 
      ellipse(ball.x, ball.y, 45, 45);
    }
for (int i = 0; i < objects.size(); i++)
    {
        falling = objects.get(i);
        if(falling.kind == "ball") {
        fill(255, 0, 0); //initial ball 
        }
        else {
        fill(0, 0, 0);
        }
        ellipse(falling.x, falling.y, 45, 45);
    }
    
    if(objects.get(objects.size() - 1).y == 150 && points.score >= 5 ) { 
        float w = random(1, 3);
        if(w < 2) {
            objects.add(new things("bomb"));
            };
            
           // things.push(bomb);
        } 
        //else {
        // //   objects.add(new things("ball"));
        //    /*var ball = {
        //        x:random(0, 315),
        //        y: -10,
        //        kind: "ball" 
        //    }; */
            
        //    //things.push(ball);
        //}
    
    
    if (objects.get(objects.size() - 1).y == 150) {  //makes it so that more objects keep falling(?)
       things newBall = new things("ball");
   
    objects.add(newBall); //adds a new value to the end of the array.
  }

  if (objects.get(0).y == 300) { //objects dissapear when they reach 300, instead of infinitely falling
    objects.remove(0); //shift - removes the first item of the array
  }
  fill(175, 225, 240); //ground color
  rect(0, 300, 400, 300); //ground's parameters

  moveCharacter();

  fill(245, 123, 254);
  drawCharacter();

  for (int i = 0; i < objects.size(); i++) //I am not quite sure what exactly this line specifically does...
  {
    things ball = objects.get(i);
    ball.y += 2; //makes the ball actually fall/move down

    if ((xPosition - 40 <= ball.x && ball.x <= 40 + xPosition) && (ball.y >= 200 && ball.y <= 280)) { //Add a point if the Character touches the ball. 
      if(ball.kind == "ball") {
      points.score++;
      objects.remove(0);
      }
      else {
      points.lives = 0;
      }
    } 
    else if ((xPosition - 40 != ball.x && ball.x != 40 + xPosition) && (ball.y == 300)) { //Take away a life if the character misses the ball.  //<>//
      if(ball.kind == "ball"){
      points.lives--;
      }

      if (points.lives <= 0) { //When you have no lives left...
        noLoop(); 
        fill(255, 0, 0); // color of the rectangle onscreen with text
        background(2, 5, 75); 

        endScene(); //game over scene
      }
    }
  }
};

//end/screen/command
void endScene() {
    background(2, 5, 75);
    rect(75, 150, 250, 100);  // the button
    // The button text
    fill(0, 0, 0);
    textSize(30);
    text("GAME OVER", 105, 195);
    textSize(21);
    text("Click screen to restart", 90, 230);
  };
  
void mousePressed() {  //restarts the game
    if (points.lives <= 0) {
      points.lives = 3;
      points.score = 0;
      loop();
    }
  };
  
//character movement
void moveCharacter() {
    //chara. to the right
    if (keyPressed && keyCode == RIGHT && xPosition < 415) { 
      xPosition+= 5;
    }
    //chara. to the left
    if (keyPressed && keyCode == LEFT && xPosition > -15) { 
      xPosition -= 5;
    }
  };

//points, lives left, TESTING
void writingOnScreen() {
    textSize(21);
    fill(194, 58, 58);
    text("Points: " + points.score, 20, 60); //the player's score / number of objects caught
    text("Lives Left: " + points.lives, 20, 90); // number of lives left

    textSize(10);
    text("FOR TESTING: " + objects.size(), 310, 60); //numbers of objects on the screen
  }; 
  
 void drawCharacter() {
  noStroke();

  //body
  fill(179, 162, 199);
  triangle(xPosition -30, 320, xPosition, 205, xPosition + 30, 320);

  //head
  fill(245, 210, 125);
  ellipse(xPosition, 240, 80, 80);
  
  //eyes
  fill(53, 84, 122);
  ellipse(xPosition - 17, eyeY, eyeSize, eyeSize);
  ellipse(xPosition + 17, eyeY, eyeSize, eyeSize);
  
  //hair
  fill(87, 53, 53);
  ellipse(xPosition - 35, hairY, hairSize, hairSize);
  ellipse(xPosition + 35, hairY, hairSize, hairSize);
  arc(xPosition, 233, 82, 72, PI, 2 * PI);
}

class things {
   float x, y;
   String kind;
  
  public things(String kind) {
    x = random(0, 315); 
    y = -10;
    this.kind = kind;
  }
}

class Points {
   int score, lives;
  
  public Points() {
    score = 0;
    lives = 3;
  }
}