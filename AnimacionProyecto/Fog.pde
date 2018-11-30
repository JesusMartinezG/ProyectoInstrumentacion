//Clase Fog para la animación de la neblina que representa al sensor de humedad

class Fog{
  float x;
  float y;
  PImage imagen;
  
  public Fog(PImage img)  //constructor
  {
    imagen = img;
    x = 800 -imagen.width;
    y = 0;
  }
  
  void desplazar(){       //Realiza el movimiento de animación
    x++;
    if(x == 0)
      x = 800-imagen.width;
  }
  
  void mostrar(int alfa)  //Controla la opacidad de la imagen
  {
    tint(255,alfa);
    image(imagen,x,y);
  }
}
