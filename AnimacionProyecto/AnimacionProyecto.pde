import processing.serial.*;

Serial puerto;
PImage sprites[] = new PImage[4];
String recibido = null;
int valores[] = new int[3];

void setup()
{
  size(800,480);
  
  valores[0]=0;
  valores[1]=0;
  valores[2]=0;
  
  puerto = new Serial(this, "COM3", 9600);
  
  puerto.clear();
  recibido = puerto.readStringUntil('\n');
  recibido = null;
}

void draw()
{
  recibido = puerto.readStringUntil('\n');
  
  if(recibido != null)
  {
      recibido = recibido.replace("\n", "").replace("\r", "").replace(" ","");
    switch(recibido.charAt(0))
    {
      case 'T':
        valores[0] = Integer.parseInt(recibido.substring(1,recibido.length()));
        println(valores[0] + " T");
      break;
      
      case 'L':
        valores[1] = Integer.parseInt(recibido.substring(1,recibido.length()));
        println(valores[1] + " L");
      break;
      
      case 'H':
        valores[2] = Integer.parseInt(recibido.substring(1,recibido.length()));
        println(valores[2]+ " H");
      break;
      
      default:
      recibido = null;
      break;
    }
  }
  background(valores[0],valores[1],valores[2]);
}
