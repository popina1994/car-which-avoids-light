#include "right.h"
#include "../util/pwm.h"

int wheelRightCurrentDuty;

void wheelRightInit()
{
     int pwmPeriod = PWM_TIM4_Init(WHEEL_RIGHT_FREQUENCY_PERIOD);
     wheelRightCurrentDuty = pwmPeriod / MAX_GEARS;
}

void wheelRightStart()
{
    PWM_TIM2_Set_Duty(wheelRightCurrentDuty,  _PWM_NON_INVERTED, _PWM_CHANNEL2);
    PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
}

void wheelRightStop()
{
    PWM_TIM2_Stop(_PWM_CHANNEL2);
}
