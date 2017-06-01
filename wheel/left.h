#ifndef _WHEEL_LEFT_H_
#define _WHEEL_LEFT_H_

#include "wheel.h"

#define PWM_CHANNEL_LEFT_NUM 4
#define PWM_PIN_LEFT_NAME B
#define PWM_PIN_LEFT_IDX 9
#define PWM_TIMER_LEFT 4


#define PWM_CHANNEL_LEFT_INTERNAL PWM_CHANNEL_INTERNAL(PWM_CHANNEL_LEFT_NUM)
#define PWM_TIMER_LEFT_START  PWM_TIM_START(PWM_TIMER_LEFT)
#define PWM_TIMER_LEFT_STOP PWM_TIM_STOP(PWM_TIMER_LEFT)
#define PWM_TIMER_LEFT_INIT PWM_TIM_INIT(PWM_TIMER_LEFT)
#define PWM_TIMER_LEFT_SET_DUTY PWM_TIM_SET_DUTY(PWM_TIMER_LEFT)
#define PWM_LEFT_MODULE_TIM_CH_PIN PWM_MODULE_TIM_CH_PIN(  \
                            PWM_TIMER_LEFT,                \
                            PWM_CHANNEL_LEFT_NUM,          \
                            PWM_PIN_LEFT_NAME,             \
                            PWM_PIN_LEFT_IDX)

extern int wheelLeftCurrentDuty;
static const int WHEEL_LEFT_FREQUENCY_PERIOD = 33;

void wheelLeftInit(const int unsigned int);

// @ref wheelLeftInit should be called before calling this method.
//
void wheelLeftStart();

void wheelLeftStop();

#endif
