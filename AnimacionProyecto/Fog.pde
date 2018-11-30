class Fog{
  float x;
  float y;
  PImage imagen;
  
  public Fog(PImage img){
    imagen = img;
    x = 800 -imagen.width;
    y = 0;
  }
  
  void desplazar(){
    x++;
    if(x == 0)
      x = 800-imagen.width;
  }
  
  void mostrar(int alfa)
  {
    tint(255,alfa);
    image(imagen,x,y);
  }
}
