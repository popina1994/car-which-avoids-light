#line 1 "C:/Users/popina/Documents/MIPS/logic/movement/movement.c"
#line 1 "c:/users/popina/documents/mips/logic/movement/movement.h"
#line 1 "c:/users/popina/documents/mips/logic/movement/../../util/util.h"
#line 6 "c:/users/popina/documents/mips/logic/movement/movement.h"
static const int MAX_MOVE_CIRCLE = 440;
static const int MAX_MOVE_CIRCLE_HALF = MAX_MOVE_CIRCLE / 2;
static const int MAX_MOVE_BACK = 50;

static const int MOVE_MODE_FORWARD = 0;
static const int MOVE_MODE_CIRCLE = 1;
static const int MOVE_MODE_SEARCH_LIGHT = 2;

extern  char  isPWMInitialized;
extern  char  isStarted;
extern unsigned int moveMode;
extern int stepCnt;
extern int stepCntToDark;


void modeStart(void);
void modeChange(int newMode);
void detectionStart(void);
void timerTicked(void);
#line 1 "c:/users/popina/documents/mips/logic/movement/../light/lightdetection.h"



static const unsigned int MAX_ARR_LEN_LIGHT_VAL = 3;

extern unsigned int lightValueMax;
extern unsigned int lightValueCurMax;
extern unsigned int lightValueDetected;

void resetLightMaxPar();

void updateLightArray();

unsigned int lightValCalcAndUpdate();
#line 1 "c:/users/popina/documents/mips/logic/movement/../../wheel/left.h"
#line 1 "c:/users/popina/documents/mips/logic/movement/../../wheel/wheel.h"
#line 1 "c:/users/popina/documents/mips/logic/movement/../../wheel/../util/util.h"
#line 23 "c:/users/popina/documents/mips/logic/movement/../../wheel/left.h"
extern int wheelLeftCurrentDuty;
static const int WHEEL_LEFT_FREQUENCY_PERIOD = 33;

void wheelLeftInit(const int unsigned int);



void wheelLeftStart();

void wheelLeftStop();
#line 1 "c:/users/popina/documents/mips/logic/movement/../../wheel/right.h"
#line 1 "c:/users/popina/documents/mips/logic/movement/../../wheel/wheel.h"
#line 22 "c:/users/popina/documents/mips/logic/movement/../../wheel/right.h"
extern int wheelRightCurrentDuty;
static const int WHEEL_RIGHT_FREQUENCY_PERIOD = 50;



void wheelRightInit(const unsigned int maxGears);



void wheelRightStart();

void wheelRightStop();
#line 1 "c:/users/popina/documents/mips/logic/movement/../../bluetooth/bluetooth.h"
#line 1 "c:/users/popina/documents/mips/logic/movement/../../bluetooth/../util/util.h"
#line 6 "c:/users/popina/documents/mips/logic/movement/../../bluetooth/bluetooth.h"
static const unsigned int BLUETOOTH_TIME_DELAY_MS = 1000;
static const unsigned int OUTPUT_BUFFER_SIZE = 256;
static const unsigned int BAUD_RATE = 9600;
#line 25 "c:/users/popina/documents/mips/logic/movement/../../bluetooth/bluetooth.h"
void bluetoothInit();

void stringSendViaBluetooth(const char* str);

void intSendIntViaBluetooth(int val);

 char  isBluetoothReadyForTransmission();
#line 7 "C:/Users/popina/Documents/MIPS/logic/movement/movement.c"
 char  isPWMInitialized =  0 ;
 char  isStarted =  0 ;
unsigned int moveMode;
int stepCnt = 0;
int stepCntToDark = -1;

void modeChange(int newMode)
{
 moveMode = newMode;
 isStarted =  0 ;
 switch (newMode)
 {
 case MOVE_MODE_FORWARD:
 stepCnt = MAX_MOVE_BACK;
 break;
 case MOVE_MODE_CIRCLE:
 stepCnt = MAX_MOVE_CIRCLE;
 resetLightMaxPar();
 break;
 case MOVE_MODE_SEARCH_LIGHT:

 stepCntToDark = MAX_MOVE_CIRCLE - stepCntToDark;

 if ( (double)(stepCntToDark) / MAX_MOVE_CIRCLE <= 0.5f)
 {
 stepCnt = MAX_MOVE_CIRCLE_HALF + stepCntToDark;
 }
 else if ((double)(stepCntToDark) / MAX_MOVE_CIRCLE <= 1f)
 {
 stepCnt = stepCntToDark - MAX_MOVE_CIRCLE_HALF;
 }
 break;
 }
}

void modeStart()
{
 isStarted =  1 ;
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

void timerTicked()
{
 if (isPWMInitialized)
 {
 if (!isStarted)
 {
 modeStart();
 }
 if (MOVE_MODE_CIRCLE == moveMode)
 {
 if (stepCnt > 0)
 {
 stepCnt --;
 updateLightArray();
 lightValCalcAndUpdate();
 if (lightValueCurMax > lightValueMax)
 {
 lightValueMax = lightValueCurMax;
 stepCntToDark = stepCnt;
 }
 }
 else
 {
 modeChange(MOVE_MODE_SEARCH_LIGHT);
 }
 }
 else if (MOVE_MODE_FORWARD == moveMode)
 {
 if (stepCnt > 0)
 {
 stepCnt --;
 }
 else
 {
 modeChange(MOVE_MODE_CIRCLE);
 }
 }
 else if (MOVE_MODE_SEARCH_LIGHT == moveMode)
 {
 if (stepCnt > 0)
 {
 stepCnt --;
 }
 else
 {
 modeChange(MOVE_MODE_FORWARD);
 }
 }
 }




 if (isBluetoothReadyForTransmission())
 {
 stringSendViaBluetooth("\n\rlightValueDetected: ");
 intSendIntViaBluetooth(lightValueDetected);

 stringSendViaBluetooth("CurLightValue: ");
 intSendIntViaBluetooth(lightValueCurMax);

 stringSendViaBluetooth("MaxLightValue: ");
 intSendIntViaBluetooth(lightValueMax);

 stringSendViaBluetooth("stepCnt: ");
 intSendIntViaBluetooth(stepCnt);

 stringSendViaBluetooth("stepCntToDark: ");
 intSendIntViaBluetooth(stepCntToDark);

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


void detectionStart()
{
 modeChange(MOVE_MODE_CIRCLE);
 isPWMInitialized =  1 ;
}
