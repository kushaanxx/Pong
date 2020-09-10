/*


This program creates a pong game which consists of two paddles. Left paddle is controlled by UP and DOWN arrows and
the right paddle is controlled by Mouse buttons. A ball moves throughout the canvas. Whenever the ball is missed by
one paddle, the opponent paddle gets 1 point which is displayed on top of the canvas. The game ends when either of the
paddle reaches 11 points. In the end, the game displays the winner with a GAME OVER note :)


********************************************************************************************************
                 G L O B A L   V A R I A B L E S
********************************************************************************************************
*/

final float MIN_SPEED = 1;     // Minimum speed of the ball
final float MAX_SPEED = 3;     // Maximum speed of the ball
float paddleSize = 3;          // length of paddle. Change the value to change the size of paddle
int   ballDirection = 1;       // the direction of the ball initially set to +ve direction
float ballXspeed = 5;          // speed of the ball in the X - axis
float ballYspeed = 2;          // speed of the ball in the Y - axis
float ballXpos ;               // position of the ball on the X - axis
float ballYpos ;               // position of the ball on the Y - axis
int   ballSize = 20;           // Size of the ball i.e radius
int   keyScore;                // Score of the keyboard
int   mouseScore;              // Score of the mouse
float paddleSpeed = 5;         // Speed of the paddle. Change the value to change the speed of the paddle
float rightPaddle = 400/2;     // Initial position of the right paddle
float leftPaddle = 400/2;      // Initial position of the right paddle
boolean gameOver = false;      // boolean variable that checks whether game ends (true) or not (false)

//********************************************************************************************************

void setup()                   // Setup() function created
{
  size(700, 500);              // size of the canvas set to 700 x 500
  ballXpos = width/2;          // position of the ball on the X - axis initially set to width/2
  ballYpos = height/2;         // position of the ball on the Y - axis initially set to height/2
}

//********************************************************************************************************

void draw()                    // draw function created
{
  drawGame();                  // drawGame() function called
  drawBall();                  // drawBall() function called
  drawPaddles();               // drawPaddles() function called
  drawScore();                 // drawScore() function called
  moveBall();                  // moveBall() function called
  movePaddles();               // movePaddles() function called
  paddleLimit();               // paddleLimit() function called
  ballHit();                   // ballHit() function called
  updateScore();               // updateScore() function called
  checkEnding();               // checkEnding() function called
  endGame();                   // endGame() function called
 whoWon();
}

//********************************************************************************************************

void drawGame()                // drawGame() function created
{
  background(160, 220, 70);    // background set to light green          
}

//********************************************************************************************************

void drawPaddles()                                                                             // drawPaddles() function created
{
  noStroke();                                                                                  // strokeWight set to 0
  fill(0, 0, 255);                                                                             // colour of left paddle set to Blue
  rect(width-width/1.02, leftPaddle, width-width/1.015, paddleSize*(height-height/1.05));      // left paddle created 
  fill(255, 70, 100);                                                                          // colour of right paddle set to reddish - orange
  rect(width-width/30, rightPaddle, width-width/1.015, paddleSize*(height-height/1.05));       // right paddle created
}

//********************************************************************************************************

void drawScore()                                       // drawScore() function created
{
  textSize(20);                                        // Text size set to 20 pixels  
  String toPrint = "Keyboard: " + keyScore;            // string created to be displayed on top for keyboard score
  text(toPrint, width/4-textWidth(toPrint)/2, 50);     // function to display keyboard score on the canvas
  toPrint = "Mouse: " + mouseScore;                    // to be displayed on top for mouse score
  text(toPrint, width*3/4-textWidth(toPrint)/2, 50);   // function to display mouse score on the canvas
}

//********************************************************************************************************

void drawBall()                                        // drawBall() function created
{
  fill(255);                                           // ball colour set to white
  noStroke();                                          // stroke weight of the ball set to 0
  ellipse(ballXpos, ballYpos, ballSize, ballSize);     // ball created
}

//********************************************************************************************************

void moveBall()                                        // moveBall() function created
{
  ballXpos = ballXpos + ballXspeed;                    // changing the speed of the ball in the X - axis
  ballYpos = ballYpos + ballYspeed;                    // changing the speed of the ball in the Y - axis

  if (ballYpos > height-ballSize/2 || ballYpos < 0 + ballSize/2)   // condition to check whether the ball hits the vertical axis limits of canvas height       
  {
    ballYspeed = -ballYspeed;                                      // reversing the speed of ball in the Y - axis
  }                  
}

//********************************************************************************************************

void updateScore()                         // updateScore() function created
{
  if (ballXpos > width - ballSize/2)       // checks whether ball missed paddle and hits the extreme right of the canvas
  {
    ballXpos = width/2;                    // resets the ball X - axis position to width/2
    ballYpos = height/2;                   // resets the ball Y - axis position to height/2
    keyScore++ ;                           // increases the keyScore by 1
  }  

  if ( ballXpos < 0 + ballSize/2)          // checks whether ball missed paddle and hits the extreme left of the canvas
  {
    ballXpos = width/2;                    // resets the ball X - axis position to width/2
    ballYpos = height/2;                   // resets the ball Y - axis position to height/2
    mouseScore++ ;                         // increases the mouseScore by 1
  }
}

//********************************************************************************************************

void movePaddles()                         // movePaddles() function created
{
  if (keyPressed)                          // checks whether key is pressed or not
  {

    if (keyCode == UP)                           // checks whether UP key is pressed or not
    {
      leftPaddle = leftPaddle - paddleSpeed;     // makes the left paddle move upwards  
    }
    if (keyCode == DOWN)                         // checks whether DOWN key is pressed or not
    {
      leftPaddle = leftPaddle+ paddleSpeed;      // makes the left paddle move downwards
    }
  }

  if (mousePressed)                              // checks whether mouse is pressed or not
  {
    if (mouseButton == RIGHT)                    // checks whether right mouse button is pressed
    {  
      rightPaddle = rightPaddle + paddleSpeed;   // makes the right paddle move downwards
    }

    if (mouseButton == LEFT)                     // checks whether left mouse button is pressed
    {
      rightPaddle = rightPaddle - paddleSpeed;   // makes the right paddle move upwards
    }
  }
}

//********************************************************************************************************

void paddleLimit()                               // paddleLimit() function created
{
  if (leftPaddle + paddleSize/2 > 430)           // sets the left paddle bottom limit 
  {
    leftPaddle = leftPaddle - paddleSpeed;       // stops the left paddle when it reaches bottom
  }

  if (leftPaddle - paddleSize/2 <= 0)            // sets the left paddle top limit
  {
    leftPaddle = leftPaddle + paddleSpeed;       // stops the left paddle when it hits top
  }

  if (rightPaddle + paddleSize/2 > 430)          // sets the right paddle bottom limit
  {
    rightPaddle = rightPaddle - paddleSpeed;     // stops the right paddle when it reaches bottom
  }

  if (rightPaddle - paddleSize/2 <= 0)           // sets the right paddle top limit
  {
    rightPaddle = rightPaddle + paddleSpeed;     // stops the right paddle when it hits top
  }
}

//********************************************************************************************************

void ballHit()                                   // ballHit() function created 
{
  
  if (ballXpos >= width-width/30 && ballYpos >= rightPaddle && ballYpos <= rightPaddle + paddleSize*(height-height/1.05))     // checks whether the ball hits the right paddle within its limits or not
  {
    ballXspeed = -1*ballXspeed;                  // reverses the direction of the ball when it hits the right paddle
  }
  
  
  if( ballXpos <= width-(width/1.05) && ballYpos >= leftPaddle && ballYpos <= leftPaddle + paddleSize*(height-height/1.05))   // checks whether the ball hits the left paddle within its limits or not
  {
    ballXspeed = -1*ballXspeed;                  // reverses the direction of the ball when it hits the left paddle
  }  
}

//********************************************************************************************************
  
void checkEnding()                          // checkEnding() function created to check whether the game should end or not
{
  if(keyScore >= 11 || mouseScore >= 11)    // condition which checks whether keyScore or mouseScore reaches 11 points or not 
  {
    gameOver = true;                        // makes the gameOver boolean as true
  }
  
  else
  {
    gameOver = false;                       // makes the gameOver boolean as false
  }
}

//********************************************************************************************************

void endGame()                                                    // endGame() function created
{
  if(gameOver)                                                    // checks whether gameOver boolean is true or not 
  {                                              
  background(0);                                                  // makes the whole background black  
    textSize(30);                                                 // text size set to 30 pixels
    fill(255);                                                    // text colour set to white
    text("G A M E  O V E R", width/3,height/2);                   // displays GAME OVER on the canvas
    textSize(15);                                                 // text size set to 15 pixels
    text("Please restart the game", width/3+30,height/2+25);      // displays 'Please restart the game' on the canvas
  }
}

//********************************************************************************************************

void whoWon()                                                     // whoWon() function created
{
  if(mouseScore >= 11)                                            // checks whether mouse won or not
  {
    textSize(30);                                                 // text size set to 30 pixels
    fill(255, 70, 100);                                           // text colour set to reddish orange
    text("MOUSE WON !!!", width/3,height/3);                    // displays the winner as mouse
  }
  
  if(keyScore >= 11)                                              // checks whether keyboard won or not
  {
    textSize(30);                                                 // text size set to 30 pixels
    fill(0, 0, 255);                                              // text colour set to Blue
    text("KEYBOARD WON !!!", width/3-5,height/3);                 // displays the winner a
  }
}
    
//********************************************************************************************************
  
  
  
