#ifndef _WHEEL_RIGHT_H_
#define _WHEEL_RIGHT_H_

#include "wheel.h"
#define PWM_CHANNEL_RIGHT_NUM 2
#define PWM_PIN_RIGHT_NAME A
#define PWM_PIN_RIGHT_IDX 1
#define PWM_TIMER_RIGHT 2


#define PWM_CHANNEL_RIGHT_INTERNAL PWM_CHANNEL_INTERNAL(PWM_CHANNEL_RIGHT_NUM)
#define PWM_TIMER_RIGHT_START  PWM_TIM_START(PWM_TIMER_RIGHT)
#define PWM_TIMER_RIGHT_STOP PWM_TIM_STOP(PWM_TIMER_RIGHT)
#define PWM_TIMER_RIGHT_INIT PWM_TIM_INIT(PWM_TIMER_RIGHT)
#define PWM_TIMER_RIGHT_SET_DUTY PWM_TIM_SET_DUTY(PWM_TIMER_RIGHT)
#define PWM_RIGHT_MODULE_TIM_CH_PIN PWM_MODULE_TIM_CH_PIN(  \
                            PWM_TIMER_RIGHT,                \
                            PWM_CHANNEL_RIGHT_NUM,          \
                            PWM_PIN_RIGHT_NAME,             \
                            PWM_PIN_RIGHT_IDX)              \

extern int wheelRightCurrentDuty;
static const int WHEEL_RIGHT_FREQUENCY_PERIOD = 50;



void wheelRightInit(const unsigned int maxGears);

// @ref wheelRightInit should be called before calling this method.
//
void wheelRightStart();

void wheelRightStop();

#endif
