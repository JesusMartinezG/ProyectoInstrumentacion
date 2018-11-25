int dato;
int temperatura, luz, humedad;
void setup()

{
Serial.begin(9600); // start serial communication
dato=0;
}

void loop()

{
  switch (dato)
  {
    case 0:
      temperatura = analogRead(A0);
      Serial.print("T");
      Serial.println(temperatura);
      dato++;
      delay(50);
    break;
  
    case 1:
      luz = analogRead(A1);
      Serial.print("L");
      Serial.println(luz);
      dato++;
      delay(50);
    break;
  
    case 2:
      humedad = analogRead(A3);
      Serial.print("H");
      Serial.println(humedad);
      dato++;
      delay(50);
    break;
    
    default:
      dato=0;
    break;
  }
}
