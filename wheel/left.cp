#line 1 "C:/Users/popina/Documents/MIPS/wheel/left.c"
#line 1 "c:/users/popina/documents/mips/wheel/left.h"
#line 1 "c:/users/popina/documents/mips/wheel/wheel.h"
#line 1 "c:/users/popina/documents/mips/wheel/../util/util.h"
#line 23 "c:/users/popina/documents/mips/wheel/left.h"
extern int wheelLeftCurrentDuty;
static const int WHEEL_LEFT_FREQUENCY_PERIOD = 33;

void wheelLeftInit(const int unsigned int);



void wheelLeftStart();

void wheelLeftStop();
#line 3 "C:/Users/popina/Documents/MIPS/wheel/left.c"
int wheelLeftCurrentDuty;

void wheelLeftInit(const unsigned int maxGears)
{
 int pwmPeriod =  PWM_TIM4_Init (WHEEL_LEFT_FREQUENCY_PERIOD);
 wheelLeftCurrentDuty = pwmPeriod / maxGears;
}

void wheelLeftStart()
{
  PWM_TIM4_Set_Duty (
 wheelLeftCurrentDuty,
 _PWM_NON_INVERTED,
  _PWM_CHANNEL4 );
  PWM_TIM4_Start (
  _PWM_CHANNEL4 ,
 & _GPIO_MODULE_TIM4_CH4_PB9 );
}

void wheelLeftStop()
{
  PWM_TIM4_Stop ( _PWM_CHANNEL4 );
}
