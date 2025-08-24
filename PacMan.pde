int x = 400;             // Initial x-coordinate of PacMan
int y = 115;             // Initial y-coordinate of PacMan
int direction = 1;       // Initial direction of PacMan (1 for right and -1 for left)
int mouthAngle = 45;     // Angle of PacMan's mouth
boolean mouthClosing = true;  // Indicates whether the mouth is closing
int score = 0;           // Player's score
boolean gameover = false; // Game over flag
boolean ghostHarmless = false; // Indicates if the ghost is harmless
int ghostHarmlessTimer = 0; // Timer for how long the ghost remains harmless

int pelletCount = 26;    // Number of pellets
int pelletSpacing;       // Spacing between pellets
int[] pelletsX = new int[pelletCount];  // Array for x-coordinates of pellets
int[] pelletsY = new int[pelletCount];  // Array for y-coordinates of pellets
boolean[] pelletsEaten = new boolean[pelletCount];  // Array to track if pellets are eaten

int ghostX;               // x-coordinate of the ghost
int ghostY = 115;        // Align the ghost's y-coordinate with PacMan's y-coordinate
int ghostDirection = 1;  // Initial direction of the ghost (1 for right and -1 for left)
int speed = 2;          // Speed of both PacMan and the ghost

int fruitX;             // x-coordinate of the fruit
int fruitY = 115;        // Align the fruit's y-coordinate with PacMan's y-coordinate
boolean fruitEaten = false; // Indicates if the fruit is eaten

void setup() {
  size(800, 200); // Set up an 800 by 200 pixel window
  pelletSpacing = width / pelletCount; // Calculate spacing between pellets
  initializePellets(); // Initialize the pellets' positions
  ghostX = int(random(0, width)); // Randomize initial x-coordinate of the ghost
  initializeFruit(); // Initialize the fruit's position
}

void draw() {
  background(0); // Set background to black

  // Draw the track with blue lines
  stroke(0, 0, 255);
  strokeWeight(10); // Thickness of blue line
  line(0, 70, width, 70);   // Upper blue line
  line(0, 160, width, 160); // Lower blue line

  // Display the score
  fill(255);
  textSize(16);
  textAlign(LEFT, TOP);
  text(score, 10, 10);

  if (gameover) {
    textSize(16);
    textAlign(CENTER);
    text("game over", width / 2, 50); // Display "game over" above the top blue line
  }

  // Animate PacMan's mouth if the game is not over
  if (!gameover) {
    if (mouthClosing) {
      mouthAngle -= 2; // Decrease the mouth angle
      if (mouthAngle <= 10) {
        mouthClosing = false; // Start opening the mouth if the angle is less than or equal to 10
      }
    } else {
      mouthAngle += 2; // Increase the mouth angle
      if (mouthAngle >= 45) {
        mouthClosing = true; // Start closing the mouth if the angle is greater than or equal to 45
      }
    }
  }

  // Draw PacMan
  fill(255, 255, 0); // PacMan color yellow
  noStroke(); // No outline
  if (direction == 1) {
    arc(x, y, 25, 25, radians(mouthAngle), radians(360 - mouthAngle), PIE); // PacMan facing right
  } else {
    arc(x, y, 25, 25, radians(180 + mouthAngle), radians(540 - mouthAngle), PIE); // PacMan facing left
  }

  // Update PacMan's position if the game is not over
  if (!gameover) {
    x += direction * speed; // Move PacMan in the current direction
    if (x > width) {
      x = 0; // Wrap around to the left side if PacMan goes off the right edge
    } else if (x < 0) {
      x = width; // Wrap around to the right side if PacMan goes off the left edge
    }
  }

  // Draw pellets
  fill(255);
  for (int i = 0; i < pelletsX.length; i++) {
    if (!pelletsEaten[i]) {
      ellipse(pelletsX[i], pelletsY[i], 5, 5); // Draw a pellet if it hasn't been eaten
    }
  }

  // Check for pellet collision if the game is not over
  if (!gameover) {
    for (int i = 0; i < pelletsX.length; i++) {
      if (!pelletsEaten[i] && dist(x, y, pelletsX[i], pelletsY[i]) < 15) {
        pelletsEaten[i] = true; // Mark the pellet as eaten
        score++; // Increment the score
      }
    }
  }

  // Check if all pellets are eaten and respawn if true
  if (!gameover) {
    boolean allEaten = true;
    for (int i = 0; i < pelletsEaten.length; i++) {
      if (!pelletsEaten[i]) {
        allEaten = false; // If any pellet is not eaten, set allEaten to false
        break;
      }
    }
    if (allEaten) {
      initializePellets(); // Respawn the pellets
    }
  }

  // Draw ghost
  if (ghostHarmless) {
    fill(255); // Ghost color white when harmless
  } else {
    fill(255, 0, 0); // Ghost color red
  }
  rect(ghostX, ghostY - 10, 20, 20); // Adjust ghost's y-coordinate to align with PacMan

  // Update ghost position if the game is not over
  if (!gameover) {
    ghostX += ghostDirection * speed; // Move the ghost in the current direction
    if (ghostX > width) {
      ghostX = 0; // Wrap around to the left side if the ghost goes off the right edge
    } else if (ghostX < 0) {
      ghostX = width; // Wrap around to the right side if the ghost goes off the left edge
    }

    // Randomly change ghost direction
    if (random(1) < 0.01) {
      ghostDirection *= -1; // Reverse direction with a small probability
    }
  }

  // Check for ghost collision
  if (dist(x, y, ghostX, ghostY) < 25) {
    if (!ghostHarmless) {
      gameover = true; // End the game if PacMan collides with the ghost and the ghost is not harmless
    }
  }

  // Draw fruit
  if (!fruitEaten) {
    fill(255, 165, 0); // Fruit color orange
    ellipse(fruitX, fruitY, 10, 10); // Draw the fruit if it hasn't been eaten
  }

  // Check for fruit collision if the game is not over
  if (!fruitEaten && !gameover && dist(x, y, fruitX, fruitY) < 20) {
    fruitEaten = true; // Mark the fruit as eaten
    ghostHarmless = true; // Make the ghost harmless
    ghostHarmlessTimer = 180; // Set timer for 3 seconds 
    initializeFruit(); // Respawn the fruit
  }

  // Handle ghost harmless timer if the game is not over
  if (!gameover && ghostHarmless) {
    ghostHarmlessTimer--; // Decrement the timer
    if (ghostHarmlessTimer <= 0) {
      ghostHarmless = false; // Make the ghost harmful again if the timer runs out
    }
  }
}

void keyPressed() {
  if (key == ' ' && !gameover) {
    direction *= -1; // Reverse PacMan's direction when the spacebar is pressed and the game is not over
  }
}

void initializePellets() {
  int startX = (width - (pelletCount - 1) * pelletSpacing) / 2; // Center the pellets horizontally
  for (int i = 0; i < pelletsX.length; i++) {
    pelletsX[i] = startX + i * pelletSpacing; // Set x-coordinate for each pellet
    pelletsY[i] = 115; // Set y-coordinate for each pellet
    pelletsEaten[i] = false; // Mark each pellet as not eaten
  }
}

void initializeFruit() {
  fruitX = int(random(0, width)); // Randomize initial x-coordinate of the fruit
  fruitEaten = false; // Mark the fruit as not eaten
}
