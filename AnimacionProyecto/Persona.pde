class Persona{
  int posX;
  int shake;
  int temp;
  PImage[] sprites;
  boolean flag;
  
  public Persona(PImage[] imagenes)
  {
    sprites = imagenes;
    shake = 3;
    temp = 0;
    posX = 0;
  }
  
  void mostrar(int temp){
    if(temp < 15)
    {
      image(sprites[0], posX, 0);
      if(flag)
        posX = posX + shake;
      else
        posX = posX - shake;
        
      flag = !flag;
    }
    else if (temp < 20)
    {
      image(sprites[1], 0,0);
    }
    else if (temp < 35)
    {
      image(sprites[2], 0,0);
    }
    else
    {
      image(sprites[3], 0, 0);
    }
  }
}
