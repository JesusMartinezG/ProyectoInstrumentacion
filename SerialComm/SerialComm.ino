int dato;						//Indica el dato que se enviará en cada ciclo
int temperatura, luz, humedad;  //Variables que guardan el valor recibido desde cada sensor

void setup()

{
Serial.begin(9600); // Inicia la comunicacion con el puerto serie
dato=0;
}

void loop()

{
  //Envía un dato en cada ciclo
  switch (dato)
  {
    case 0:                           //Cuando la variable dato es 0 se envía el valor recibido del sensor de temperatura
      temperatura = analogRead(A0);   //obtiene el valor del convertidor analógico
      Serial.print("T");              //Envía al buffer del puerto serie el caracter 'T' para denotar que se trata del dato leído del sensor de temperatura NTC
      Serial.println(temperatura);    //Envía al buffer del puerto serie el valor previamente leído del convertidor
      dato++;					      //Aumenta el contador para enviar el siguiente dato
      delay(50);                      //Delay para evitar un desborde de datos en el buffer del puerto serial
    break;
  
    case 1:							  //Cuando la variable dato es 1 se envía el valor recibido del detector de luz
      luz = analogRead(A1);			  
      Serial.print("L");			  //Envía al buffer del puerto serie el caracter 'L' para denotar que se trata del dato leído del detector de luz
      Serial.println(luz);
      dato++;
      delay(50);
    break;
  
    case 2:                           //Cuando la variable dato es 2 se envía el valor recibido del sensor de humedad relativa
      humedad = analogRead(A3);
      Serial.print("H");              //Envía al buffer del puerto serie el caracter 'H' para denotar que se trata del dato leído del sensor de humedad
      Serial.println(humedad);
      dato++;
      delay(50);
    break;
    
    default:                          //Cuando la variable dato es mayor que 2
      dato=0;    					  //reinicia el contador para volver a envíar los nuevos datos
    break;
  }
}
