class Input
{
  //a map letting us know if a key is being held down
  private HashMap<Character, Boolean> keyState; 
  
  public Input()
  {
    keyState = new HashMap<>();
  }  
  
  public boolean isKeyDown(char pressedChar)
  {
     if(keyState.containsKey(pressedChar))
     {
        return keyState.get(pressedChar);  
     }
     
     return false;
  }
  
  public void keyPressed(char pressed)
  {
    keyState.put(pressed, true);
  }
  
  public void keyReleased(char pressed)
  {
    keyState.put(pressed, false);
  }
}

void keyPressed()
{
  char pressed = Character.toLowerCase(key);
  input.keyPressed(pressed);
}

void keyReleased()
{
  char released = Character.toLowerCase(key);
  input.keyReleased(released);
}
