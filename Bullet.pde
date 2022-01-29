class Bullet extends Entity
{  //<>//
  float speed;
  
  public Bullet(Game game, float x, float y)
  {
    this.x = x;
    this.y = y;
    
    this.width = 8;
    this.height = 64;
    
    speed = game.screenHeight;
    
    image = loadImage("assets/laser.png");
  }
  
  public void update(Game game, float dt)
  {
     y -= speed * dt;
     
     if(y < -this.height)
     {
       isAlive = false;
     }
  }
}
