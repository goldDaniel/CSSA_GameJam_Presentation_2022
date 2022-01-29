abstract class Entity
{
  float x;
  float y;
  float width;
  float height;
  PImage image;
  
  boolean isAlive = true;
  
  public boolean isColliding(Entity other)
  {
      Entity entity = this;
      //we only want to check for collisions if both entities are alive
      if(entity.isAlive && other.isAlive)
      {
        boolean collidingX = false;
        boolean collidingY = false;
        
        float minX = entity.x - entity.width / 2;
        float maxX = entity.x + entity.width / 2;
       
        float minY = entity.y - entity.height / 2;
        float maxY = entity.y + entity.height / 2;
        
        float otherMinX = other.x - other.width / 2;
        float otherMaxX = other.x + other.width / 2;
        
        float otherMinY = other.y - other.height / 2;
        float otherMaxY = other.y + other.height / 2;
        
        //check collisions along the X-axis
        if((minX > otherMinX && minX < otherMaxX) ||
           (maxX > otherMinX && maxX < otherMaxX) || 
           (otherMinX > minX && otherMinX < maxX) || 
           (otherMaxX > minX && otherMaxX < maxX))
        {
           collidingX = true; 
        }
        
        //check collisions along the Y-axis
        if((minY > otherMinY && minY < otherMaxY) ||
           (maxY > otherMinY && maxY < otherMaxY) ||
           (otherMinY > minY && otherMinY < maxY) || 
           (otherMaxY > minY && otherMaxY < maxY))
        {
           collidingY = true; 
        }
        
        //if we are colliding on both axes
        return collidingX && collidingY;
      }
      
      return false;
  }
  
  void draw()
  {
    image(image, x - width / 2, y - height / 2, width, height);
  }
}
