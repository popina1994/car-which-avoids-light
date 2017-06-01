#include "left.h"

int wheelLeftCurrentDuty;

void wheelLeftInit(const unsigned int maxGears)
{
     int pwmPeriod = PWM_TIMER_LEFT_INIT(WHEEL_LEFT_FREQUENCY_PERIOD);
     wheelLeftCurrentDuty = pwmPeriod / maxGears;
}

void wheelLeftStart()
{
    PWM_TIMER_LEFT_SET_DUTY(
        wheelLeftCurrentDuty,
        _PWM_NON_INVERTED,
        PWM_CHANNEL_LEFT_INTERNAL);
    PWM_TIMER_LEFT_START(
        PWM_CHANNEL_LEFT_INTERNAL,
        &PWM_LEFT_MODULE_TIM_CH_PIN);
}

void wheelLeftStop()
{
     PWM_TIMER_LEFT_STOP(PWM_CHANNEL_LEFT_INTERNAL);
}
