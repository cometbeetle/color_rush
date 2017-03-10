//Ethan Mentzer/cometbeetle
//Assignment 8
//Color Rush

PrintWriter output;
BufferedReader reader;
PFont font;
int size = 40;
int highScore = 0;
int ballx = 400;
int bally = 1;
int score = 0;
int lifePoints = 0;
color ballColor, topColor, rightColor, leftColor, bottomColor;
color red = color(255, 0, 0); //Sets the color variables 
color blue = color(0, 0, 255);
color green = color(0, 255, 0);
color yellow = color(255, 255, 0);
String line;

void setup() {
  reader = createReader("scores.txt");
  size(800, 800);
  background(255); //Background color is white
  frameRate(60);
  topColor = blue;
  rightColor = yellow;
  bottomColor = red;
  leftColor = green;
  smooth();
  try {
    line = reader.readLine();
  } 
  catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  highScore = int(line);
  setBallColor();
}

void draw() {
  background(255);
  fill(topColor);
  triangle(300, 500, 400, 600, 500, 500); // TOP TRIANGLE
  fill(rightColor);
  triangle(500, 500, 400, 600, 500, 700); // RIGHT TRIANGLE
  fill(bottomColor);
  triangle(400, 600, 300, 700, 500, 700); //BOTTOM TRIANGLE
  fill(leftColor); 
  triangle(300, 500, 400, 600, 300, 700); // LEFT TRIANGLE
  bally =(bally+6);

  fill(ballColor);
  ellipse(ballx, bally, size, size);

  fill(0);
  textSize(30);
  text("Score-"+score, 100, 70);
  text("LifeScore-"+lifePoints, 250, 70);
  text("HighScore-"+highScore, 450, 70);

  if (bally > 500) {
    if (ballColor == topColor) {
      score = score + 1;
      lifePoints = lifePoints + 1;
      if (score > highScore) {
        highScore = highScore + 1; // THIS is where high score changes
        println("Writing to file! :)");
        score = highScore;
        output = createWriter("scores.txt");
        output.println(highScore);
        output.flush();
        output.close();
      }
    } else score=0;

    bally = 1;
    setBallColor( );
  }
}


void setBallColor( ) {
  int tempColor2 = (int)random(0, 4);
  if (tempColor2 == 0) { 
    ballColor = red;
  } else if (tempColor2 == 1) {
    ballColor = blue;
  } else if (tempColor2 == 2) {
    ballColor = green;
  } else if (tempColor2 == 3) {
    ballColor = yellow;
  }
} 

void mousePressed() {
  color tempColor;
  tempColor = topColor;
  topColor = leftColor;
  leftColor = bottomColor;
  bottomColor = rightColor;
  rightColor = tempColor;
}

void keyPressed() {
  if (key == BACKSPACE) {
  println("Deleting Highscore.");
  output = createWriter("scores.txt");
        output.println(0);
        output.flush();
        output.close();
  }
}