#define _XTAL_FREQ 16000000
//define ACELEROMETRO
#define MPU6050_ADDRESS 0xD0
#define MPU6050_RA_SMPLRT_DIV 0x19
#define MPU6050_RA_PWR_MGMT_1 0x6B
#define MPU6050_RA_CONFIG 0x1A
#define MPU6050_RA_ACCEL_CONFIG 0x1C
#define MPU6050_RA_GYRO_CONFIG 0x1B
#define MPU6050_RA_ACCEL_XOUT_H 0x3B
#define MPU6050_RA_WHO_AM_I 0x75
///define Deteccion colision y caida
#define DATA_LENGTH 60
#define THRESHOLD 40.0 // Ajustar threshold segun pico en acelerometro base 45
#define WINDOW_SIZE 10
#define GRAVITY 9.81
#define DEGREE 131.0 // El valor 131 es específico del rango ±250 deg/s del MPU6050.
#define ALPHA 0.2 // Factor de suavizado (ajusta según sea necesario)
#define RESOLUTION 16384.0
//define detecci?n caida lateral
#define ANGULAR_VELOCITY_THRESHOLD 500.0  //al ser el pico por eje de 250 al menos la magnitud sea 2 veces ese valor
#define ANGULAR_VELOCITY_DURATION_THRESHOLD 5  // en milisegundos
///define guardado de datos
#define MAX_SAMPLES 20

//PORT A
sbit pinBat at RA0_bit;
sbit pinAlcSen at RA1_bit;
sbit pinLed0BT at RA2_bit;
sbit pinShutdown at RA3_bit;
sbit pinLedIndicator at RA4_bit;
sbit pinBT0 at RA5_bit;
sbit pinBT4 at RA6_bit;
sbit pinBT5 at RA7_bit;
//PORT B
sbit pinButton at RB0_bit;
sbit pinTemp at RB1_bit;
sbit pinAlcCtrl at RB2_bit;
sbit pinBT7 at RB3_bit;
sbit pinBTRst at RB4_bit;
sbit pinBT6 at RB5_bit;
//PORT C
sbit pinBT3 at RC0_bit;
sbit pinBT2 at RC1_bit;
sbit pinBT1 at RC2_bit;
sbit pinSCL at RC3_bit;
sbit pinSDA at RC4_bit;
sbit pinBT9 at RC5_bit;
sbit pinTX at RC6_bit;
sbit pinRX at RC7_bit;

//ACELERÓMETRO - MPU6050
int veces = 0;
int v = 0;
float magCol = 0.00;
int tempMicro = 0;
///variables en bruto
signed long int rawAcc[3] = {0,0,0};
signed long int rawGyr[3] = {0,0,0};
/// Variables para calibracion
signed long int accelOffsets[3] = {0,0,0};
signed long int gyrOffsets[3] = {0,0,0};
///Variables de filtrado
signed long int calibrateAcc[3] = {0,0,0};
signed long int calibrateGyro[3] = {0,0,0};
float accelMS2[3] = {0.0,0.0,0.0};
float gyroDegS[3] = {0.0,0.0,0.0};
float gravityDirection[3] = {0.0,0.0,0.0};
signed long int filteredData[3] = {0,0,0};
signed long int filteredGyro[3] = {0,0,0};
//variables deteccion
long timeStamp = 0;
//Vector almacenamiento
short int sampleIndex = 0;
float samplesAccX[MAX_SAMPLES];
float samplesAccY[MAX_SAMPLES];
float samplesAccZ[MAX_SAMPLES];
float samplesGyrX[MAX_SAMPLES];
float samplesGyrY[MAX_SAMPLES];
float samplesGyrZ[MAX_SAMPLES];

//TIMMER
unsigned int millis = 0;
unsigned int millisFiveMS =0;
char seconds[2];

//ON/OFF & Bateria
short int isOn = 0;
short int isPress = 0;
int timePress = 0;
short int firstTime = 0;
int timesBateryReads = 0;
float batteryPorc = 0.00;

//TEMPERATURA  DS18B20: 12 - 0xFE
const unsigned short TEMP_RESOLUTION = 0xFE;

//ALCOHOL - TGS2620
#define MAX_ALC_TEMP 70
int secondsHeat = 0;
int secondsRest = 0;
int secondsReading = 0;
int auxSecRead =0;
int secondsAux = 0;
int secondsRestAux = 0;
short int isRest = 0;
int tempAlc = 0;
float mglALcohol = 0.00;
short int gradeAlc = 0;

//BLUETOOTH - BTM0608C2X
short int isUntilZero = 0;
const char INIT = '$';
const char END = '#';
const char TEMP = '1';
const char STATE = '2';
const char VALUE = '3';
const char FLAG = '4';
const char SEG = '5';
const char REPORT = '6';
const char ERROR = '7';
const char ALC = 'A';
const char ACCEL = 'B';
const char BAT = 'B';
const char FALL = 'B';
const char TEMPTALC = 'B';
const char COL = 'C';
const char LOW_BAT = 'C';
const char CONSOLA = 'C';
const char ON = '1';
const char OFF = '0';
int timeToSend =0;
short int isPickUp = 0;

void ResetVars(){
  //ALCOHOL - TGS2620
  secondsHeat = 0;
  secondsRest = 0;
  secondsReading = 0;
  auxSecRead =0;
  secondsAux = 0;
  secondsRestAux = 0;
  isRest = 0;
  tempAlc = 0;
  mglALcohol = 0.00;
  gradeAlc = 0;
  //ON/OFF & Bateria
  isPress = 0;
  timePress = 0;
  timesBateryReads = 0;
  batteryPorc = 0.00;

  millis = 0;
  millisFiveMS =0;

  timeToSend =0;
  //ACELERÓMETRO - MPU6050
 veces = 0;
  v = 0;
  magCol = 0.00;
  tempMicro = 0;
  /*timeStamp = 0;
  for(v = 0; v < 3; v++){
    ///variables en bruto
    rawAcc[v] = 0;
    rawGyr[v] = 0;
    /// Variables para calibracion
    accelOffsets[v] = 0;
    gyrOffsets[v] = 0;
    ///Variables de filtrado
    calibrateAcc[v] = 0;
    calibrateGyro[v] = 0;
    accelMS2[v] = 0.0;
    gyroDegS[v] = 0.0;
    gravityDirection[v] = 0.0;
    filteredData[v] = 0;
    filteredGyro[v] = 0;
  }*/



}
//BLUETOOTH - FUNCTIONS
void UART_Send_String(char *dat) {
    //while (*dat != '\0') {
    while (*dat != '#') {
      while(!UART1_Tx_Idle());
      UART1_Write(*dat);
        dat++;
    }
    while(!UART1_Tx_Idle());
    UART1_Write(END);
    delay_ms(5);
}
void SprintInt(int i){
    char text[12];
    IntToStr(i,text);
    UART1_Write_text(text);
    UART1_Write_text(" ");
}
void SprintFloat(float f){
    char text[12];
    //FloatToStr(f,text);
    sprintf(text,"%.4f",f);
    UART1_Write_text(text);
    UART1_Write_text(" ");
}
void SprintLn(){
    UART1_Write('\n');
}
void SprintMsg(char *text){
   UART1_Write_text(text);
}
void SprintMsgLn(char *text){
   UART1_Write_text(text);
   UART1_Write('\n');
}
void ShowData(char *title, float value){
   SprintMsg(title);
   SprintFloat(value);
   SprintLn();
}
void StreamFixed(char function, char sensor, char state){
    char stream[12] = "";
    stream[0] = INIT;
    stream[1] = function;
    stream[2] =  sensor;
    stream[3] =  state;
    stream[4] = END;
    UART_Send_String(stream);
    //UART1_Write_Text(stream);
}
void StreamFunction(char function, char sensor, float value){
    char text[5];
    char stream[20] = "";
    int caracter = 0;
    int charac = 3;
    stream[0] = INIT;
    stream[1] = function;
    stream[2] =  sensor;
    sprintf(text,"%.1f",value);
    for(caracter = 0; caracter < strlen(text); caracter++){
        if(text[caracter]!= '.') {
          stream[charac] = text[caracter];
          charac++;
        }
    }
    stream[charac] = END;
    UART_Send_String(stream);
    //UART1_Write_Text(stream);
}
void StreamAccel(char function, char event, float magnitude, float vecAxis[3]){
    char text[20] = "";
    char stream[100] = "";
    int caracter = 0;
    int ind = 0;
    int charac = 0;
    stream[charac] = INIT;
    charac++;
    stream[charac] = INIT;
    charac++;
    stream[charac] = function;
    charac++;
    stream[charac] =  event;
    charac++;
    for(ind = 0; ind < 3 ; ind++){
       text[20] = "";
       sprintf(text,"%.1f",vecAxis[ind]);
       delay_ms(5);
       for(caracter = 0; caracter < strlen(text); caracter++){
         if(text[caracter]!= '.') {

           stream[charac] = text[caracter];
             charac++;
         }
       }
       stream[charac] = ';';
       charac++;
    }
    sprintf(text,"%.1f",magnitude);
    delay_ms(5);
    for(caracter = 0; caracter < strlen(text); caracter++){
      if(text[caracter]!= '.') {
        stream[charac] = text[caracter];
        charac++;
      }
    }
    stream[charac] = END;
    UART_Send_String(stream);
   // UART1_Write_Text(stream);
}
void StreamAlcohol(char function, int grade, float cienMgsMl){
    char text[12];
    char grad[1];
    char stream[100] = "";
    int caracter = 0;
    int charac = 5;
    stream[0] = INIT;
    stream[1] = function;
    stream[2] =  ALC;
    sprintf(grad,"%d",grade);
    stream[3] = grad[0];
    stream[4] = ',';
    sprintf(text,"%.1f",cienMgsMl);
    delay_ms(5);
    for(caracter = 0; caracter < strlen(text); caracter++){
        if(text[caracter]!= '.') {
          stream[charac] = text[caracter];
          charac++;
        }
    }
    stream[charac] = END;
    UART_Send_String(stream);
    //UART1_Write_Text(stream);
}
//SENSOR TEMP - DS18B20
int GetTemp(){
    int tempe = 0;
    //--- Perform temperature reading
      Ow_Reset(&PORTB, 1);                        // Onewire reset signal
      Ow_Write(&PORTB, 1, 0xCC);                   // Issue command SKIP_ROM
      Ow_Write(&PORTB, 1, 0x44);                   // Issue command CONVERT_T
      delay_ms(20);
      //while (Ow_Read(&PORTB, 1) == 0);

      Ow_Reset(&PORTB, 1);
      Ow_Write(&PORTB, 1, 0xCC);                   // Issue command SKIP_ROM
      Ow_Write(&PORTB, 1, 0xBE);                   // Issue command READ_SCRATCHPAD

      tempe =  Ow_Read(&PORTB, 1);
      tempe &= TEMP_RESOLUTION;
      tempe = (Ow_Read(&PORTB, 1) << 8) + tempe;
      tempe = tempe/16;
    //return temp-32;
    return tempe;
}
//ADC - BATERY & ALCOHOL SENSOR - TGS2620
float ReadADC(int channel){
    float reference = 0.00;
    float avarage = 0;
    float batReference = 3.28;
    int bitsReadADC = 1024;

    /* PROMEDIO DE LECTURA PARA REDUCIR EL ERROR POR LOS BITS MENOS SIGNIFICATIVOS*/
    for(timesBateryReads = 0; timesBateryReads < 10 ; timesBateryReads++)
    {
        avarage += ((ADC_READ(channel) * batReference) / bitsReadADC);
    }
    return avarage/10;
}
float GetBatteryPorcent(){
   float porcBattery = 0.00;
   const float porcMax = 100.00;
   const float porcMin = 1.00;
   const float voltMin = 1.6;
   const float voltMax = 2.145;
   float rawBattery = ReadADC(0);
   //ShowData("Raw Battery: ", rawBattery);
   if(rawBattery*2 > 4.2){
      rawBattery -= rawBattery*0.16;
   }
   porcBattery = porcMin + (rawBattery-voltMin)*((porcMax - porcMin)/(voltMax - voltMin));
   return porcBattery;
}
void SendBattery(){
   ///Lectura de estado de bateria
   batteryPorc = GetBatteryPorcent();
   StreamFunction(STATE, BAT, batteryPorc);
   if(batteryPorc < 29)
      StreamFixed(SEG, LOW_BAT, ON);
}
short int ReadingAlcohol(){
    /*
     * Grados de Alcohol
    Grado 0
      20-39 mg/100mL
      200 - 390 ppm o mg/L
    Grado 1
      40-99mg/100mL
      400 - 990 ppm o mg/L
    Grado 2
      100-149 mg/100ml
      1000 - 1490 ppm o mg/L
    Grado 3
      >150 mg/100mL
      > 1500 ppm o mg/L
     */
     short int gradeAlcohol = 0;
     float maxmG = 1500.00; //maximo ppm del sensor ppm -> mg/L -> 50 mg/100mL
     float minmG = 50.00;
     float minVolt=0.8;
     float maxVolt = 2.50;
     float rawAlcohol = ReadADC(1);
     //Showdata("raw: ", rawAlcohol);
     mglAlcohol = minmG + (((rawAlcohol-minVolt)/(maxVolt-minVolt))*(maxmG-minmG));
     mglAlcohol -= 200.0;
     //ShowData("mg/L: ", mglAlcohol);
     //eventos
     if(mglAlcohol <=390.0 ) //400 ppm pasa al grado 1 de alcohol por lo que se envia la notificacion
     {
        if(mglAlcohol < 0) mglAlcohol = 0.00;
        gradeAlcohol = 0;
     }
     else if(mglAlcohol >= 400.0 && mglAlcohol<= 990.0) //40 mG/100mL pasa al grado 1 de alcohol por lo que se envia la notificacion
     {
        gradeAlcohol = 1;
     }
     else if(mglAlcohol >= 1000.0 && mglAlcohol<= 1490.0) //400 ppm pasa al grado 1 de alcohol por lo que se envia la notificacion
     {
        gradeAlcohol = 2;
     }
     else if(mglAlcohol >= 1500.0) //400 ppm pasa al grado 1 de alcohol por lo que se envia la notificacion
     {
        gradeAlcohol = 3;
     }

     return gradeAlcohol;
}
//ACELEROMETRO - MPU6050
void MPU6050_Init()
{
  I2C1_Init(400000);
  Delay_ms(100);
  // Setting The Sample (Data) Rate
  I2C1_Start();
  I2C1_Wr(MPU6050_ADDRESS);
  I2C1_Wr(MPU6050_RA_SMPLRT_DIV);
  I2C1_Wr(0x07);
  I2C1_Stop();
  // Setting The Clock Source
  I2C1_Start();
  I2C1_Wr(MPU6050_ADDRESS);
  I2C1_Wr(MPU6050_RA_PWR_MGMT_1);
  I2C1_Wr(0x02);
  //I2C1_Wr(0x00);
  I2C1_Stop();
  // Configure the DLPF
  I2C1_Start();
  I2C1_Wr(MPU6050_ADDRESS);
  I2C1_Wr(MPU6050_RA_CONFIG);
  I2C1_Wr(0x00);
  I2C1_Stop();
  // Configure the ACCELL (FSR=+-16g)
  I2C1_Start();
  I2C1_Wr(MPU6050_ADDRESS);
  I2C1_Wr(MPU6050_RA_ACCEL_CONFIG);
  I2C1_Wr(0x18); //accel_config +-16g
  I2C1_Stop();
  //Configure the GYRO (FSR = -250d/s)
  I2C1_Start();
  I2C1_Wr(MPU6050_ADDRESS);
  I2C1_Wr(MPU6050_RA_GYRO_CONFIG);
  //I2C1_Wr(0x18); //gyro_config, +-2000 ?/s
  I2C1_Wr(0x00); //gyro_config, +-250 ?/s
  I2C1_Stop();
}
void MPU6050_Read(){
  I2C1_Start();
  I2C1_Wr( MPU6050_ADDRESS );
  I2C1_Wr( MPU6050_RA_ACCEL_XOUT_H );
  I2C1_Stop();
  I2C1_Start();
  I2C1_Wr(MPU6050_ADDRESS | 1);
  rawAcc[0]   = (I2C1_Rd(1) << 8) | I2C1_Rd(1);
  rawAcc[1]   = (I2C1_Rd(1) << 8) | I2C1_Rd(1);
  rawAcc[2]   = (I2C1_Rd(1) << 8) | I2C1_Rd(1);
  tempMicro = (I2C1_Rd(1) << 8) | I2C1_Rd(1);
  rawGyr[0]   = (I2C1_Rd(1) << 8) | I2C1_Rd(1);
  rawGyr[1]   = (I2C1_Rd(1) << 8) | I2C1_Rd(1);
  rawGyr[2]   = (I2C1_Rd(1) << 8) | I2C1_Rd(0);
  I2C1_Stop();
  tempMicro += 12421;
  tempMicro /= 340;
}
// Función para filtrar los datos
void LowPassFilter(signed long int rawData[3], signed long int rawGyro[3]) {
    short int axis = 0; //variable for recorre los ejes
    for (axis = 0; axis < 3; axis++) {
       filteredData[axis] = ALPHA * rawData[axis] + (1 - ALPHA) * filteredData[axis];
       filteredGyro[axis] = ALPHA * rawGyro[axis] + (1 - ALPHA) * filteredGyro[axis];
    }
}
void CalibrateMPU6050(int samples) {
    int sample = 0;
    short int axis = 0; //variable for recorre los ejes
    //SprintMsgLn("Calibrando MPU...");
      for (sample = 0; sample < samples; sample++) {

       MPU6050_Read();
       pinLedIndicator = 1;
       //SprintMsg("Raw X: "); SprintInt(rawAcc[0]);  SprintLn();
       //SprintMsg("Raw Y: "); SprintInt(rawAcc[1]); SprintLn();
       //SprintMsg("Raw Z: "); SprintInt(rawAcc[2]); SprintLn();SprintLn();
        LowPassFilter(rawAcc, rawGyr);
        delay_ms(10); // Puedes ajustar el retraso seg?n sea necesario
    }

     for (sample = 0; sample < samples; sample++) {
        for (axis = 0; axis < 3; axis++) {
            accelOffsets[axis] += filteredData[axis];
            gyrOffsets[axis] += filteredGyro[axis];
        }
        delay_ms(10); // Puedes ajustar el retraso seg?n sea necesario
    }
    for (axis = 0; axis < 3; axis++) {
        accelOffsets[axis] /= samples;
        gyrOffsets[axis] /= samples;
    }
    SprintMsgLn("Sensor Calibrado!");
    SprintMsgLn("Offsets:");
    SprintMsg("Offset X: "); SprintInt(accelOffsets[0]);  SprintLn();
    SprintMsg("Offset Y: "); SprintInt(accelOffsets[1]); SprintLn();
    SprintMsg("Offset Z: "); SprintInt(accelOffsets[2]); SprintLn();
    ShowData("Temperatura Micro: ", tempMicro);
    //accelOffsets[1] /= 100; // se repite porque hay error en micro y no hace el procedimiento la primera vez
}
void MPU6050_ReadFilter(unsigned int samples){
     int sample =0;
     short int axis = 0; //variable for recorre los ejes
     short int ax = 0;
     //Valores con filtro pasa bajos
    for(sample = 0; sample < samples; sample++){
       MPU6050_Read();
       LowPassFilter(rawAcc, rawGyr);
     }
     //Valores filtrados con offsets
     for(ax =0; ax < 3; ax++){
        calibrateAcc[ax] = filteredData[ax] - accelOffsets[ax];
        calibrateGyro[ax] = filteredGyro[ax] - gyrOffsets[ax];
     }
     for(ax =0; ax <3; ax++){
        gyroDegS[ax] = calibrateGyro[ax] / DEGREE;
        accelMS2[ax] = (calibrateAcc[ax] / RESOLUTION)* GRAVITY;
     }
     /*SprintMsg("Acc X: "); SprintFloat(accelMS2[0]);  SprintLn();
     SprintMsg("Acc Y: "); SprintFloat(accelMS2[1]); SprintLn();
     SprintMsg("Acc Z: "); SprintFloat(accelMS2[2]); SprintLn();*/

     // Compensar la gravedad
     for(axis = 0; axis < 3; axis++){
        gravityDirection[axis] = 0.98 * gravityDirection[axis] + 0.02 * accelMS2[axis];
        accelMS2[axis] -= gravityDirection[axis];
     }

}
float DetectCollision(float accel[3]){
    int v = 0;
 // Calcular magnitud y detectar colisiones
    float magnitude = sqrt(accel[0]*accel[0] + accel[1]*accel[1] + accel[2]*accel[2]);
    //StreamAccel(VALUE, COL, magnitude, accel);
    //if (magnitude > THRESHOLD) {
        //StreamFunction(FLAG, COL, ON);
        /*for(v = 0; v < 3; v++){
           StreamAccel(VALUE, COL, magnitude, accel);
           delay_ms(20);
        }*/
        //return 1;
    //}
    return magnitude;
}
float CalculateNewMagnitude(){
    float magnitude;
    MPU6050_ReadFilter(1);
    magnitude = sqrt(gyroDegS[0] * gyroDegS[0] + gyroDegS[1] * gyroDegS[1]);
    return magnitude;
}
short int DetectLateralFall(long timestamp) {
      float magnitude;
      int v = 0;
      magnitude = sqrt(gyroDegS[0]*gyroDegS[0] + gyroDegS[1]*gyroDegS[1]);
      if (magnitude > ANGULAR_VELOCITY_THRESHOLD) {
            // Posible detecci?n de caida lateral, chequear por cierto tiempo
            float endTime = timestamp + ANGULAR_VELOCITY_DURATION_THRESHOLD;
            while (timeStamp < endTime) {
              float newMagnitude = CalculateNewMagnitude();  // Calculate magnitude at the current time step
              if (newMagnitude > ANGULAR_VELOCITY_THRESHOLD) {
                  //StreamFunction(FLAG, FALL, ON);//Envio trama bluetooth
                  //for(v =0; v < 5; v++){
                      StreamAccel(VALUE, FALL, magnitude, gyroDegS);
                  //}

                  return 1;  // Fall event did not persist for the required duration
              }
            }
            // Confirm fall direction by analyzing angular velocity along the relevant axis (Y-axis)
            if (gyroDegS[1] > ANGULAR_VELOCITY_THRESHOLD) {
                //StreamFunction(FLAG, FALL, ON);//Envio trama bluetooth
                //for(v =0; v < 5; v++){
                    StreamAccel(VALUE, FALL, magnitude, gyroDegS);
                //}
                return 1;  // Lateral fall detected
            }
        }
        return 0;  // No fall detected
}
//BATERIA & SISTEMA ON OFF
void TurnOn(){
     delay_us(15);
     asm CLRWDT;
    //if(!firstTime){
      isOn = 0;
      firstTime = 1;
      pinShutdown = 1;
      delay_ms(5);
      pinBTRst = 1;

    //}
}
void TurnOff(){

     pinLedIndicator = 1;
     delay_ms(500);
     pinLedIndicator = 0;
      delay_ms(500);
     pinLedIndicator = 1;
     delay_ms(500);
     pinLedIndicator = 0;
     pinShutdown = 0;
     firstTime = 0;
     pinBTRst = 0;
     isPress = 0;
     timePress = 0;
     isOn = 0;
     asm sleep;
}
//PIC18F26K22
void InitMicro(){
   //OSC
  OSCCON = 0x70; //16MHz osc interno
  OSCCON2 = 0x00;
  OSCTUNE = 0xAF;
  //Pin analog/digital mode
  ANSELA = 0x03; //Habilita AN0 y AN1 para ADC bat y alc
  ANSELB = 0x00;
  ANSELC = 0x00;
  //Comparadores
  CM1CON0 = 0;
  CM2CON0 = 0;
  CM2CON1 = 0;
  //ADC
  ADCON0 = 0x00;
  ADCON1 = 0x08;
  //Pin in/out mode
  TRISA =  0x27;
  /*
    RA0 -> Bat(%) (IN AN)
    RA1 -> Sensor Alcohol (IN AN)
    RA2 -> Led 0 BT (IN DIG)
    RA3 -> Shutdown (OUT DIG)
    RA4 -> Led Red (OUT DIG)
    RA5 -> PIO0 BT (IN DIG)
    RA6 -> PIO4 BT (OUT DIG)
    RA7 -> PIO5 BT (OUT DIG)
  */
  TRISB = 0x03;
  /*
    RB0 -> Button sensor presion (IN DIG)
    RB1 -> Sensor Temp (IN DIG 1-wire)
    RB2 -> Sensor Alcohol Control (OUT DIG)
    RB3 -> PIO 7 BT (OUT DIG)
    RB4 -> ~RST BT (OUT DIG)
    RB5 -> PIO6 BT (OUT DIG)
  */
  TRISC = 0xA0;
  /*
    RC0 -> PIO3 BT (OUT DIG)
    RC1 -> PIO2 BT (OUT DIG)
    RC2 -> PIO1 BT (OUT DIG)
    RC3 -> SCL MPU (OUT DIG)
    RC4 -> SDA MPU (OUT DIG)
    RC5 -> PIO9 BT (IN DIG)
    RC6 -> TX (OUT DIG)
    RC7 -> RX (IN DIG)
  */
  LATA = 0x00;
  PORTA = 0x00;
  INTCON2.RBPU = 1;

}
void InitInterrupt(){
  //Interrupciones
  ///Timer1
  T1CON = 0x01;
  TMR1IF_bit = 0;
  TMR1H = 0x63;
  TMR1L  = 0xC0;
  TMR1IP_bit = 0;
  TMR1IE_bit = 1;
  INTCON = 0xC0;
  ///Interrupcion flanco
  INT0IE_bit = 1;
  INTEDG0_bit = 1;
  GIE_bit = 1;  //Habilitamos interupciones globales
  IPEN_bit = 1; //Habilitamos niveles de interrupción
  PEIE_bit = 1; //Habilitamos interrupciones perifericas
}
void main() {
   //Microcontrolador
   InitMicro();
   //Interrupciones
   InitInterrupt();
   //ADC
   //ADC_Init();
   //Init Sistem
   TurnOn();
   //UART
   UART1_Init(9600);
   delay_ms(100);
   //Acelerometro
   MPU6050_Init();
   while(1){
     if(isOn){
        //BATERIA & RECALENTAMIENTO
        ///Envio cada 1 segundo de bateria y temperatura del micro
        if(timeToSend > 1){
          pinLedIndicator = !pinLedIndicator;
          StreamFixed(ERROR, CONSOLA, ON);
          tempAlc = GetTemp();
          if(tempAlc == 0){
             StreamFixed(ERROR, TEMPTALC, ON);
          }
          StreamFunction(TEMP, ALC, tempAlc);
          StreamFunction(TEMP, ACCEL, tempMicro);
          SendBattery();
          timeToSend = 0;
        }
        ///Apagar por recalentamiento
        if(tempMicro > 65){
          StreamFunction(SEG, ACCEL, tempMicro);
          delay_ms(100);
          TurnOff();
        }

       //ACELEROMETRO
        MPU6050_ReadFilter(1);
        //SaveSamples(accelMS2, gyroDegS);
        magCol = DetectCollision(accelMS2);
        if(magCol > THRESHOLD){
            //for(v = 0; v < 3; v++){
               StreamAccel(VALUE, COL, magCol, accelMS2);
            //   delay_ms(20);
            //}
          /*pinLedIndicator = 1;
           CalibrateMPU6050(150);
           pinLedIndicator = 0;
           if(veces>3){
             MPU6050_Init();
             timeStamp = 0;
             for(v = 0; v < 3; v++){
                accelMS2[v] = 0.0;
                pinLedIndicator = 1;
               CalibrateMPU6050(150);
               pinLedIndicator = 0;
             }
             veces =0;
           }
           else{
            veces++;
           }*/
            //StreamReport(COL,'X',sampleIndex, samplesAccX);
           //StreamReport(COL,'Y',sampleIndex, samplesAccY);
           //StreamReport(COL,'Z',sampleIndex, samplesAccY);
        }
        if(DetectLateralFall(timeStamp)){
           //StreamReport(FALL,'X',sampleIndex, samplesGyrX);
           //StreamReport(FALL,'Y',sampleIndex, samplesGyrY);
           //StreamReport(FALL,'Z',sampleIndex, samplesGyrY);
        }
        //ALCOHOLIMETRO
       tempAlc = GetTemp();
       if(tempAlc < MAX_ALC_TEMP && tempAlc!= 0){
         if(tempAlc > 22 && secondsHeat > 19){
               if(!isRest){
                  if(secondsReading < 60){
                     gradeAlc = ReadingAlcohol();
                     if(secondsReading != auxSecRead){
                        StreamFixed(STATE, ALC, ON);
                        StreamFunction(TEMP, ALC, tempAlc);
                         if(gradeAlc > 0) {
                            StreamAlcohol(FLAG, gradeAlc, mglAlcohol);
                         }
                         else{
                            StreamAlcohol(VALUE, gradeAlc, mglAlcohol);
                         }
                        auxSecRead = secondsReading;
                     }
                   }
                   else{
                      secondsRest =0;
                      secondsReading = 0;
                      isRest = 1;
                      pinAlcCtrl = 0;

                   }
               }
               else{
                  if(secondsRest!=secondsRestAux){
                    StreamFixed(STATE, ALC, OFF);
                    secondsRestAux = secondsRest;
                  }
                  if(secondsRest > 30){
                     millis = 0;
                     secondsAux = 99;
                     secondsHeat =0;
                     secondsRest =0;
                     isRest =0;
                  }
               }
          }
          else if(secondsHeat != secondsAux){  //calienta sensor envia datos alcoholimetro
             pinAlcCtrl = 1;
             StreamFixed(STATE, ALC, ON);
             if(gradeAlc > 0) {
                StreamAlcohol(FLAG, gradeAlc, mglAlcohol);
             }
             else{
                StreamAlcohol(VALUE, gradeAlc, mglAlcohol);
             }
             secondsAux = secondsHeat;
          }
      }
       else{
          secondsRest =0;
          secondsReading = 0;
          isRest = 1;
          pinAlcCtrl = 0;
        }
        //FUNCIONES DE BOTON
        if(!pinButton && isPress){

           if(timePress > 3 && timePress <= 6){
               //To start matching, long press PIO1
               pinBT1 = 1;
               pinLedIndicator =1;
               delay_ms(2000);
               CalibrateMPU6050(100); //calibración del acelerometro
               pinBT1 = 0;
               pinLedIndicator =0;

           }
           else if(timePress >= 2 && timePress <= 3){
               if(!pinBT0){
                   //Play or Pause
                   pinBT4 = 1;
                   delay_ms(500);
                   pinBT4 = 0;
                }
           }
           else if(timePress <= 1){
                if(!pinBT0){
                   if(pinBT9 && !isPickUp){
                      //delay_ms(500);
                      //if(!pinBT9){
                        //Contestar llamada
                         pinBT1 = 1;
                         delay_ms(500);
                         pinBT1 = 0;
                         isPickUp = 1;
                      //}
                   }
                   else if(!pinBT9 && !isPickUp){
                      //delay_ms(400);
                      //if(pinBT9){
                        //Contestar llamada
                         pinBT1 = 1;
                         delay_ms(500);
                         pinBT1 = 0;
                         isPickUp = 1;
                      //}
                   }
                   else if(pinBT9 && isPickUp){
                        //Colgar llamada
                         pinBT1 = 1;
                         delay_ms(500);
                         pinBT1 = 0;
                         isPickUp =0;
                   }
                }
           }
           else if(timePress > 6){
             TurnOff();
           }
           isPress = 0;
           timePress = 0;
        }
      } //END isOn
     else{
        ///En momento de encendido
         if(firstTime){
             MPU6050_Init();
             //ResetVars();
             CalibrateMPU6050(100); //calibración del acelerometro
             pinLedIndicator = 1;
             pinBT1 = 1;
             delay_ms(4000);
             pinBT1 = 0;
             pinLedIndicator = 0;
             firstTime=0;
             isOn = 1;
        }
     } //END else isOn

   } //END WHILE
} //END MAIN
void int_EXT() iv 0x0008 ics ICS_AUTO  {//HIGH PRIORITY
    GIE_bit = 0;
    //Boton de encendido
    if(INT0IF){
       if(!isOn){
         TurnOn();
         //InitMicro();
         pinLedIndicator = 1;
       }
       else{
         isPress = 1;
       }
       INT0IF_bit = 0;//Limpiamos la bandera
    }
    GIE_bit = 1;
}
void int_EXT2() iv 0x0018 ics ICS_AUTO {//LOW  PRIORITY
    //Temporizador Sensor Alcohol
    if(millis > 100) //1 segundo
    {
      //Alcoholimetro
      secondsHeat++;
      if(isRest) secondsRest++;
      else if(secondsHeat > 19) secondsReading++;
      //Funciones de boton
      if(isPress) timePress++;
      //Funcion de envio trama
      timeToSend++;
      millis = 0;
    }
    if(millisFiveMS > 1){ //200ms
       if(!pinBT0){
         isUntilZero++;
       }
       else{
         isUntilZero = 0;
       }
       millisFiveMS =0;
       //pinLedIndicator = PinBT0;
    }
    millis++;// Interrupcion causa el incremento de millis
    millisFiveMS++;
    timeStamp++;//temporizador para calculo de caida lateral

    TMR1H         = 0x63;
    TMR1L         = 0xC0;
    TMR1IF_bit = 0;
}