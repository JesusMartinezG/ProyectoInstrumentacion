import processing.serial.*;

//Declaración de variables para el manejo de los datos del puerto serial
Serial puerto;
String recibido = null;
int valores[] = new int[3];

//Variables para el manejo de imagenes
PImage sprites[] = new PImage[5];
PImage mov[] = new PImage[4];

//Variables auxiliares para la animación
int pos;
int opac;

//Variables para los datos recibidos desde los sensores
float temperatura, luz, humedad;

//Objetos auxiliares para la animación
Fog niebla;
Persona hombre;


void setup()
{
  //DEFINIR EL TAMANIO DE LA VENTANA
  size(800,600);
  
  //CREAR LA CONEXION CON EL PUERTO SERIE
  puerto = new Serial(this, "COM3", 9600);
  
  //LIMPIAR LA PRIMER CADENA LEIDA DEL PUERTO SERIE PARA EVITAR COMENZAR A LEER DATOS A LA MITAD DE UNA TRAMA
  puerto.clear();
  recibido = puerto.readStringUntil('\n');
  recibido = null;
  
  //CARGAR LAS IMAGENES PARA EL ESCENARIO
  for(int i=0; i<5; i++)
    sprites[i] = loadImage("img"+i+".png");
    
  for(int i=0; i<4; i++)
    mov[i] = loadImage("mov"+i+".png");
  
  //CREAR LOS OBJETOS NECESARIOS PARA LA ANIMACION
  niebla = new Fog(sprites[0]);
  hombre = new Persona(mov);
  PFont fuente = createFont("Bahnschrift",20);
  textFont(fuente);
  textSize(20);
}


void draw()
{
  //OBTENER DATOS DEL PUERTO SERIE
  
  recibido = puerto.readStringUntil('\n');  //Leer el buffer hasta el proximo salto de linea
  
  try{
    if(recibido != null)
    {
        recibido = recibido.replace("\n", "").replace("\r", "").replace(" ","");  //Limpiar caracteres no deseados de la cadena recibida
      
	  
	  switch(recibido.charAt(0)) //Verifica el primer caracter de la cadena recibida, este indica el sensor al que pertenece el dato
      {
        case 'T': //Sensor de temperatura
          valores[0] = Integer.parseInt(recibido.substring(1,recibido.length())); //Convertir la cadena en un entero
          println(valores[0] + " T");
        break;
        
        case 'L'://Detector de luz
          valores[1] = Integer.parseInt(recibido.substring(1,recibido.length()));
          println(valores[1] + " L");
        break;
        
        case 'H'://Sensor de humedad
          valores[2] = Integer.parseInt(recibido.substring(1,recibido.length()));
          println(valores[2]+ " H");
        break;
        
        default:
        recibido = null;
        break;
      }
    }
  }
  catch(NumberFormatException e)
  {
    println("Formato erroneo recibido");
  }
  
  //MAPEO DE LOS VALORES OBTENIDOS DEL PUERTO SERIE PARA LA ANIMACION
  char tono = (char)map(valores[1], 0, 1023, 50, 255);
  char fog = (char)map(valores[2], 0, 1023, 0, 255);
  
  pos = (int)map(valores[1], 0, 1023, 0, 600);
  
  if(pos < 300)
        opac = (int)map(valores[1], 0, 512, 255, 0);
      else
        opac = 0;
        
  //MAPEO DE LOS VALORES DEL PUERTO SERIE PARA LA VISUALIZACION EN TEXTO
  temperatura = map(valores[0],0,1023,0,50);
  luz = map(valores[1],0,1023,0,3000);
  humedad = map(valores[2],0,1023,0,100);
  
  //ANIMACION DE INTENSIDAD LMINOSA
  //FONDO
  //tint(0,0xbf*tono/255,0xff*tono/255);
  tint(tono,tono,tono);
  image(sprites[1],0,0);
  
  //ESTRELLAS
  tint(255, opac);
  image(sprites[2], 0, 0);
  
  //SOL-LUNA
  tint(255,255);
  image(sprites[3],0,-pos);
  
  //ESCENA PRINCIPAL
  tint(tono,tono,tono);
  image(sprites[4],0,0);
  
  
  //ANIMACION DEL VALOR DE TEMPERATURA
  tint(tono,tono,tono);
  hombre.mostrar((int)temperatura);
  
  
  //ANIMACION DEL SENSOR DE HUMEDAD
  //NEBLINA
  niebla.mostrar((int)map(fog, 0, 255, 0, 128));
  niebla.desplazar();
  
  //MOSTRAR LOS VALORES DE LOS SENSORES EN UNIDADES REALES
  text("     Temperatura: "+ String.format ("%.2f", temperatura) + "°C",10,520);
  text("             Luz: "+ String.format ("%.2f", luz) + " lumens",10,550);
  text("Humedad relativa: "+ String.format ("%.2f", humedad) + "%",10,580);
}
