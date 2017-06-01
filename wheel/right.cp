#line 1 "C:/Users/popina/Documents/MIPS/wheel/right.c"
#line 1 "c:/users/popina/documents/mips/wheel/right.h"



extern int wheelRightCurrentDuty;
static const int WHEEL_RIGHT_FREQUENCY_PERIOD = 50;

void wheelRightInit();



void wheelRightStart();

void wheelRightStop();
#line 1 "c:/users/popina/documents/mips/wheel/../util/pwm.h"



static const int MAX_GEARS = 9;
#line 4 "C:/Users/popina/Documents/MIPS/wheel/right.c"
int wheelRightCurrentDuty;

void wheelRightInit()
{
 int pwmPeriod = PWM_TIM4_Init(WHEEL_RIGHT_FREQUENCY_PERIOD);
 wheelRightCurrentDuty = pwmPeriod / MAX_GEARS;
}

void wheelRightStart()
{
 PWM_TIM2_Set_Duty(wheelRightCurrentDuty, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
}

void wheelRightStop()
{
 PWM_TIM2_Stop(_PWM_CHANNEL2);
}
