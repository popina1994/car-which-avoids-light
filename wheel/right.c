#include "right.h"

int wheelRightCurrentDuty;

void wheelRightInit(const unsigned int maxGears)
{
     int pwmPeriod = PWM_TIMER_RIGHT_INIT(WHEEL_RIGHT_FREQUENCY_PERIOD);
     wheelRightCurrentDuty = pwmPeriod / maxGears;
}

void wheelRightStart()
{
    PWM_TIMER_RIGHT_SET_DUTY(wheelRightCurrentDuty, _PWM_NON_INVERTED, PWM_CHANNEL_RIGHT_INTERNAL);
    PWM_TIMER_RIGHT_START(PWM_CHANNEL_RIGHT_INTERNAL, &PWM_RIGHT_MODULE_TIM_CH_PIN);
}

void wheelRightStop()
{
    PWM_TIMER_RIGHT_STOP(PWM_CHANNEL_RIGHT_INTERNAL);
}