class Player extends Entity
{
   
   private float bulletTimer = 0; 
   
   public Player(Game game)
   {
     this.width = 64;
     this.height = 64;
     
     this.x = game.screenWidth / 2;
     this.y = game.screenHeight - this.height / 2;
     
     image = loadImage("assets/player.png");
   }
   
   public void update(Game game, float dt)
   {
     float speed = game.screenWidth / 2;
     
     //moving/////////////////////////////////////////
     if(input.isKeyDown('a'))
     {
       x -= speed * dt;      
     }
     if(input.isKeyDown('d'))
     {
       x += speed * dt;
     }
     
     if(x < width / 2) x = width / 2;
     if(x > game.screenWidth - width / 2) x = game.screenWidth - width / 2;
     
     //shooting/////////////////////////////////////
     if(input.isKeyDown(' ') && bulletTimer <= 0)
     {
        game.createBullet(x, y); 
        bulletTimer = 0.75f;
     }
     else 
     {
        bulletTimer -= dt; 
     }
   }
}
