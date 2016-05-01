const int buttonPin = 2;
boolean mode = HIGH;
int i = 0, dx = 10;

void setup() {
  // initialize the serial communication:
  Serial.begin(19200);
  pinMode(10, INPUT); // Setup for leads off detection LO +
  pinMode(11, INPUT); // Setup for leads off detection LO -
  digitalWrite(buttonPin, HIGH);
}

void loop() {
  if (digitalRead(buttonPin)==LOW) {
    delay(500);
    if (digitalRead(buttonPin)==LOW)
      mode = !mode;
  }
  Serial.print(analogRead(A2));
  Serial.print(',');
  if (mode) {
    if((digitalRead(10) == 1)||(digitalRead(11) == 1)){      
      Serial.println('!');
    } else {
      Serial.println(analogRead(A0));
    }
  } else {  
    i += dx;
    Serial.println(i);
    if (i >= 1024 || i <= 0)
      dx = -dx;
  }
  delay(40);
}

