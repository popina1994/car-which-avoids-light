#include "left.h"
#include "../util/pwm.h"

int wheelLeftCurrentDuty;

void wheelLeftInit()
{
     int pwmPeriod = PWM_TIM4_Init(WHEEL_LEFT_FREQUENCY_PERIOD);
     wheelLeftCurrentDuty = pwmPeriod / MAX_GEARS;
}

void wheelLeftStart()
{
    PWM_TIM4_Set_Duty(wheelLeftCurrentDuty,  _PWM_NON_INVERTED, _PWM_CHANNEL4);
    PWM_TIM4_Start(_PWM_CHANNEL4, &_GPIO_MODULE_TIM4_CH4_PB9);
}

void wheelLeftStop()
{
     PWM_TIM4_Stop(_PWM_CHANNEL4);
}
