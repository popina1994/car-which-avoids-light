#line 1 "C:/Users/popina/Documents/MIPS/timer/timer.c"
#line 1 "c:/users/popina/documents/mips/timer/timer.h"




static const unsigned TIMER3_PRESCALER[] = { 9, 39, 95, 191, 374, 959 };
static const unsigned TIMER3_ARR[] = { 59999, 59999, 62499, 62499, 63999, 62499 };
static const unsigned int TIMER3_INTERRUPT_MODE = 2;

void timer3Init();
#line 1 "c:/users/popina/documents/mips/timer/../logic/movement/movement.h"
#line 1 "c:/users/popina/documents/mips/timer/../logic/movement/../../util/util.h"
#line 6 "c:/users/popina/documents/mips/timer/../logic/movement/movement.h"
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
#line 4 "C:/Users/popina/Documents/MIPS/timer/timer.c"
void timer3Init(){
 RCC_APB1ENR.TIM3EN = 1;
 TIM3_CR1.CEN = 0;
 TIM3_PSC = TIMER3_PRESCALER[TIMER3_INTERRUPT_MODE];
 TIM3_ARR = TIMER3_ARR[TIMER3_INTERRUPT_MODE];
 NVIC_IntEnable(IVT_INT_TIM3);
 TIM3_DIER.UIE = 1;
 TIM3_CR1.CEN = 1;
}

void interruptTimer3() iv IVT_INT_TIM3 {
 TIM3_SR.UIF = 0;
 timerTicked();
}
