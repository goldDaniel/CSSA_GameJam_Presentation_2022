class Game
{
  public final int screenWidth;
  public final int screenHeight;
  
  private Player player;
  
  private ArrayList<Bullet> bullets;
  private ArrayList<Enemy> enemies;
    
  private int startingEnemyCount;
  private boolean moveEnemiesLeft;
  private float enemyMoveRate;
  private float enemyMoveTimer;
  
  private int score = 0;
  private boolean isGameOver = false;
  private String gameOverText = "";
    
  private PImage backgroundImage;
    
  public Game(int screenWidth, int screenHeight)
  {
     this.screenWidth = screenWidth;
     this.screenHeight = screenHeight;
     
     
     backgroundImage = loadImage("assets/background.png");
     backgroundImage.resize(screenWidth, screenHeight);
     
     resetGame();
  }
  
  private void resetGame()
  {
    isGameOver = false;
    gameOverText = "";
    score = 0;
    
    player = new Player(this);
    bullets = new ArrayList<Bullet>();
    enemies = new ArrayList<Enemy>();
     
    createEnemies(6,4);
    enemyMoveTimer = calculateEnemyMoveRate();
    moveEnemiesLeft = false;
  }
  
  private void createEnemies(int columns, int rows)
  {
    startingEnemyCount = columns * rows;
    
    float spacing = 64;
    float enemyGroupWidth = (columns - 1) * spacing;
    
    float startX = screenWidth / 2 - enemyGroupWidth / 2;
    float startY = spacing;
    
    for(int x = 0; x < columns; x++)
    {
     for(int y = 0; y < rows; y++)
     {
        float posX = startX + (x * spacing);
        float posY = startY + (y * spacing);
        
        Enemy enemy = new Enemy(posX, posY);
        enemies.add(enemy);
     } 
    }
  }
  
  //do all the game logic here
  public void update(float dt)
  {
    if(!isGameOver)
    {
      player.update(this, dt);
      updateBullets(dt);    
      updateEnemies(dt);  
      
      if(enemies.size() == 0)
      {
         winGame(); 
      }
    }
    else
    {
      if(input.isKeyDown('r'))
      {
         resetGame(); 
      }
    }
  }
  
  private void updateBullets(float dt)
  {
    ArrayList<Bullet> toRemove = new ArrayList<>();
    for(Bullet bullet : bullets)
    {
      bullet.update(this, dt);
      if(!bullet.isAlive)
      {
        toRemove.add(bullet);
      }
    }
    bullets.removeAll(toRemove);
  }
  
  private void updateEnemies(float dt)
  {
    enemyMoveRate = calculateEnemyMoveRate();
    moveEnemies(dt);
    checkEnemyCollisions();
  }
  
  private float calculateEnemyMoveRate()
  {
    float percentageEnemiesAlive = (float)enemies.size() / startingEnemyCount;
    
    return lerp(0.05f, 1f, percentageEnemiesAlive);
  }
  
  private void moveEnemies(float dt)
  {
    enemyMoveTimer -= dt;
    boolean moveDown = false;
    if(enemyMoveTimer <= 0)
    {
      enemyMoveTimer = enemyMoveRate;
      
      for(Enemy enemy : enemies)
      {
        if(moveEnemiesLeft)
        {
           enemy.moveLeft(); 
        }
        else
        {
           enemy.moveRight(); 
        }
        
        if(enemy.touchedEdge(this))
        {
            moveDown = true;
        }
      }
      
      if(moveDown)
      {
         moveEnemiesLeft = !moveEnemiesLeft; 
         for(Enemy enemy : enemies)
         {
            enemy.moveDown(); 
         }
      }
    }
  }
  
  private void checkEnemyCollisions()
  {
    ArrayList<Enemy> deadEnemies = new ArrayList<>();
    for(Enemy enemy : enemies)
    {
      if(enemy.isColliding(player))
      {
         loseGame(); 
      }
      
      for(Bullet bullet : bullets)
      {
        if(enemy.isColliding(bullet))
        {
          bullet.isAlive = false;
          deadEnemies.add(enemy);
          
          score += 150;
        }
      }
    }
    enemies.removeAll(deadEnemies);
  }
  
  //do all the game drawing here
  public void draw()
  {
    //clears the screen to black
    image(backgroundImage, 0, 0);
    

    for(Enemy enemy : enemies)
    {
       enemy.draw(); 
    }
    for(Bullet bullet : bullets)
    {
       bullet.draw(); 
    }
    
    player.draw();
    
    if(isGameOver)
    {
      textAlign(CENTER, CENTER);
      textSize(64);
      text(gameOverText, screenWidth / 2, screenHeight / 2);
      
      textSize(32);
      text("Final Score: " + score, screenWidth / 2, screenHeight / 2 - 128); 
      
      
      text("Press the \"R\" key to restart", screenWidth / 2, screenHeight / 2 + 128);
    }
    else 
    {
       textAlign(LEFT, TOP);
       textSize(32);
       text("Score: " + score, 0, 0);
    }
  }
  
  public void createBullet(float x, float y)
  {
     Bullet bullet = new Bullet(this, x, y);
     bullets.add(bullet);
  }
  
  public void loseGame()
  {
    isGameOver = true;
    gameOverText = "You Lose!";
  }
  
  public void winGame()
  {
     isGameOver = true;
     gameOverText = "You Win!";
  }
}
