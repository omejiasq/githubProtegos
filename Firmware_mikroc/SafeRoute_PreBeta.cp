#line 1 "C:/development/mikroc/dima/1_PreBeta/SafeRoute_PreBeta.c"
#line 26 "C:/development/mikroc/dima/1_PreBeta/SafeRoute_PreBeta.c"
sbit pinBat at RA0_bit;
sbit pinAlcSen at RA1_bit;
sbit pinLed0BT at RA2_bit;
sbit pinShutdown at RA3_bit;
sbit pinLedIndicator at RA4_bit;
sbit pinBT0 at RA5_bit;
sbit pinBT4 at RA6_bit;
sbit pinBT5 at RA7_bit;

sbit pinButton at RB0_bit;
sbit pinTemp at RB1_bit;
sbit pinAlcCtrl at RB2_bit;
sbit pinBT7 at RB3_bit;
sbit pinBTRst at RB4_bit;
sbit pinBT6 at RB5_bit;

sbit pinBT3 at RC0_bit;
sbit pinBT2 at RC1_bit;
sbit pinBT1 at RC2_bit;
sbit pinSCL at RC3_bit;
sbit pinSDA at RC4_bit;
sbit pinBT9 at RC5_bit;
sbit pinTX at RC6_bit;
sbit pinRX at RC7_bit;


int veces = 0;
int v = 0;
float magCol = 0.00;
int tempMicro = 0;

signed long int rawAcc[3] = {0,0,0};
signed long int rawGyr[3] = {0,0,0};

signed long int accelOffsets[3] = {0,0,0};
signed long int gyrOffsets[3] = {0,0,0};

signed long int calibrateAcc[3] = {0,0,0};
signed long int calibrateGyro[3] = {0,0,0};
float accelMS2[3] = {0.0,0.0,0.0};
float gyroDegS[3] = {0.0,0.0,0.0};
float gravityDirection[3] = {0.0,0.0,0.0};
signed long int filteredData[3] = {0,0,0};
signed long int filteredGyro[3] = {0,0,0};

long timeStamp = 0;

short int sampleIndex = 0;
float samplesAccX[ 20 ];
float samplesAccY[ 20 ];
float samplesAccZ[ 20 ];
float samplesGyrX[ 20 ];
float samplesGyrY[ 20 ];
float samplesGyrZ[ 20 ];


unsigned int millis = 0;
unsigned int millisFiveMS =0;
char seconds[2];


short int isOn = 0;
short int isPress = 0;
int timePress = 0;
short int firstTime = 0;
int timesBateryReads = 0;
float batteryPorc = 0.00;


const unsigned short TEMP_RESOLUTION = 0xFE;



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

 isPress = 0;
 timePress = 0;
 timesBateryReads = 0;
 batteryPorc = 0.00;

 millis = 0;
 millisFiveMS =0;

 timeToSend =0;

 veces = 0;
 v = 0;
 magCol = 0.00;
 tempMicro = 0;
#line 181 "C:/development/mikroc/dima/1_PreBeta/SafeRoute_PreBeta.c"
}

void UART_Send_String(char *dat) {

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
 stream[2] = sensor;
 stream[3] = state;
 stream[4] = END;
 UART_Send_String(stream);

}
void StreamFunction(char function, char sensor, float value){
 char text[5];
 char stream[20] = "";
 int caracter = 0;
 int charac = 3;
 stream[0] = INIT;
 stream[1] = function;
 stream[2] = sensor;
 sprintf(text,"%.1f",value);
 for(caracter = 0; caracter < strlen(text); caracter++){
 if(text[caracter]!= '.') {
 stream[charac] = text[caracter];
 charac++;
 }
 }
 stream[charac] = END;
 UART_Send_String(stream);

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
 stream[charac] = event;
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

}
void StreamAlcohol(char function, int grade, float cienMgsMl){
 char text[12];
 char grad[1];
 char stream[100] = "";
 int caracter = 0;
 int charac = 5;
 stream[0] = INIT;
 stream[1] = function;
 stream[2] = ALC;
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

}

int GetTemp(){
 int tempe = 0;

 Ow_Reset(&PORTB, 1);
 Ow_Write(&PORTB, 1, 0xCC);
 Ow_Write(&PORTB, 1, 0x44);
 delay_ms(20);


 Ow_Reset(&PORTB, 1);
 Ow_Write(&PORTB, 1, 0xCC);
 Ow_Write(&PORTB, 1, 0xBE);

 tempe = Ow_Read(&PORTB, 1);
 tempe &= TEMP_RESOLUTION;
 tempe = (Ow_Read(&PORTB, 1) << 8) + tempe;
 tempe = tempe/16;

 return tempe;
}

float ReadADC(int channel){
 float reference = 0.00;
 float avarage = 0;
 float batReference = 3.28;
 int bitsReadADC = 1024;


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

 if(rawBattery*2 > 4.2){
 rawBattery -= rawBattery*0.16;
 }
 porcBattery = porcMin + (rawBattery-voltMin)*((porcMax - porcMin)/(voltMax - voltMin));
 return porcBattery;
}
void SendBattery(){

 batteryPorc = GetBatteryPorcent();
 StreamFunction(STATE, BAT, batteryPorc);
 if(batteryPorc < 29)
 StreamFixed(SEG, LOW_BAT, ON);
}
short int ReadingAlcohol(){
#line 387 "C:/development/mikroc/dima/1_PreBeta/SafeRoute_PreBeta.c"
 short int gradeAlcohol = 0;
 float maxmG = 1500.00;
 float minmG = 50.00;
 float minVolt=0.8;
 float maxVolt = 2.50;
 float rawAlcohol = ReadADC(1);

 mglAlcohol = minmG + (((rawAlcohol-minVolt)/(maxVolt-minVolt))*(maxmG-minmG));
 mglAlcohol -= 200.0;


 if(mglAlcohol <=390.0 )
 {
 if(mglAlcohol < 0) mglAlcohol = 0.00;
 gradeAlcohol = 0;
 }
 else if(mglAlcohol >= 400.0 && mglAlcohol<= 990.0)
 {
 gradeAlcohol = 1;
 }
 else if(mglAlcohol >= 1000.0 && mglAlcohol<= 1490.0)
 {
 gradeAlcohol = 2;
 }
 else if(mglAlcohol >= 1500.0)
 {
 gradeAlcohol = 3;
 }

 return gradeAlcohol;
}

void MPU6050_Init()
{
 I2C1_Init(400000);
 Delay_ms(100);

 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr( 0x19 );
 I2C1_Wr(0x07);
 I2C1_Stop();

 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr( 0x6B );
 I2C1_Wr(0x02);

 I2C1_Stop();

 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr( 0x1A );
 I2C1_Wr(0x00);
 I2C1_Stop();

 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr( 0x1C );
 I2C1_Wr(0x18);
 I2C1_Stop();

 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr( 0x1B );

 I2C1_Wr(0x00);
 I2C1_Stop();
}
void MPU6050_Read(){
 I2C1_Start();
 I2C1_Wr(  0xD0  );
 I2C1_Wr(  0x3B  );
 I2C1_Stop();
 I2C1_Start();
 I2C1_Wr( 0xD0  | 1);
 rawAcc[0] = (I2C1_Rd(1) << 8) | I2C1_Rd(1);
 rawAcc[1] = (I2C1_Rd(1) << 8) | I2C1_Rd(1);
 rawAcc[2] = (I2C1_Rd(1) << 8) | I2C1_Rd(1);
 tempMicro = (I2C1_Rd(1) << 8) | I2C1_Rd(1);
 rawGyr[0] = (I2C1_Rd(1) << 8) | I2C1_Rd(1);
 rawGyr[1] = (I2C1_Rd(1) << 8) | I2C1_Rd(1);
 rawGyr[2] = (I2C1_Rd(1) << 8) | I2C1_Rd(0);
 I2C1_Stop();
 tempMicro += 12421;
 tempMicro /= 340;
}

void LowPassFilter(signed long int rawData[3], signed long int rawGyro[3]) {
 short int axis = 0;
 for (axis = 0; axis < 3; axis++) {
 filteredData[axis] =  0.2  * rawData[axis] + (1 -  0.2 ) * filteredData[axis];
 filteredGyro[axis] =  0.2  * rawGyro[axis] + (1 -  0.2 ) * filteredGyro[axis];
 }
}
void CalibrateMPU6050(int samples) {
 int sample = 0;
 short int axis = 0;

 for (sample = 0; sample < samples; sample++) {

 MPU6050_Read();
 pinLedIndicator = 1;



 LowPassFilter(rawAcc, rawGyr);
 delay_ms(10);
 }

 for (sample = 0; sample < samples; sample++) {
 for (axis = 0; axis < 3; axis++) {
 accelOffsets[axis] += filteredData[axis];
 gyrOffsets[axis] += filteredGyro[axis];
 }
 delay_ms(10);
 }
 for (axis = 0; axis < 3; axis++) {
 accelOffsets[axis] /= samples;
 gyrOffsets[axis] /= samples;
 }
 SprintMsgLn("Sensor Calibrado!");
 SprintMsgLn("Offsets:");
 SprintMsg("Offset X: "); SprintInt(accelOffsets[0]); SprintLn();
 SprintMsg("Offset Y: "); SprintInt(accelOffsets[1]); SprintLn();
 SprintMsg("Offset Z: "); SprintInt(accelOffsets[2]); SprintLn();
 ShowData("Temperatura Micro: ", tempMicro);

}
void MPU6050_ReadFilter(unsigned int samples){
 int sample =0;
 short int axis = 0;
 short int ax = 0;

 for(sample = 0; sample < samples; sample++){
 MPU6050_Read();
 LowPassFilter(rawAcc, rawGyr);
 }

 for(ax =0; ax < 3; ax++){
 calibrateAcc[ax] = filteredData[ax] - accelOffsets[ax];
 calibrateGyro[ax] = filteredGyro[ax] - gyrOffsets[ax];
 }
 for(ax =0; ax <3; ax++){
 gyroDegS[ax] = calibrateGyro[ax] /  131.0 ;
 accelMS2[ax] = (calibrateAcc[ax] /  16384.0 )*  9.81 ;
 }
#line 539 "C:/development/mikroc/dima/1_PreBeta/SafeRoute_PreBeta.c"
 for(axis = 0; axis < 3; axis++){
 gravityDirection[axis] = 0.98 * gravityDirection[axis] + 0.02 * accelMS2[axis];
 accelMS2[axis] -= gravityDirection[axis];
 }

}
float DetectCollision(float accel[3]){
 int v = 0;

 float magnitude = sqrt(accel[0]*accel[0] + accel[1]*accel[1] + accel[2]*accel[2]);
#line 558 "C:/development/mikroc/dima/1_PreBeta/SafeRoute_PreBeta.c"
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
 if (magnitude >  500.0 ) {

 float endTime = timestamp +  5 ;
 while (timeStamp < endTime) {
 float newMagnitude = CalculateNewMagnitude();
 if (newMagnitude >  500.0 ) {


 StreamAccel(VALUE, FALL, magnitude, gyroDegS);


 return 1;
 }
 }

 if (gyroDegS[1] >  500.0 ) {


 StreamAccel(VALUE, FALL, magnitude, gyroDegS);

 return 1;
 }
 }
 return 0;
}

void TurnOn(){
 delay_us(15);
 asm CLRWDT;

 isOn = 0;
 firstTime = 1;
 pinShutdown = 1;
 delay_ms(5);
 pinBTRst = 1;


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

void InitMicro(){

 OSCCON = 0x70;
 OSCCON2 = 0x00;
 OSCTUNE = 0xAF;

 ANSELA = 0x03;
 ANSELB = 0x00;
 ANSELC = 0x00;

 CM1CON0 = 0;
 CM2CON0 = 0;
 CM2CON1 = 0;

 ADCON0 = 0x00;
 ADCON1 = 0x08;

 TRISA = 0x27;
#line 654 "C:/development/mikroc/dima/1_PreBeta/SafeRoute_PreBeta.c"
 TRISB = 0x03;
#line 663 "C:/development/mikroc/dima/1_PreBeta/SafeRoute_PreBeta.c"
 TRISC = 0xA0;
#line 674 "C:/development/mikroc/dima/1_PreBeta/SafeRoute_PreBeta.c"
 LATA = 0x00;
 PORTA = 0x00;
 INTCON2.RBPU = 1;

}
void InitInterrupt(){


 T1CON = 0x01;
 TMR1IF_bit = 0;
 TMR1H = 0x63;
 TMR1L = 0xC0;
 TMR1IP_bit = 0;
 TMR1IE_bit = 1;
 INTCON = 0xC0;

 INT0IE_bit = 1;
 INTEDG0_bit = 1;
 GIE_bit = 1;
 IPEN_bit = 1;
 PEIE_bit = 1;
}
void main() {

 InitMicro();

 InitInterrupt();



 TurnOn();

 UART1_Init(9600);
 delay_ms(100);

 MPU6050_Init();
 while(1){
 if(isOn){


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

 if(tempMicro > 65){
 StreamFunction(SEG, ACCEL, tempMicro);
 delay_ms(100);
 TurnOff();
 }


 MPU6050_ReadFilter(1);

 magCol = DetectCollision(accelMS2);
 if(magCol >  40.0 ){

 StreamAccel(VALUE, COL, magCol, accelMS2);
#line 762 "C:/development/mikroc/dima/1_PreBeta/SafeRoute_PreBeta.c"
 }
 if(DetectLateralFall(timeStamp)){



 }

 tempAlc = GetTemp();
 if(tempAlc <  70  && tempAlc!= 0){
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
 else if(secondsHeat != secondsAux){
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

 if(!pinButton && isPress){

 if(timePress > 3 && timePress <= 6){

 pinBT1 = 1;
 pinLedIndicator =1;
 delay_ms(2000);
 CalibrateMPU6050(100);
 pinBT1 = 0;
 pinLedIndicator =0;

 }
 else if(timePress >= 2 && timePress <= 3){
 if(!pinBT0){

 pinBT4 = 1;
 delay_ms(500);
 pinBT4 = 0;
 }
 }
 else if(timePress <= 1){
 if(!pinBT0){
 if(pinBT9 && !isPickUp){



 pinBT1 = 1;
 delay_ms(500);
 pinBT1 = 0;
 isPickUp = 1;

 }
 else if(!pinBT9 && !isPickUp){



 pinBT1 = 1;
 delay_ms(500);
 pinBT1 = 0;
 isPickUp = 1;

 }
 else if(pinBT9 && isPickUp){

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
 }
 else{

 if(firstTime){
 MPU6050_Init();

 CalibrateMPU6050(100);
 pinLedIndicator = 1;
 pinBT1 = 1;
 delay_ms(4000);
 pinBT1 = 0;
 pinLedIndicator = 0;
 firstTime=0;
 isOn = 1;
 }
 }

 }
}
void int_EXT() iv 0x0008 ics ICS_AUTO {
 GIE_bit = 0;

 if(INT0IF){
 if(!isOn){
 TurnOn();

 pinLedIndicator = 1;
 }
 else{
 isPress = 1;
 }
 INT0IF_bit = 0;
 }
 GIE_bit = 1;
}
void int_EXT2() iv 0x0018 ics ICS_AUTO {

 if(millis > 100)
 {

 secondsHeat++;
 if(isRest) secondsRest++;
 else if(secondsHeat > 19) secondsReading++;

 if(isPress) timePress++;

 timeToSend++;
 millis = 0;
 }
 if(millisFiveMS > 1){
 if(!pinBT0){
 isUntilZero++;
 }
 else{
 isUntilZero = 0;
 }
 millisFiveMS =0;

 }
 millis++;
 millisFiveMS++;
 timeStamp++;

 TMR1H = 0x63;
 TMR1L = 0xC0;
 TMR1IF_bit = 0;
}
