#line 1 "C:/Users/popina/Documents/MIPS/main.c"
#line 1 "c:/users/popina/documents/mips/wheel/left.h"



extern int wheelLeftCurrentDuty;
static const int WHEEL_LEFT_FREQUENCY_PERIOD = 33;

void wheelLeftInit(const int unsigned int);



void wheelLeftStart();

void wheelLeftStop();
#line 1 "c:/users/popina/documents/mips/wheel/right.h"



extern int wheelRightCurrentDuty;
static const int WHEEL_RIGHT_FREQUENCY_PERIOD = 50;

void wheelRightInit(const unsigned int maxGears);



void wheelRightStart();

void wheelRightStop();
#line 1 "c:/users/popina/documents/mips/pwm/pwm.h"



static const unsigned int MAX_GEARS = 9;
static const unsigned int PWM_TIME_DELAY_MS = 1000;

void pwmInit();
#line 1 "c:/users/popina/documents/mips/bluetooth/bluetooth.h"
#line 1 "c:/users/popina/documents/mips/bluetooth/../util/util.h"
#line 6 "c:/users/popina/documents/mips/bluetooth/bluetooth.h"
static const unsigned int BLUETOOTH_TIME_DELAY_MS = 1000;
static const unsigned int OUTPUT_BUFFER_SIZE = 256;

void bluetoothInit();

void stringSendViaBluetooth(const char* str);

void intSendIntViaBluetooth(int val);

 char  isBluetoothReadyForTransmission();
#line 1 "c:/users/popina/documents/mips/light/lightdetector.h"
#line 1 "c:/users/popina/documents/mips/light/../util/util.h"
#line 13 "c:/users/popina/documents/mips/light/lightdetector.h"
void lightDetectorInit();

unsigned int getLightVal();
#line 9 "C:/Users/popina/Documents/MIPS/main.c"
unsigned timer_psc[] = { 9, 39, 95, 191, 374, 959 };
unsigned timer_arr[] = { 59999, 59999, 62499, 62499, 63999, 62499 };

const int TIMER_INTERRUPT_MODE = 2;

int lightValDetected = -1;
const int MAX_ARR_LEN_LIGHT_VAL = 3;
int lightValueArr[MAX_ARR_LEN_LIGHT_VAL] = {0};

const int MAX_MOVE_CIRCLE = 440;
const int MAX_MOVE_CIRCLE_HALF = MAX_MOVE_CIRCLE / 2;
const int MAX_MOVE_BACK = 50;

const int MOVE_MODE_FORWARD = 0;
const int MOVE_MODE_CIRCLE = 1;
const int MOVE_MODE_SEARCH_LIGHT = 2;

int maxLightValue = 0;
int moveMode = -1;
int isStarted = 0;
int cnt = 0;
int cntFound = -1;
int pwmInitialized = 0;
int curMaxLightValue;

void resetLightMaxPar()
{ int idx;
 curMaxLightValue = 0;
 for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++ )
 {
 lightValueArr[idx] = 0;
 }
}

void changeMode(int newMode)
{
 moveMode = newMode;
 isStarted = 0;
 switch (newMode)
 {
 case MOVE_MODE_FORWARD:
 cnt = MAX_MOVE_BACK;
 break;
 case MOVE_MODE_CIRCLE:
 cnt = MAX_MOVE_CIRCLE;
 resetLightMaxPar();
 maxLightValue = 0;
 break;
 case MOVE_MODE_SEARCH_LIGHT:

 cntFound = MAX_MOVE_CIRCLE - cntFound;

 if ( (double)(cntFound) / MAX_MOVE_CIRCLE <= 0.5f)
 {
 cnt = MAX_MOVE_CIRCLE_HALF + cntFound;
 }
 else if ((double)(cntFound) / MAX_MOVE_CIRCLE <= 1f)
 {
 cnt = cntFound - MAX_MOVE_CIRCLE_HALF;
 }
 break;
 }
}

void startMode()
{
 isStarted = 0;
 switch (moveMode)
 {
 case MOVE_MODE_FORWARD:
 wheelRightStart();
 wheelLeftStart();
 break;
 case MOVE_MODE_CIRCLE:
 wheelLeftStop();
 wheelRightStart();
 break;
 case MOVE_MODE_SEARCH_LIGHT:

 wheelRightStart();
 wheelLeftStop();
 break;
 }
}

int calcLightVal()
{
 int idx;
 int min = 30000;
 int max = -1;
 int minIdx = -1;
 int maxIdx = -1;
 int cnt = 0;
 int avg = 0;
 for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
 {
 if (lightValueArr[idx] > max)
 {
 max = lightValueArr[idx];
 maxIdx = idx;
 }

 if (lightValueArr[idx] < min)
 {
 min = lightValueArr[idx];
 minIdx = idx;
 }
 }


 for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
 {
 if ( (idx != minIdx) && (idx != maxIdx))
 {
 cnt ++;
 avg += lightValueArr[idx];
 }
 }
 avg /= cnt;
 return avg;
}

void updateLightArray()
{
 int idx;
 for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL - 1; idx ++)
 {
 lightValueArr[idx] = lightValueArr[idx + 1];
 }
 lightValDetected = getLightVal();
 lightValueArr[MAX_ARR_LEN_LIGHT_VAL - 1]= lightValDetected;
}

void interruptTimer3() iv IVT_INT_TIM3 {

 TIM3_SR.UIF = 0;

 if (pwmInitialized)
 {
 if (!isStarted)
 {
 startMode();
 }
 if (MOVE_MODE_CIRCLE == moveMode)
 {
 if (cnt > 0)
 {
 cnt --;
 updateLightArray();
 curMaxLightValue = calcLightVal();
 if (curMaxLightValue > maxLightValue)
 {
 maxLightValue = curMaxLightValue;
 cntFound = cnt;
 }
 }
 else
 {
 changeMode(MOVE_MODE_SEARCH_LIGHT);
 }
 }
 else if (MOVE_MODE_FORWARD == moveMode)
 {
 if (cnt > 0)
 {
 cnt --;

 }
 else
 {
 changeMode(MOVE_MODE_CIRCLE);
 }
 }
 else if (MOVE_MODE_SEARCH_LIGHT == moveMode)
 {
 if (cnt > 0)
 {
 cnt --;
 }
 else
 {
 changeMode(MOVE_MODE_FORWARD);
 }
 }
 }

 if (isBluetoothReadyForTransmission() )
 {
 stringSendViaBluetooth("\n\rLightValDetected: ");
 intSendIntViaBluetooth(lightValDetected);

 stringSendViaBluetooth("CurLightValue: ");
 intSendIntViaBluetooth(curMaxLightValue);

 stringSendViaBluetooth("MaxLightValue: ");
 intSendIntViaBluetooth(maxLightValue);

 stringSendViaBluetooth("Cnt: ");
 intSendIntViaBluetooth(cnt);

 stringSendViaBluetooth("CntFound: ");
 intSendIntViaBluetooth(cntFound);

 stringSendViaBluetooth("Move:");
 switch (moveMode)
 {
 case MOVE_MODE_FORWARD:
 stringSendViaBluetooth("FORWARD");
 break;
 case MOVE_MODE_CIRCLE:
 stringSendViaBluetooth("CIRCLE");
 break;
 case MOVE_MODE_SEARCH_LIGHT:
 stringSendViaBluetooth("SEARCH_LIGHT");
 break;
 default:
 stringSendViaBluetooth("UNINITIALIZED");
 }
 intSendIntViaBluetooth(-1);
 }

}

void initTimer3(){
 RCC_APB1ENR.TIM3EN = 1;
 TIM3_CR1.CEN = 0;
 TIM3_PSC = timer_psc[TIMER_INTERRUPT_MODE];
 TIM3_ARR = timer_arr[TIMER_INTERRUPT_MODE];
 NVIC_IntEnable(IVT_INT_TIM3);
 TIM3_DIER.UIE = 1;
 TIM3_CR1.CEN = 1;
}

void initPWMLog()
{
 pwmInit();
 changeMode(MOVE_MODE_CIRCLE);

 pwmInitialized = 1;
}

void main() {

 bluetoothInit();
 initTimer3();
 lightDetectorInit();
 initPWMLog();

 while(1) {
 asm wfi;
 Delay_ms(100);
 }
}
