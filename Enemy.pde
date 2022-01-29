class Enemy extends Entity
{
  public Enemy(float x, float y)
  {
    this.x = x;
    this.y = y;
    
    this.width = 32;
    this.height = 32;
    
    image = loadImage("assets/enemy.png");
  }
  
  public void moveLeft()
  {
     x -= this.width; 
  }
  
  public void moveRight()
  {
     x += this.width; 
  } 
  
  public void moveDown()
  {
     y += this.height; 
  }
  
  public boolean touchedEdge(Game game)
  {
    if(x + this.width / 2 >= game.screenWidth)
    {
       return true; 
    }
    if(x - this.width / 2 <= 0)
    {
       return true; 
    }
    
    return false;
  }
}
