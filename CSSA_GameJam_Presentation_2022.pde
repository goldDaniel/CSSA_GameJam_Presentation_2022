
float previousTime;
Game game;
Input input;


void setup()
{
  size(800,600);
  
  game = new Game(800, 600);
  input = new Input();
  previousTime = millis();
}

void draw()
{  
    //calculate the time between frames in seconds, this way when we 
    //multiply by this value, the units are "per second"
    float currentTime = millis();
    float dt = (currentTime - previousTime) / 1000f;
    previousTime = currentTime;
    
    game.update(dt);
    game.draw();
}
