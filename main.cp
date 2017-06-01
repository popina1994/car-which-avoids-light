#line 1 "C:/Users/popina/Documents/MIPS/main.c"
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
#line 17 "c:/users/popina/documents/mips/light/lightdetector.h"
void lightDetectorInit();

unsigned int getLightVal();
#line 1 "c:/users/popina/documents/mips/timer/timer.h"




static const unsigned TIMER3_PRESCALER[] = { 9, 39, 95, 191, 374, 959 };
static const unsigned TIMER3_ARR[] = { 59999, 59999, 62499, 62499, 63999, 62499 };
static const unsigned int TIMER3_INTERRUPT_MODE = 2;

void timer3Init();
#line 1 "c:/users/popina/documents/mips/logic/light/lightdetection.h"



static const unsigned int MAX_ARR_LEN_LIGHT_VAL = 3;

extern unsigned int lightValueMax;
extern unsigned int lightValueCurMax;
extern unsigned int lightValueDetected;

void resetLightMaxPar();

void updateLightArray();

unsigned int lightValCalcAndUpdate();
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
extern int cnt;
extern int cntFound;


void modeStart(void);
void modeChange(int newMode);
void detectionStart(void);
#line 8 "C:/Users/popina/Documents/MIPS/main.c"
void main() {

 bluetoothInit();
 lightDetectorInit();
 pwmInit();
 timer3Init();
 detectionStart();

 while ( 1 ) {
  asm wfi ;
 Delay_ms( 100 );
 }
}
