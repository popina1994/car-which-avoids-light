#line 1 "C:/Users/popina/Documents/MIPS/pwm/pwm.c"
#line 1 "c:/users/popina/documents/mips/pwm/pwm.h"



static const unsigned int MAX_GEARS = 9;
static const unsigned int PWM_TIME_DELAY_MS = 1000;

void pwmInit();
#line 1 "c:/users/popina/documents/mips/pwm/../wheel/left.h"



extern int wheelLeftCurrentDuty;
static const int WHEEL_LEFT_FREQUENCY_PERIOD = 33;

void wheelLeftInit(const int unsigned int);



void wheelLeftStart();

void wheelLeftStop();
#line 1 "c:/users/popina/documents/mips/pwm/../wheel/right.h"



extern int wheelRightCurrentDuty;
static const int WHEEL_RIGHT_FREQUENCY_PERIOD = 50;

void wheelRightInit(const unsigned int maxGears);



void wheelRightStart();

void wheelRightStop();
#line 5 "C:/Users/popina/Documents/MIPS/pwm/pwm.c"
void pwmInit()
{
 wheelLeftInit(MAX_GEARS);
 wheelRightInit(MAX_GEARS);
 Delay_ms(PWM_TIME_DELAY_MS);
}
